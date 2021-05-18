@IsTest
public with sharing class BonusPayoutBatchTest {
	@IsTest
	static void createBonusPayoutBatchTest() {
		Date today = Date.today();
		List<Bonus__c> bonuses = new List<Bonus__c>{
			new Bonus__c(),
			new Bonus__c(StartDate__c = Date.newInstance(2021, 1, 15)),
			new Bonus__c(EndDate__c = today.addMonths(1)),
			new Bonus__c(StartDate__c = Date.newInstance(2021, 1, 15), EndDate__c = today.addMonths(1)),
			new Bonus__c(StartDate__c = Date.newInstance(2021, 2, 15), EndDate__c = today.addMonths(1))
		};
		insert bonuses;
		List<Bonus__c> b = [SELECT Id FROM Bonus__c];
		BonusPayout__c bonusPayout = new BonusPayout__c();
		bonusPayout.Bonus__c = bonuses[4].Id;
		bonusPayout.Date__c = Date.today().toStartOfMonth();
		insert bonusPayout;
		Test.startTest();
		BonusPayoutBatch context = new BonusPayoutBatch();
		Id jobid= Database.executeBatch(context, 10);
		Test.stopTest();
		List<BonusPayout__c> bonusPayouts = [SELECT Id, Date__c, Bonus__c FROM BonusPayout__c];
		System.assertEquals(5, bonusPayouts.size());
		for (BonusPayout__c bonusPayoutItem :bonusPayouts) {
			if (bonusPayoutItem.Bonus__c == bonuses[4].Id) {
				System.assertEquals(Date.today().toStartOfMonth(), bonusPayoutItem.Date__c);
			} else {
				System.assertEquals(Date.today(), bonusPayoutItem.Date__c);
			}
		}
	}
}
