public without sharing class RouteAttendee extends RestRoute {
    public override Object doGet() {
		Map<String, String> params = RestContext.request.params;
		String recordId = '';
		Object response;
		try {
			if (String.isNotBlank(params.get('Id'))) {
				recordId = EncodingUtil.urlEncode(params.get('Id'), 'UTF-8');
			}
			List<Attendee__c> attendees = [
				SELECT Id, LastName__c, FirstName__c, OrganizationName__c, Phone__c, Event__c, Email__c,
					Event__r.Name, Event__r.StartDate__c, Event__r.StartTime__c, Event__r.EndDate__c, Event__r.EndTime__c,
					Event__r.Description__c, Event__r.Link__c, Event__r.Provider__c, Event__r.Recurring__c, Event__r.Status__c,
					Event__r.TimeZone__c, Event__r.City__c, Event__r.Country__c, Event__r.PostalCode__c, Event__r.State__c,
					Event__r.Street__c
				FROM Attendee__c
				WHERE Id = :recordId
			];
			if (!attendees.isEmpty()) {
				RestContext.response.statusCode = 200;
				response = attendees[0];
			} else {
				RestContext.response.statusCode = 404;
				List<RestRouteError.RestException> errs = new List<RestRouteError.RestException>{ 
					new RestRouteError.RestException('Attendee does not exist', 'NOT_FOUND', 404)
				};
				response = errs;
			}
		} catch(System.StringException ex){
			RestContext.response.statusCode = 400;
			List<RestRouteError.RestException> errs = new List<RestRouteError.RestException>{ 
				new RestRouteError.RestException('Id is not a valid Id', 'BAD_REQUEST', 400)
			};
			response = errs;
		} catch (Exception ex) {
			RestContext.response.statusCode = 500;
			List<RestRouteError.RestException> errs = new List<RestRouteError.RestException>{ 
				new RestRouteError.RestException(ex.getMessage(), 'BAD_REQUEST', 500)
			};
			response = errs;
		}
		return response;
    }
	public override Object doPost() {
		RestRequest req = RestContext.request;
		Blob jsonBlob = req.requestBody;
		Object response;
    	String jsonString = jsonBlob.toString();
		Map<String, String> keyToField = new Map<String, String> {
			'accountId' => 'Account__c',
			'attendanceStatus' => 'AttendanceStatus__c',
			'contactId' => 'Contact__c',
			'email' => 'Email__c',
			'event' => 'Event__c',
			'firstName' => 'FirstName__c',
			'lastName' => 'LastName__c',
			'lead' => 'Lead__c',
			'organizationName' => 'OrganizationName__c',
			'phone' => 'Phone__c',
			'registrationStatus' => 'RegistrationStatus__c',
			'userId' => 'User__c',
			'id' => 'Id'
		};
		for (String key: keyToField.keySet()){
			String fieldName = '"' + keyToField.get(key) + '"';
			String regExp = '"' + key + '"';
			jsonString = jsonString.replaceAll(regExp, fieldName);
		}
		Attendee__c attendee = (Attendee__c)JSON.deserialize(jsonString, Attendee__c.class);
		Boolean isUpdate = false;
		if (String.isNotBlank(attendee.Id)) {
			isUpdate = true;
		}
		Database.UpsertResult[] upsertResults = Database.upsert(new List<Attendee__c> {attendee}, false);
		for (Integer i = 0; i < upsertResults.size(); i++) {
			Map<String, Object> clientResponse = new Map<String, Object>();
			if (!upsertResults[i].isSuccess()) {
				String errorMsg = '';
				for (Database.Error err : upsertResults[i].getErrors()) {
					errorMsg += err.getStatusCode() + ': ' + err.getMessage() + ' ';
				}
				RestContext.response.statusCode = 400;
				List<RestRouteError.RestException> errs = new List<RestRouteError.RestException>{ 
					new RestRouteError.RestException('Id is not a valid Id', 'BAD_REQUEST', 400)
				};
				response = errs;
			} else {
				RestContext.response.statusCode = isUpdate ? 200 : 201;
				response = attendee;
			}
		}
		return response;
	}
}
