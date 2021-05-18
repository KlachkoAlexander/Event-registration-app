public with sharing class TriggerHandler_Event {
	public static void validateNumberCreatedEventsPerUser(List<Event__c> events) {
		date firstDayCurrentMonth = Date.today().toStartOfMonth();
		date firstDayNextMonth = firstDayCurrentMonth.addMonths(1);
		List<Event__c> createdEvents = [
			SELECT Id
			FROM Event__c 
			WHERE CreatedDate >= :firstDayCurrentMonth AND CreatedDate < :firstDayNextMonth AND CreatedById = :UserInfo.getUserId()
		];
		OrgSettings__c orgSettings = OrgSettings__c.getOrgDefaults();
		if (orgSettings.MaxNumberEventsPerUser__c != null) {
			Integer allowedSave = Integer.valueOf(orgSettings.MaxNumberEventsPerUser__c) - createdEvents.size();
			System.Debug(createdEvents.size() + ' ' + orgSettings.MaxNumberEventsPerUser__c);
			if (allowedSave < 0) {
				allowedSave = 0;
			}
			System.Debug('allowedSave=' + allowedSave);
			for (Integer i = allowedSave; i < events.size(); i++) {
				events[i].addError('Too many Events created this month for user ' + UserInfo.getUserName() + ' (' + UserInfo.getUserId()
					 + '): ' + orgSettings.MaxNumberEventsPerUser__c
				);
			}
		}
	}
}
