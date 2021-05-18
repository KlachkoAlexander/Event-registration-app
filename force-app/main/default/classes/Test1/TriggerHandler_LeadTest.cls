@IsTest
public with sharing class TriggerHandler_LeadTest {
	@testSetup private static void setup() {

		List<Lead> leads = new List<Lead>{
			new Lead(Company = 'Company 1', LastName = 'Alex'),
			new Lead(Company = 'Company 2', LastName = 'Alex', Email = '10@gmail.com'),
			new Lead(Company = 'Company 3', LastName = 'Alex', Email = '11@gmail.com'),
			new Lead(Company = 'Company 4', LastName = 'Alex', Email = '12@gmail.com'),
			new Lead(Company = 'Company 5', LastName = 'Alex', Email = '13@gmail.com'),
			new Lead(Company = 'Company 6', LastName = 'Alex', Email = '14@gmail.com')
		};
		insert leads;
		System.assertEquals(6, [SELECT Id FROM Lead	WHERE Id IN :leads].size());
	}
	@IsTest
	static void preventDuplicatesPositiveTest() {
		List<Lead> leads = [SELECT Id FROM Lead ORDER BY Company];
		List<Lead> additionalLeads = new List<Lead>{
			new Lead(Company = 'Company 3', LastName = 'Alex', Email = '7@gmail.com'),
			new Lead(Company = 'Company 2', LastName = 'Alex', Email = '9@gmail.com')
		};
		insert additionalLeads;
		leads.addAll(additionalLeads);
		update leads;
		System.assertEquals(8, [SELECT Id FROM Lead	WHERE Id IN :leads].size());
	}
	@IsTest
	static void preventDuplicatesNegativeTest() {
		List<Lead> leads = [SELECT Id FROM Lead ORDER BY Company];
		List<Lead> additionalLeads = new List<Lead>{
			new Lead(Company = 'Company 3', LastName = 'Alex'),
			new Lead(Company = 'Company 2', LastName = 'Alex', Email = '10@gmail.com')
		};
		Database.DMLOptions dml = new Database.DMLOptions();
		dml.DuplicateRuleHeader.allowSave = true;
		dml.DuplicateRuleHeader.runAsCurrentUser = true;
		Database.insert(additionalLeads, dml);
		leads.addAll(additionalLeads);
		dml.optAllOrNone = false;
		Database.SaveResult[] saveResults = Database.update(leads, dml);
		Integer count = 0;
		for (Database.SaveResult sr :saveResults) {
			if (sr.isSuccess()) {
				count++;
			} else {
				for(Database.Error err : sr.getErrors()) {
					System.assertEquals('Duplicate Lead!', err.getMessage());
				}
			}
		}
		System.assertEquals(4, count);
	}
	@IsTest
	static void preventDuplicatesUpdateEmailsNegativeTest() {
		List<Lead> leads = [SELECT Id FROM Lead ORDER BY Company];
		List<Lead> additionalLeads = new List<Lead>{
			new Lead(Company = 'Company 22', LastName = 'Alex'),
			new Lead(Company = 'Company 33', LastName = 'Alex', Email = '10@gmail.com')
		};
		Database.DMLOptions dml = new Database.DMLOptions();
		dml.DuplicateRuleHeader.allowSave = true;
		Database.insert(additionalLeads, dml);
		additionalLeads[0].Email = '17@gmail.com';
		additionalLeads[1].Email = '17@gmail.com';
		leads[0].Email = '18@gmail.com';
		leads[1].Email = '18@gmail.com';
		leads.addAll(additionalLeads);
		Database.SaveResult[] saveResults = Database.update(leads, false);
		Integer count = 0;
		for (Database.SaveResult sr :saveResults) {
			if (sr.isSuccess()) {
				count++;
			} else {
				for(Database.Error err : sr.getErrors()) {
					System.assertEquals('Duplicate Lead!', err.getMessage());
				}
			}
		}
		System.assertEquals(6, count);
	}
}
