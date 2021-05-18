public with sharing class TriggerHandler_Opportunity {
	public static void closeOpportunity(List<Opportunity> opportunities) {
		Set<Id> accountIds = new Set<Id>();
		for (Opportunity opp : opportunities) {
			accountIds.add(opp.AccountId);
		}
		Map<Id, Account> idToAccount = new Map<Id, Account>([
			SELECT Id, CustomField__c
			FROM Account
			WHERE Id IN :accountIds
		]);
		Id recordTypeRenewalId = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName()
			.get('renewal').getRecordTypeId();
		for (Opportunity opp : opportunities) {
			if (opp.CloseDate < Date.today()) {
				opp.StageName = 'Closed';
				opp.RecordTypeId = recordTypeRenewalId;
			}
			if (idToAccount.containsKey(opp.AccountId)) {
				opp.CustomField__c = idToAccount.get(opp.AccountId).CustomField__c;
			}
		}
	}
}
