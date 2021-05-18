trigger AttendeeTrigger on Attendee__c (before insert, before update) {
	fflib_SObjectDomain.triggerHandler(Attendees.class);
}