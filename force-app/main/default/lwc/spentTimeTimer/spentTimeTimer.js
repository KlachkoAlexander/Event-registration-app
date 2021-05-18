import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, updateRecord, getRecordNotifyChange } from 'lightning/uiRecordApi';
import SPENTMINUTES_FIELD from '@salesforce/schema/Account.MinutesSpent__c';
import ID_FIELD from '@salesforce/schema/Account.Id';

export default class SpentTimeTimer extends LightningElement {
	@api recordId;
	spentMinutes;
	timer = '00:00:00';
	@wire(getRecord, { recordId: '$recordId', fields: [SPENTMINUTES_FIELD] })
	wiredRecord({ error, data }) {
		if (error) {
			let message = 'Unknown error';
			if (Array.isArray(error.body)) {
				message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				message = error.body.message;
			}
			this.dispatchEvent(
				new ShowToastEvent({
					title: 'Error loading account',
					message,
					variant: 'error',
				}),
			);
		} else if (data) {
			this.account = data;
			this.spentMinutes = this.account.fields.MinutesSpent__c.value;
		}
	}
	get isMinute() {
		return this.spentMinutes < 2 ? true : false;
	}

	isExecuting = false;
	spentMilliseconds = 0;
	timeInterval;
	url;
	isShowTime = false;

	handleStart() {
		this.isShowTime = false;
		this.isExecuting = true;
		const parentThis = this;
		this.url = window.location.href;
		this.timeInterval = setInterval(function() {
			const hours = Math.floor((parentThis.spentMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			const minutes = Math.floor((parentThis.spentMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
			const seconds = Math.floor((parentThis.spentMilliseconds % (1000 * 60)) / 1000);

			parentThis.timer = (hours < 10 ? ('0' + hours) : hours) + ':' + (minutes < 10 ? ('0' + minutes) : minutes) +
				':' + (seconds < 10 ? ('0' + seconds) : seconds);

			parentThis.spentMilliseconds += 1000;
			if (parentThis.url !== window.location.href) {
				parentThis.isShowTime = false;
				parentThis.menageStop(true);
			}
		}, 1000);
	}
	handleStop() {
		this.isShowTime = true;
		this.menageStop(false);
	}
	menageStop(isManual) {
		this.isExecuting = false;
		clearInterval(this.timeInterval);
		const minutes = Math.floor(this.spentMilliseconds / 60000);
		const fields = {};
		fields[ID_FIELD.fieldApiName] = this.recordId;
		fields[SPENTMINUTES_FIELD.fieldApiName] = this.spentMinutes + minutes;
		this.spentMilliseconds = 0;
		this.timer = '00:00:00';
		const recordInput = { fields };
		updateRecord(recordInput)
		.then(() => {
			getRecordNotifyChange([{recordId: this.recordId}]);
		})
		.catch(error => {
			this.dispatchEvent(
				new ShowToastEvent({
					title: 'Error updating record',
					message: error.body.message,
					variant: 'error'
				})
			);
		});
	}
}