trigger EventTrigger on Event__c (before insert) {
	TriggerHandler_Event.validateNumberCreatedEventsPerUser(Trigger.new);
}