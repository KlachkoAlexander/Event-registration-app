@IsTest
public with sharing class AttendeeAPITest {
	@IsTest
	static void doGetTest() {
		Event__c event = new Event__c();
		event.Name = 'Zommer';
		insert event;
		Contact contactRecord = new Contact();
		contactRecord.LastName = 'Rock';
		contactRecord.FirstName = 'Simon';
		contactRecord.Email = 'simon@gmail.com';
		contactRecord.Phone = '+375336511245';
		insert contactRecord;
		Attendee__c attendee = new Attendee__c();
		attendee.Contact__c = contactRecord.Id;
		attendee.Event__c = event.Id;
		attendee.Email__c = 'zome@gmail.com';
		insert attendee;
		RestRouteTestUtil.setupRestContext('/services/apexrest/api/*', 'api/v1/attendees?Id=' + attendee.Id, new Map<String, String> {'Id' => attendee.Id});
		RestResponse resp = RestContext.Response;
		SObject  response;
		Test.startTest();
		RouteAttendee routeAttendee = new RouteAttendee();
		response = (SObject)routeAttendee.doGet();
		Test.stopTest();
		System.assertEquals(attendee.Event__c, response.get('Event__c'));
		System.assertEquals(attendee.Email__c, response.get('Email__c'));
	}
	@IsTest
	static void doGetNegativeTest() {
		Event__c event = new Event__c();
		event.Name = 'Zommer';
		insert event;
		Contact contactRecord = new Contact();
		contactRecord.LastName = 'Rock';
		contactRecord.FirstName = 'Simon';
		contactRecord.Email = 'simon@gmail.com';
		contactRecord.Phone = '+375336511245';
		insert contactRecord;
		Attendee__c attendee = new Attendee__c();
		attendee.Contact__c = contactRecord.Id;
		attendee.Event__c = event.Id;
		attendee.Email__c = 'zome@gmail.com';
		insert attendee;
		RestRouteTestUtil.setupRestContext('/services/apexrest/api/*', 'api/v1/attendees?Id=' + attendee.Id, new Map<String, String> {'Id' => contactRecord.Id});
		RestResponse resp = RestContext.Response;
		List<RestRouteError.RestException> response;
		Test.startTest();
		RouteAttendee routeAttendee = new RouteAttendee();
		response = (List<RestRouteError.RestException>)routeAttendee.doGet();
		Test.stopTest();
		System.assertEquals(404, response[0].statusCode);
		System.assertEquals('Attendee does not exist', response[0].errorResp.message);
		System.assertEquals('NOT_FOUND', response[0].errorResp.errorCode);
	}
	@IsTest
	static void doPostRegistereAttendeeTest() {
		Event__c event = new Event__c();
		event.Name = 'Zommer';
		insert event;
		Contact contactRecord = new Contact();
		contactRecord.LastName = 'Rock';
		contactRecord.FirstName = 'Simon';
		contactRecord.Email = 'simon@gmail.com';
		contactRecord.Phone = '+375336511245';
		insert contactRecord;
		Attendee__c attendee = new Attendee__c();
		attendee.Contact__c = contactRecord.Id;
		attendee.Event__c = event.Id;
		attendee.Email__c = 'zome@gmail.com';
		insert attendee;
		Attendee__c attendee1 = new Attendee__c();
		attendee1.Event__c = event.Id;
		attendee1.Email__c = 'kirov@gmail.com';
		insert attendee1;
		RestRouteTestUtil.setupRestContext('/services/apexrest/api/*',
			'api/v1/attendees', 'POST', 
			null,
			Blob.valueOf('{"id": "a046D0000041XasQAE", "registrationStatus": "Registered"}')
		);
		RestResponse resp = RestContext.Response;
		Attendee__c response;
		Test.startTest();
		RouteAttendee routeAttendee = new RouteAttendee();
		response = (Attendee__c)routeAttendee.doPost();
		Test.stopTest();
		System.assertEquals(200, resp.statusCode);
		System.assertEquals('Registered', response.get('RegistrationStatus__c'));
	}
	@IsTest
	static void doPostCreateAttendeeTest() {
		Event__c event = new Event__c();
		event.Name = 'Zommer';
		insert event;
		Contact contactRecord = new Contact();
		contactRecord.LastName = 'Rock';
		contactRecord.FirstName = 'Simon';
		contactRecord.Email = 'simon@gmail.com';
		contactRecord.Phone = '+375336511245';
		insert contactRecord;
		Attendee__c attendee = new Attendee__c();
		attendee.Contact__c = contactRecord.Id;
		attendee.Event__c = event.Id;
		attendee.Email__c = 'zome@gmail.com';
		insert attendee;
		Attendee__c attendee1 = new Attendee__c();
		attendee1.Event__c = event.Id;
		attendee1.Email__c = 'kirov@gmail.com';
		insert attendee1;
		RestRouteTestUtil.setupRestContext('/services/apexrest/api/*',
			'api/v1/attendees', 'POST', 
			null,
			Blob.valueOf('{"email": "sorov@gmail.com", "registrationStatus": "Registered", ' +
				'"event": "' + event.Id + '", "lastName": "Klachko", "firstName": "Alexandr"}')
		);
		RestResponse resp = RestContext.Response;
		Attendee__c response;
		Test.startTest();
		RouteAttendee routeAttendee = new RouteAttendee();
		response = (Attendee__c)routeAttendee.doPost();
		Test.stopTest();
		System.assertEquals(201, resp.statusCode);
		System.assertEquals('sorov@gmail.com', response.get('Email__c'));
		System.assertEquals('Registered', response.get('RegistrationStatus__c'));
		System.assertEquals('Alexandr', response.get('FirstName__c'));
		System.assert(String.isNotBlank((String)response.get('Id')));
	}
}
