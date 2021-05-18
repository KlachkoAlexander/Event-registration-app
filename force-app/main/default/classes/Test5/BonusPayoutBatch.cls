public with sharing class BonusPayoutBatch  implements Database.Batchable<SObject> {

	public Database.QueryLocator start(Database.BatchableContext context) {
		Date today = Date.today();
		System.Debug('ass=' + [SELECT Id FROM Bonus__c WHERE (StartDate__c < : today OR StartDate__c = NULL) AND (EndDate__c > : today OR EndDate__c = NULL)]);
		return Database.getQueryLocator('SELECT Id FROM Bonus__c WHERE (StartDate__c < : today OR StartDate__c = NULL) AND (EndDate__c > : today OR EndDate__c = NULL)');
	}

	public void execute(Database.BatchableContext context, List<SObject> scope) {
		System.Debug('scope=' + scope.size());
		List<BonusPayout__c> bonusPayouts = new List<BonusPayout__c>();
		for (Bonus__c bonus :(List<Bonus__c>)scope) {
			bonusPayouts.add(new BonusPayout__c(Date__c = Date.today(), Bonus__c = bonus.Id));
		}
		Database.insert(bonusPayouts, false);
	}

	public void finish(Database.BatchableContext context) {
	}
}