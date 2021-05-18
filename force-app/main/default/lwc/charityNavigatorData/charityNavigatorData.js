import { LightningElement, wire, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getData from '@salesforce/apex/CharityNavigatorDataController.getData';
import ID_FIELD from '@salesforce/schema/Account.Id';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import EIN_FIELD from '@salesforce/schema/Account.EIN__c';
import BILLINGCITY_FIELD from '@salesforce/schema/Account.BillingCity';
import BILLING_COUNTRY_FIELD from '@salesforce/schema/Account.BillingCountry';
import BILLING_POSTAL_CODE_FIELD from '@salesforce/schema/Account.BillingPostalCode';
import BILLING_STATE_FIELD from '@salesforce/schema/Account.BillingState';
import BILLING_STREET_FIELD from '@salesforce/schema/Account.BillingStreet';
import ASSET_AMOUNT_FIELD from '@salesforce/schema/Account.AssetAmount__c';
import IRS_CLASSIFICATION_FIELD from '@salesforce/schema/Account.IRSClassification__c';
import EXEMPT_ORG_STATUS_FIELD from '@salesforce/schema/Account.ExemptOrgStatus__c';
import INCOME_AMOUNT_FIELD from '@salesforce/schema/Account.IncomeAmount__c';
import RULLING_DATE_FIELD from '@salesforce/schema/Account.RulingDate__c';
import ACCOUNTING_PERIOD_FIELD from '@salesforce/schema/Account.AccountingPeriod__c';

const NUMBER_SHOW_ELEMENTS = 10;
export default class CharityNavigatorData extends LightningElement {
	appId;
	appKey;
	response;
	organizations;
	isRated = true;
	isFundraisingOrgs = true;
	isLoaded = true;
	isMoreOnePage = false;
	searchKey;
	pageSize;
	page;
	helpSearch = 'A simple search string that narrows the results to organizations matching the specified search terms.' +
		' By default, the search looks for matches in all string or text properties.' +
		' The searchType parameter can change the field values included in the search.';
	helpSearchType = 'Used in combination with the search parameter, specifies the type of search to be performed. Default - Search in all string properties.' +
		'Name only - Search only in the Organization name.';
	helpRated = 'Specifies whether to include only rated charities or unrated charities.';
	helpFundraisingOrgs = 'Specifies whether to include or exclude organizations flagged by Charity Navigator as fundraising organizations.';
	helpScopeOfWork = 'Filters search results to include only organizations with a given scope of work.';
	helpPageSize = 'Number of organizations to return in a single response message.';
	@api recordId;

	searchTypeValue = 'DEFAULT';

	get searchTypeOptions() {
		return [
			{ label: 'All properties', value: 'DEFAULT' },
			{ label: 'Name only', value: 'NAME_ONLY' }
		];
	}

	ratedValue = 'All';

	get ratedOptions() {
		return [
			{ label: 'Rated', value: 'TRUE' },
			{ label: 'All', value: 'All' },
			{ label: 'Unrated', value: 'FALSE' },
		];
	}

	fundraisingOrgsValue = 'All';

	get fundraisingOrgsOptions() {
		return [
			{ label: 'Fundraising', value: 'TRUE' },
			{ label: 'All', value: 'All' },
			{ label: 'Not fundraising', value: 'FALSE' },
		];
	}

	scopeOfWorkValue = 'All';

	get scopeOfWorkOptions() {
		return [
			{ label: 'All', value: 'All' },
			{ label: 'Regional', value: 'REGIONAL' },
			{ label: 'National ', value: 'NATIONAL' },
			{ label: 'International', value: 'INTERNATIONAL' },
		];
	}
	handleSearchKey(event) {
		this.searchKey = event.detail.value;
	}
	handleFundraisingOrgs(event) {
		this.fundraisingOrgsValue = event.detail.value;
	}
	handleRated(event) {
		this.ratedValue = event.detail.value;
	}
	handleSearchType(event) {
		this.searchType = event.detail.value;
	}
	handleScopeOfWork(event) {
		this.scopeOfWorkValue = event.detail.value;
	}
	handlePageSize(event) {
		this.pageSize = event.detail.value;
	}
	handleSearchClick() {
		this.isLoaded = false;
		let search = '';
		if (this.searchKey) {
			search += '&search=' + this.searchKey;
		}
		if (this.searchTypeValue) {
			search += '&searchType=' + this.searchTypeValue;
		}
		if (this.ratedValue !== 'All') {
			search += '&rated=' + this.ratedValue;
		}
		if (this.fundraisingOrgsValue !== 'All') {
			search += '&fundraisingOrgs=' + this.fundraisingOrgsValue;
		}
		if (this.scopeOfWorkValue !== 'All') {
			search += '&scopeOfWork=' + this.scopeOfWorkValue;
		}
		if (this.pageSize) {
			search += '&pageSize=' + this.pageSize;
		}
		const encodedSearch = encodeURI(search);
		getData({search: encodedSearch})
		.then(result => {
			this.response = result;
			this.organizations = result.slice(0, NUMBER_SHOW_ELEMENTS);
			if (this.response.length > NUMBER_SHOW_ELEMENTS) {
				this.isMoreOnePage = true;
				this.page = 1;
			}
			this.isLoaded = true;
		})
		.catch(error => {
			let message = 'Unknown error';
			if (Array.isArray(error.body)) {
				message = error.body.map(e => e.message).join(', ');
			} else if (typeof error.body.message === 'string') {
				message = error.body.message;
			}
			this.isLoaded = true;
			this.dispatchEvent(
				new ShowToastEvent({
					title: 'Error loading credentials',
					message,
					variant: 'error',
				}),
			);
		});
	}
	handlePrevious() {
		if (this.page > 1) {
			this.page = this.page - 1;
			const skip = ((this.page - 1) * NUMBER_SHOW_ELEMENTS);
			this.organizations = this.response.slice(skip, skip + NUMBER_SHOW_ELEMENTS);
		}
	}

	handleNext() {
		this.page = this.page + 1;
		const skip = ((this.page - 1) * NUMBER_SHOW_ELEMENTS);
		this.organizations = this.response.slice(skip, skip + NUMBER_SHOW_ELEMENTS);
	}
	handleCellClick(event){
		if (event.currentTarget.id) {
			const splitedId = event.currentTarget.id.split('-');
			const selectedId = splitedId[0];
			const organization = this.organizations[selectedId];
			const fields = {};
			fields[ID_FIELD.fieldApiName] = this.recordId;
			fields[NAME_FIELD.fieldApiName] = organization.charityName;
			fields[EIN_FIELD.fieldApiName] = organization.ein;
			fields[BILLINGCITY_FIELD.fieldApiName] = organization.mailingAddress.city;
			fields[BILLING_COUNTRY_FIELD.fieldApiName] = organization.mailingAddress.country;
			fields[BILLING_POSTAL_CODE_FIELD.fieldApiName] = organization.mailingAddress.postalCode;
			fields[BILLING_STATE_FIELD.fieldApiName] = organization.mailingAddress.stateOrProvince;
			fields[BILLING_STREET_FIELD.fieldApiName] = organization.mailingAddress.streetAddress1;
			fields[ASSET_AMOUNT_FIELD.fieldApiName] = organization.irsClassification.assetAmount;
			fields[IRS_CLASSIFICATION_FIELD.fieldApiName] = organization.irsClassification.classification;
			fields[EXEMPT_ORG_STATUS_FIELD.fieldApiName] = organization.irsClassification.exemptOrgStatus;
			fields[INCOME_AMOUNT_FIELD.fieldApiName] = organization.irsClassification.incomeAmount;
			fields[RULLING_DATE_FIELD.fieldApiName] = organization.irsClassification.rulingDate;
			fields[ACCOUNTING_PERIOD_FIELD.fieldApiName] = organization.irsClassification.accountingPeriod;
			const recordInput = { fields };
			updateRecord(recordInput)
			.then(() => {
				this.dispatchEvent(
					new ShowToastEvent({
						title: 'Success',
						message: 'Record has been updated',
						variant: 'success'
					})
				);
				getRecordNotifyChange([{recordId: this.recordId}]);
			})
			.catch(error => {
				let message = 'Unknown error';
				if (Array.isArray(error.body)) {
					message = error.body.map(e => e.message).join(', ');
				} else if (typeof error.body.message === 'string') {
					message = error.body.message;
				}
				this.dispatchEvent(
					new ShowToastEvent({
						title: 'Error updating record',
						message: message,
						variant: 'error'
					})
				);
			});
		}
	}
}