trigger BonusPayoutTrigger on BonusPayout__c (before insert) {
	TriggerHandler_BonusPayout.validateCreationOnlyOneRecordPerMonth(Trigger.new);
}