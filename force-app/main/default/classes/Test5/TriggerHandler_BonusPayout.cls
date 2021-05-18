public with sharing class TriggerHandler_BonusPayout {
	public static void validateCreationOnlyOneRecordPerMonth(List<BonusPayout__c> bonusPayouts) {
		Set<Integer> monthes = new Set<Integer>();
		Set<Id> bonusIds = new Set<Id>();
		for (BonusPayout__c bonusPayout :bonusPayouts) {
			bonusIds.add(bonusPayout.Bonus__c);
			monthes.add(bonusPayout.Date__c.month());
		}
		List<BonusPayout__c> existBonusPayouts = [
			SELECT Month__c, Bonus__c 
			FROM BonusPayout__c 
			WHERE Bonus__c IN :bonusIds AND Month__c IN :monthes
		];
		Map<Id, Set<Integer>> idBonusToMonthes =  new Map<Id, Set<Integer>>();
		for (BonusPayout__c existBonusPayout :existBonusPayouts) {
			if (!idBonusToMonthes.containsKey(existBonusPayout.Id)) {
				idBonusToMonthes.put(existBonusPayout.Bonus__c, new Set<Integer>{Integer.valueOf(existBonusPayout.Month__c)});
			}
			idBonusToMonthes.get(existBonusPayout.Bonus__c).add(Integer.valueOf(existBonusPayout.Month__c));
		}
		for (BonusPayout__c bonusPayout :bonusPayouts) {
			if (idBonusToMonthes.containsKey(bonusPayout.Bonus__c) && idBonusToMonthes.get(bonusPayout.Bonus__c).contains(bonusPayout.Date__c.month())) {
				bonusPayout.addError('Bonus payout on month = ' + bonusPayout.Date__c.month() + ' exist');
			}
		}
	}
}
