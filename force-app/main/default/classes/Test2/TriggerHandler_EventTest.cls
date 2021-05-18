@IsTest
public with sharing class TriggerHandler_EventTest {
	@testSetup private static void setup() {
		List<Event__c> events = new List<Event__c>{
			new Event__c(Name = 'Event 1'),
			new Event__c(Name = 'Event 2'),
			new Event__c(Name = 'Event 3'),
			new Event__c(Name = 'Event 4'),
			new Event__c(Name = 'Event 5'),
			new Event__c(Name = 'Event 6')
		};
		insert events;
		System.assertEquals(6, [SELECT Id FROM Event__c].size());
	}
	@IsTest
	static void validateNumberCreatedEventsPerUserTest() {
		OrgSettings__c orgSettings = OrgSettings__c.getOrgDefaults();
		orgSettings.MaxNumberEventsPerUser__c = 7;
		insert orgSettings;
		Test.startTest();
		insert new Event__c(Name = 'Event 7');
		Boolean flag = true;
		try {
			insert new Event__c(Name = 'Event 8');
			flag = false;
		} catch (Exception ex) {
			System.assert(ex.getMessage().contains('Too many Events created this month for user ' + UserInfo.getUserName() + 
				' (' + UserInfo.getUserId() + '): ' + orgSettings.MaxNumberEventsPerUser__c));
		}
		Test.stopTest();
		System.assertEquals(true, flag);
	}
	@IsTest
	static void validateNumberCreatedEventsPerUserPartialSavingTest() {
		OrgSettings__c orgSettings = OrgSettings__c.getOrgDefaults();
		orgSettings.MaxNumberEventsPerUser__c = 8;
		insert orgSettings;
		List<Event__c> events = new List<Event__c> {
			new Event__c(Name = 'Event 7'),
			new Event__c(Name = 'Event 8'),
			new Event__c(Name = 'Event 9'),
			new Event__c(Name = 'Event 10'),
			new Event__c(Name = 'Event 11')
		};
		Test.startTest();
		Database.SaveResult[] saveResults = Database.insert(events, false);
		Test.stopTest();
		Integer count = 0;
		Integer countError = 0;
		for (Database.SaveResult sr :saveResults) {
			if (sr.isSuccess()) {
				count++;
			} else {
				for(Database.Error err : sr.getErrors()) {
					countError++;
					System.assertEquals('Too many Events created this month for user ' + UserInfo.getUserName() + ' (' +
						UserInfo.getUserId() + '): ' + orgSettings.MaxNumberEventsPerUser__c, err.getMessage());
				}
			}
		}
		System.assertEquals(2, count);
		System.assertEquals(3, countError);
	}
}
