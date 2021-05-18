@IsTest
public with sharing class EventAPITest {
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
		Attendee__c attendee1 = new Attendee__c();
		attendee1.Event__c = event.Id;
		attendee1.Email__c = 'kirov@gmail.com';
		insert attendee1;
		RestRouteTestUtil.setupRestContext('/services/apexrest/api/*', 'api/v1/events?Id=' + attendee.Id, new Map<String, String> {'Id' => event.Id});
		RestResponse resp = RestContext.Response;
		SObject  response;
		Test.startTest();
		RouteEvent routeEvent = new RouteEvent();
		response = (SObject)routeEvent.doGet();
		Test.stopTest();
		System.assertEquals(event.Name, response.get('Name'));
		System.assertEquals(2, response.getSObjects('Attendees__r').size());
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
		RestRouteTestUtil.setupRestContext('/services/apexrest/api/*', 'api/v1/attendees?Id=' + attendee.Id, new Map<String, String> {'Id' => '123'});
		RestResponse resp = RestContext.Response;
		List<RestRouteError.RestException> response;
		Test.startTest();
		RouteEvent routeEvent = new RouteEvent();
		response = (List<RestRouteError.RestException>)routeEvent.doGet();
		Test.stopTest();
		System.assertEquals(404, response[0].statusCode);
		System.assertEquals('Event does not exist', response[0].errorResp.message);
		System.assertEquals('NOT_FOUND', response[0].errorResp.errorCode);
	}
}
