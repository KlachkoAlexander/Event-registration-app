public without sharing class RouteEvent extends RestRoute {
	public override Object doGet() {
		Map<String, String> params = RestContext.request.params;
		String recordId = '';
		Object response;
		try {
			String sql = 'SELECT Id, Name, StartDate__c, StartTime__c, EndDate__c, EndTime__c, ' +
				'Description__c, Link__c, Provider__c, Recurring__c, Status__c, ' +
				'TimeZone__c, City__c, Country__c, PostalCode__c, State__c, Street__c, ( ' +
					'SELECT Id, LastName__c, FirstName__c, OrganizationName__c, Phone__c, Email__c FROM Attendees__r ' +
				') ' +
				'FROM Event__c';
			Integer pageSize = 100;
			String limitQuery = ' LIMIT ' + String.valueOf(pageSize);
			if (String.isNotBlank(params.get('pageSize'))) {
				pageSize = Integer.valueOf(EncodingUtil.urlEncode(params.get('pageSize'), 'UTF-8'));
				limitQuery = ' LIMIT ' + params.get('pageSize');
			}
			String offset = '';
			if (String.isNotBlank(params.get('pageNumber'))) {
				offset = ' OFFSET ' + ((Integer.valueOf(EncodingUtil.urlEncode(params.get('pageNumber'), 'UTF-8')) - 1) * pageSize);
			}
			String condition = '';
			if (String.isNotBlank(params.get('Id'))) {
				recordId = EncodingUtil.urlEncode(params.get('Id'), 'UTF-8');
				condition = ' Id = :recordId AND ';
			}
			if (String.isNotBlank(params.get('startDate'))) {
				Date startDate = Date.valueOf(EncodingUtil.urlEncode(params.get('startDate'), 'UTF-8'));
				condition = ' StartDate__c >= :startDate AND ';
			}
			if (String.isNotBlank(params.get('endDate'))) {
				Date endDate = Date.valueOf(EncodingUtil.urlEncode(params.get('endDate'), 'UTF-8'));
				condition = ' EndDate__c >= :endDate AND ';
			}
			if (String.isNotBlank(params.get('name'))) {
				String name = EncodingUtil.urlEncode(params.get('name'), 'UTF-8');
				condition = ' Name = :name AND ';
			}
			if (String.isNotBlank(params.get('provider'))) {
				String provider = EncodingUtil.urlEncode(params.get('provider'), 'UTF-8');
				condition = ' Provider__c = :provide AND ';
			}
			if (String.isNotBlank(params.get('status'))) {
				String status = EncodingUtil.urlEncode(params.get('status'), 'UTF-8');
				condition = ' Status__c = :status AND ';
			}
			condition = condition.removeEnd('AND ');
			condition = String.isNotBlank(condition) ? (' WHERE ' +  condition) : ' ';
			List<Event__c> events = Database.query(sql + condition +  limitQuery + offset);
			System.Debug('query=' + sql + condition +  limitQuery + offset);
			System.Debug('events=' + events.size());
			System.Debug('events=' + events);
			if (String.isNotBlank(recordId)) {
				if (!events.isEmpty()) {
					RestContext.response.statusCode = 200;
					response = events[0];
				} else {
					RestContext.response.statusCode = 404;
					List<RestRouteError.RestException> errs = new List<RestRouteError.RestException>{ 
						new RestRouteError.RestException('Event does not exist', 'NOT_FOUND', 404)
					};
					response = errs;
				}
			} else {
				RestContext.response.statusCode = 200;
				response = events;
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
}
