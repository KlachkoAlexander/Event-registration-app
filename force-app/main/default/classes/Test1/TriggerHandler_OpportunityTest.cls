@IsTest
public with sharing class TriggerHandler_OpportunityTest {
	@IsTest
	public static void closeOpportunity() {
		Date today = Date.today();
		List<Account> accounts = new List<Account> {
			new Account(Name = 'Account 1'),
			new Account(Name = 'Account 2', CustomField__c = 10),
			new Account(Name = 'Account 2', CustomField__c = 12)
		};
		insert accounts;
		List<Opportunity> opportunities = new List<Opportunity> {
			new Opportunity(Name = 'Opportunity 1', CloseDate = today.addDays(-1), StageName = 'Qualification'),
			new Opportunity(Name = 'Opportunity 2', AccountId = accounts[0].Id, CloseDate = today.addDays(-1), StageName = 'Qualification'),
			new Opportunity(Name = 'Opportunity 3', AccountId = accounts[1].Id, CloseDate = today.addDays(-2), StageName = 'Qualification'),
			new Opportunity(Name = 'Opportunity 4', AccountId = accounts[2].Id, CloseDate = today.addDays(-3), StageName = 'Qualification'),
			new Opportunity(Name = 'Opportunity 5', AccountId = accounts[2].Id, CloseDate = today, StageName = 'Qualification')
		};
		Test.startTest();
		insert opportunities;
		Test.stopTest();

		Map<Id, Opportunity> idToOpportynity = new Map<Id, Opportunity>([SELECT Id, StageName, RecordTypeId, CustomField__c FROM Opportunity]);
		Id recordTypeRenewalId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName()
		.get('renewal').getRecordTypeId();
		Id recordTypeNewId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName()
		.get('New').getRecordTypeId();
		System.assertEquals('Closed', idToOpportynity.get(opportunities[0].Id).StageName);
		System.assertEquals(null, idToOpportynity.get(opportunities[0].Id).CustomField__c);
		System.assertEquals(recordTypeRenewalId, idToOpportynity.get(opportunities[0].Id).RecordTypeId);

		System.assertEquals('Closed', idToOpportynity.get(opportunities[1].Id).StageName);
		System.assertEquals(null, idToOpportynity.get(opportunities[1].Id).CustomField__c);
		System.assertEquals(recordTypeRenewalId, idToOpportynity.get(opportunities[1].Id).RecordTypeId);

		System.assertEquals('Closed', idToOpportynity.get(opportunities[2].Id).StageName);
		System.assertEquals(accounts[1].CustomField__c, idToOpportynity.get(opportunities[2].Id).CustomField__c);
		System.assertEquals(recordTypeRenewalId, idToOpportynity.get(opportunities[2].Id).RecordTypeId);

		System.assertEquals('Closed', idToOpportynity.get(opportunities[3].Id).StageName);
		System.assertEquals(accounts[2].CustomField__c, idToOpportynity.get(opportunities[3].Id).CustomField__c);
		System.assertEquals(recordTypeRenewalId, idToOpportynity.get(opportunities[3].Id).RecordTypeId);

		System.assertEquals('Qualification', idToOpportynity.get(opportunities[4].Id).StageName);
		System.assertEquals(accounts[2].CustomField__c, idToOpportynity.get(opportunities[4].Id).CustomField__c);
		System.assertEquals(recordTypeNewId, idToOpportynity.get(opportunities[4].Id).RecordTypeId);
	}
}
