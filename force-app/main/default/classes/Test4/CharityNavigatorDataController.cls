public with sharing class CharityNavigatorDataController {
	public static final String QUERY_URL = 'https://api.data.charitynavigator.org/v2/Organizations';

	@AuraEnabled(cacheable=true)
	public static List<CharityOrganization> getData(String search) {
		List<Credential__mdt> credentials = (List<Credential__mdt>) new CustomMetadataDao().getCustomMetadataRecords(
			'SELECT Id__c, Key__c ' + 
			'FROM Credential__mdt ' + 
			'WHERE DeveloperName = \'CharityNavigatorDataAPI\''
		);
		if (credentials.isEmpty()) {
			throw new CalloutException('Please fill credentials for Charity Navigator Data');
		}
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		String endpoint = QUERY_URL + '?app_id=' + credentials[0].Id__c + '&app_key=' + credentials[0].Key__c + search;
		request.setEndpoint(endpoint);
		request.setMethod('GET');

		HttpResponse response = http.send(request);
		if (response.getStatusCode() == 400 || response.getStatusCode() == 404) {
			Map<String, Object> error = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
			throw new CalloutException(
				(String)error.get('errorMessage')
			);
		}
		if (response.getStatusCode() < 200 || response.getStatusCode() >= 300) {
			throw new CalloutException(
				'Did not get a success response from the callout. Details, Status Code: ' +
				response.getStatusCode() +
				' status message: ' +
				response.getStatus()
			);
		}
		List<CharityOrganization> charityOrganizations = CharityOrganization.parse(response.getBody());
		return charityOrganizations;
	}
	public class CalloutException extends Exception {}
}
