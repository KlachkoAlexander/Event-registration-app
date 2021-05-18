@IsTest
public with sharing class CharityNavigatorDataControllerTest {
	@IsTest
	static void getDataTest() {
		CustomMetadataDaoTest.setMetadata(
			'SELECT Id__c, Key__c FROM Credential__mdt WHERE DeveloperName = \'CharityNavigatorDataAPI\'', 
			(List<Credential__mdt>)JSON.deserialize('[{"Id__c": "123", "Key__c": "456"}]', List<Credential__mdt>.class)
		);
		String body = '[{"charityNavigatorURL":"https://www.charitynavigator.org/?bay=search.summary&orgid=15534&utm_sou' +
			'rce=DataAPI&utm_content=9af5afa3","mission":"Based in Lewiston, Maine, the United Way of Androscoggin Count' +
			'y has been proudly serving the local community since 1932. Enacting our mission to increase the organized c' +
			'apacity of people in Androscoggin County to care for one another, United Way of Androscoggin County leads a' +
			'nd supports strategic initiatives that work to identify the root causes of community-wide problems and brin' +
			'gs collective community resources together to implement long-lasting solutions.","websiteURL":"http://www.u' +
			'nitedwayandro.org/","tagLine":"Live United.","charityName":"United Way of Androscoggin County","ein":"01021' +
			'1564","orgID":15534,"currentRating":{"score":83.97,"ratingID":158234,"publicationDate":"2021-02-01T05:00:00' +
			'.000Z","ratingImage":{"small":"https://d20umu42aunjpx.cloudfront.net/_gfx_/icons/stars/3starsb.png","large"' +
			':"https://d20umu42aunjpx.cloudfront.net/_gfx_/icons/stars/3stars.png"},"rating":3,"_rapid_links":{"related"' +
			':{"href":"https://api.data.charitynavigator.org/v2/Organizations/010211564/Ratings/158234"}},"financialRati' +
			'ng":{"score":80.18,"rating":3},"accountabilityRating":{"score":89,"rating":3}},"category":{"categoryName":"' +
			'Community Development","categoryID":10,"charityNavigatorURL":"https://www.charitynavigator.org/index.cfm?ba' +
			'y=search.categories&categoryid=10&utm_source=DataAPI&utm_content=9af5afa3","image":"https://d20umu42aunjpx.' +
			'cloudfront.net/_gfx_/icons/categories/religion.png?utm_source=DataAPI&utm_content=9af5afa3"},"cause":{"caus' +
			'eID":42,"causeName":"United Ways","charityNavigatorURL":"https://www.charitynavigator.org/index.cfm?bay=sea' +
			'rch.results&cgid=10&cuid=42&utm_source=DataAPI&utm_content=9af5afa3","image":"https://d20umu42aunjpx.cloudf' +
			'ront.net/_gfx_/causes/small/United_Way.gif?utm_source=DataAPI&utm_content=9af5afa3"},"irsClassification":{"' +
			'deductibility":"Contributions are deductible","subsection":"501(c)(3)","assetAmount":2826202,"nteeType":nul' +
			'l,"incomeAmount":1247516,"nteeSuffix":null,"filingRequirement":"990 (all other) or 990EZ return","classific' +
			'ation":"Charitable Organization","latest990":"December, 2019","rulingDate":"February, 1961","nteeCode":null' +
			',"groupName":null,"deductibilityCode":"1","affiliation":"Independent - the organization is an independent o' +
			'rganization or an independent auxiliary (i.e., not affiliated with a National, Regional, or Geographic grou' +
			'ping of organizations).","foundationStatus":"Organization which receives a substantial part of its support ' +
			'from a governmental unit or the general public   170(b)(1)(A)(vi)","nteeClassification":null,"account' +
			'ingPeriod":"December","exemptOrgStatus":"Unconditional Exemption","deductibilityDetail":null,"exemptOrgStat' +
			'usCode":"01","nteeLetter":null},"mailingAddress":{"country":null,"stateOrProvince":"ME","city":"Lewiston","' +
			'postalCode":"04240","streetAddress1":"66 Ash Street","streetAddress2":null},"donationAddress":{"country":nu' +
			'll,"stateOrProvince":"ME","city":"Lewiston","postalCode":"04243","streetAddress1":"P.O. Box 888","streetAdd' +
			'ress2":null},"advisories":{"severity":null,"active":{"_rapid_links":{"related":{"href":"https://api.data.ch' +
			'aritynavigator.org/v2/Organizations/010211564/Advisories?status=ACTIVE"}}}},"organization":{"charityName":"' +
			'United Way of Androscoggin County","ein":"010211564","charityNavigatorURL":"https://www.charitynavigator.or' +
			'g/?bay=search.summary&orgid=15534&utm_source=DataAPI&utm_content=9af5afa3","_rapid_links":{"related":{"href' +
			'":"https://api.data.charitynavigator.org/v2/Organizations/010211564"}}}},{"charityNavigatorURL":"https://ww' +
			'w.charitynavigator.org/?bay=search.summary&orgid=9319&utm_source=DataAPI&utm_content=9af5afa3","mission":"U' +
			'nited Way of Greater Portland is where the community comes together to help children, individuals, and fami' +
			'lies in ways that create a brighter future for all.<br><br>For 90 years, United Way of Greater Portland\'s ' +
			'mission has been to improve people\'s lives by mobilizing the caring power of our community. Today, we are ' +
			'uniting individuals and organizations around our community\'s shared vision, Thrive2027, three 10-year goal' +
			's to improve education, financial stability, and health for every person in Greater Portland.<br><br>With c' +
			'ommunity partners, we build on strategies that are known to achieve the best results, and we rigorously eva' +
			'luate our progress. And, because we believe everyone has a role to play in building a thriving community, w' +
			'e actively seek to engage donors, advocates, and volunteers to create measurable, long-lasting community ch' +
			'ange.","websiteURL":"http://www.unitedwaygp.org/","tagLine":"Live United","charityName":"United Way of Grea' +
			'ter Portland","ein":"010241767","orgID":9319,"currentRating":{"score":90.16,"ratingID":155577,"publicationD' +
			'ate":"2020-11-01T04:00:00.000Z","ratingImage":{"small":"https://d20umu42aunjpx.cloudfront.net/_gfx_/icons/s' +
			'tars/4starsb.png","large":"https://d20umu42aunjpx.cloudfront.net/_gfx_/icons/stars/4stars.png"},"rating":4,' +
			'"_rapid_links":{"related":{"href":"https://api.data.charitynavigator.org/v2/Organizations/010241767/Ratings' +
			'/155577"}},"financialRating":{"score":86.09,"rating":3},"accountabilityRating":{"score":100,"rating":4}},"c' +
			'ategory":{"categoryName":"Community Development","categoryID":10,"charityNavigatorURL":"https://www.charity' +
			'navigator.org/index.cfm?bay=search.categories&categoryid=10&utm_source=DataAPI&utm_content=9af5afa3","image' +
			'":"https://d20umu42aunjpx.cloudfront.net/_gfx_/icons/categories/religion.png?utm_source=DataAPI&utm_content' +
			'=9af5afa3"},"cause":{"causeID":42,"causeName":"United Ways","charityNavigatorURL":"https://www.charitynavig' +
			'ator.org/index.cfm?bay=search.results&cgid=10&cuid=42&utm_source=DataAPI&utm_content=9af5afa3","image":"htt' +
			'ps://d20umu42aunjpx.cloudfront.net/_gfx_/causes/small/United_Way.gif?utm_source=DataAPI&utm_content=9af5afa' +
			'3"},"irsClassification":{"deductibility":"Contributions are deductible","subsection":"501(c)(3)","assetAmou' +
			'nt":17437834,"nteeType":"Philanthropy, Voluntarism and Grantmaking Foundations","incomeAmount":12794822,"nt' +
			'eeSuffix":"Z","filingRequirement":"990 (all other) or 990EZ return","classification":"Charitable Organizati' +
			'on","latest990":"June, 2020","rulingDate":"August, 1956","nteeCode":"T70","groupName":null,"deductibilityCo' +
			'de":"1","affiliation":"Independent - the organization is an independent organization or an independent auxi' +
			'liary (i.e., not affiliated with a National, Regional, or Geographic grouping of organizations).","foundati' +
			'onStatus":"Organization which receives a substantial part of its support from a governmental unit or the ge' +
			'neral public   170(b)(1)(A)(vi)","nteeClassification":"Fund Raising Organizations That Cross Categori' +
			'es","accountingPeriod":"June","exemptOrgStatus":"Unconditional Exemption","deductibilityDetail":null,"exemp' +
			'tOrgStatusCode":"01","nteeLetter":"T"},"mailingAddress":{"country":null,"stateOrProvince":"ME","city":"Port' +
			'land","postalCode":"04101","streetAddress1":"550 Forest Avenue","streetAddress2":"Suite 100"},"advisories":' +
			'{"severity":null,"active":{"_rapid_links":{"related":{"href":"https://api.data.charitynavigator.org/v2/Orga' +
			'nizations/010241767/Advisories?status=ACTIVE"}}}}}]';
		Test.setMock(HttpCalloutMock.class, new CharityNavigatorDataMockImpl(body));
		Test.startTest();
		List<CharityOrganization> charityOrganizations = CharityNavigatorDataController.getData('');
		Test.stopTest();
		System.assertEquals(2, charityOrganizations.size());
		System.assertEquals('010211564', charityOrganizations[0].ein);
		System.assertEquals('010241767', charityOrganizations[1].ein);
	}
	@IsTest
	static void getDataNotFoundTest() {
		CustomMetadataDaoTest.setMetadata(
			'SELECT Id__c, Key__c FROM Credential__mdt WHERE DeveloperName = \'CharityNavigatorDataAPI\'', 
			(List<Credential__mdt>)JSON.deserialize('[{"Id__c": "123", "Key__c": "456"}]', List<Credential__mdt>.class)
		);
		String bodyMessage = 'No organizations match your requirements';
		String body = '{"errorMessage": "' + bodyMessage + '"}';
		Test.setMock(HttpCalloutMock.class, new CharityNavigatorDataMockImpl(404, 'Not found', body, new Map<String, String>()));
		Test.startTest();
		try {
			List<CharityOrganization> charityOrganizations = CharityNavigatorDataController.getData('');
		} catch(Exception ex) {
			System.assertEquals(bodyMessage, ex.getMessage());
		}
		Test.stopTest();
	}
}
