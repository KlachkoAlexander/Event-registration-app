@IsTest
public with sharing class AttendeesTest {
	@IsTest
	static void setEmailPhoneTest() {
		Event__c event = new Event__c();
		event.Name = 'Zommer';
		insert event;
		Contact contactRecord = new Contact();
		contactRecord.LastName = 'Rock';
		contactRecord.FirstName = 'Simon';
		contactRecord.Email = 'simon@gmail.com';
		contactRecord.Phone = '+375336511245';
		insert contactRecord;
		Account accountRecord = new Account();
		accountRecord.Name = 'Kepler';
		accountRecord.Email__c = 'kepler@gmail.com';
		insert accountRecord;
		List<Attendee__c> attendees = new List<Attendee__c>();
		Attendee__c attendee1 = new Attendee__c();
		attendee1.Contact__c = contactRecord.Id;
		attendee1.Event__c = event.Id;
		attendees.add(attendee1);
		Attendee__c attendee2 = new Attendee__c();
		attendee2.Account__c = accountRecord.Id;
		attendee2.Event__c = event.Id;
		attendees.add(attendee2);
		insert attendees;
		Map <Id, Attendee__c> idToAttendee = new Map <Id, Attendee__c>([SELECT Id, Phone__c, Email__c FROM Attendee__c]);
		System.assertEquals(contactRecord.Email, idToAttendee.get(attendee1.Id).Email__c);
		System.assertEquals(contactRecord.Phone, idToAttendee.get(attendee1.Id).Phone__c);
		System.assertEquals(accountRecord.Email__c, idToAttendee.get(attendee2.Id).Email__c);
		System.assertEquals(accountRecord.Phone, idToAttendee.get(attendee2.Id).Phone__c);
	}
	@IsTest
	static void validateLinkToMainObjectAttendeeTest() {
		Event__c event = new Event__c();
		event.Name = 'Zommer';
		insert event;
		Contact contactRecord = new Contact();
		contactRecord.LastName = 'Rock';
		contactRecord.FirstName = 'Simon';
		contactRecord.Email = 'simon@gmail.com';
		contactRecord.Phone = '+375336511245';
		insert contactRecord;
		Account accountRecord = new Account();
		accountRecord.Name = 'Kepler';
		accountRecord.Email__c = 'kepler@gmail.com';
		insert accountRecord;
		List<Attendee__c> attendees = new List<Attendee__c>();
		Attendee__c attendee1 = new Attendee__c();
		attendee1.Contact__c = contactRecord.Id;
		attendee1.Event__c = event.Id;
		attendee1.Email__c = 'zome@gmail.com';
		attendees.add(attendee1);
		Attendee__c attendee2 = new Attendee__c();
		attendee2.Account__c = accountRecord.Id;
		attendee2.Event__c = event.Id;
		attendee2.Phone__c = '+375337849625';
		attendees.add(attendee2);
		insert attendees;
		Map <Id, Attendee__c> idToAttendee = new Map <Id, Attendee__c>([SELECT Id, Phone__c, Email__c FROM Attendee__c]);
		System.assertEquals('zome@gmail.com', idToAttendee.get(attendee1.Id).Email__c);
		System.assertEquals('+375337849625', idToAttendee.get(attendee2.Id).Phone__c);
		attendee2.Contact__c = contactRecord.Id;
		Boolean flag = false;
		try{
			update attendee2;
		} catch (Exception ex) {
			System.assert(ex.getMessage().contains('Only one field from Lead, User, Account, Contact can be fill'));
			flag = true;
		}
		System.assert(flag);
	}
}
