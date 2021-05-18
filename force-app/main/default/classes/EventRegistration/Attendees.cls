public with sharing class Attendees  extends fflib_SObjectDomain {
    public Attendees(List<Attendee__c> sObjectList) {
        super(sObjectList);
    }
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Attendees(sObjectList);
        }
    }
	public override void onBeforeInsert() {
		validateLinkToMainObjectAttendee(Trigger.new);
		setEmailPhone(Trigger.new);
	}
	public override void onBeforeUpdate(Map<Id, sObject> existingAttendees) {
		validateLinkToMainObjectAttendee(Trigger.new);
		setEmailPhone(Trigger.new);
	}
	public static void validateLinkToMainObjectAttendee(List<Attendee__c> attendees) {
		for (Attendee__c attendee : (List<Attendee__c>) attendees) {
			Set<Id> ids = new Set<Id> {attendee.Lead__c, attendee.User__c, attendee.Account__c, attendee.Contact__c};
			ids.remove(null);
			if (ids.size() > 1) {
				attendee.addError('Only one field from Lead, User, Account, Contact can be fill');
			}
		}
	}
	public static void setEmailPhone(List<Attendee__c> attendees) {
		Set<Id> relatedUsers = new Set<Id>();
		Set<Id> relatedLeads = new Set<Id>();
		Set<Id> relatedContacts = new Set<Id>();
		Set<Id> relatedAccounts = new Set<Id>();
		for(Attendee__c attendee : (List<Attendee__c>) attendees) {
			relatedLeads.add(attendee.Lead__c);
			relatedUsers.add(attendee.User__c);
			relatedAccounts.add(attendee.Account__c);
			relatedContacts.add(attendee.Contact__c);
		}
		Map<Id, SObject> idToSObjects = new Map<Id, SObject>();
		if (!relatedUsers.isEmpty()) {
			idToSObjects.putAll([SELECT Id, Email, Phone FROM User WHERE Id IN :relatedUsers]);
		}
		if (!relatedLeads.isEmpty()) {
			idToSObjects.putAll([SELECT Id, Email, Phone FROM Lead WHERE Id IN :relatedLeads]);
		}
		if (!relatedContacts.isEmpty()) {
			idToSObjects.putAll([SELECT Id, Email, Phone FROM Contact WHERE Id IN :relatedContacts]);
		}
		if (!relatedAccounts.isEmpty()) {
			idToSObjects.putAll([SELECT Id, Email__c, Phone FROM Account WHERE Id IN :relatedAccounts]);
		}
		Set<String> nameFields = new Set<String>{'Lead__c', 'User__c', 'Account__c', 'Contact__c'};
		for(Attendee__c attendee : (List<Attendee__c>) attendees) {
			if (String.isBlank(attendee.Email__c)) {
				for (String nameField :nameFields) {
					if (idToSObjects.containsKey(String.valueOf(attendee.get(nameField)))) {
						attendee.put('Email__c', (nameField != 'Account__c' 
							? idToSObjects.get(String.valueOf(attendee.get(nameField))).get('Email'):
							 idToSObjects.get(String.valueOf(attendee.get(nameField))).get('Email__c')));
					}
				}
			}
			if (String.isBlank(attendee.Phone__c)) {
				for (String nameField :nameFields) {
					if (idToSObjects.containsKey(String.valueOf(attendee.get(nameField)))) {
						attendee.put('Phone__c', idToSObjects.get(String.valueOf(attendee.get(nameField))).get('Phone'));
					}
				}
			}
		}
	}
}
