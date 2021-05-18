public with sharing class TriggerHandler_Lead {
	public static void preventDupLead(List<Lead> leads) {
		Set<String> emails = new Set<String>();
		Set<Id> leadIds = new Set<Id>();
		for (Lead leadItem : leads) {
			emails.add(leadItem.Email);
			leadIds.add(leadItem.Id);
		}
		Set<String> existingEmails = new Set<String>();
		for (Lead leadItem :[SELECT Email FROM Lead WHERE Email IN :emails AND Id NOT IN :leadIds]) {
			existingEmails.add(leadItem.Email);
		}
		for(Lead leadItem : leads) {
			if (existingEmails.contains(leadItem.Email)) {
				leadItem.addError('Duplicate Lead!');
			} else {
				existingEmails.add(leadItem.Email);
			}
		}
	}
}
