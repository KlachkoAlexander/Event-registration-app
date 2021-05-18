@IsTest
public class CharityOrganizationTest {
	
	// This test method should give 100% coverage
	@IsTest
	static void testParse() {
		String json = '['+
		'    {'+
		'        \"charityNavigatorURL\": \"https://www.charitynavigator.org/?bay=search.profile&ein=000000030&utm_source=DataAPI&utm_content=9989397e\",'+
		'        \"mission\": null,'+
		'        \"websiteURL\": null,'+
		'        \"tagLine\": null,'+
		'        \"charityName\": \"Voice of a Child U.S.\",'+
		'        \"ein\": \"000000030\",'+
		'        \"orgID\": null,'+
		'        \"irsClassification\": {'+
		'            \"deductibility\": null,'+
		'            \"subsection\": null,'+
		'            \"assetAmount\": null,'+
		'            \"nteeType\": null,'+
		'            \"incomeAmount\": null,'+
		'            \"nteeSuffix\": null,'+
		'            \"filingRequirement\": null,'+
		'            \"classification\": null,'+
		'            \"latest990\": null,'+
		'            \"rulingDate\": null,'+
		'            \"nteeCode\": null,'+
		'            \"groupName\": null,'+
		'            \"deductibilityCode\": null,'+
		'            \"affiliation\": null,'+
		'            \"foundationStatus\": null,'+
		'            \"nteeClassification\": null,'+
		'            \"accountingPeriod\": null,'+
		'            \"exemptOrgStatus\": null,'+
		'            \"deductibilityDetail\": null,'+
		'            \"exemptOrgStatusCode\": null,'+
		'            \"nteeLetter\": null'+
		'        },'+
		'        \"mailingAddress\": {'+
		'            \"country\": null,'+
		'            \"stateOrProvince\": \"NY\",'+
		'            \"city\": null,'+
		'            \"postalCode\": null,'+
		'            \"streetAddress1\": null,'+
		'            \"streetAddress2\": null'+
		'        },'+
		'        \"advisories\": {'+
		'            \"severity\": \"High\",'+
		'            \"active\": {'+
		'                \"_rapid_links\": {'+
		'                    \"related\": {'+
		'                        \"href\": \"https://api.data.charitynavigator.org/v2/Organizations/000000030/Advisories?status=ACTIVE\"'+
		'                    }'+
		'                }'+
		'            }'+
		'        },'+
		'        \"organization\": {'+
		'            \"charityName\": \"Voice of a Child U.S.\",'+
		'            \"ein\": \"000000030\",'+
		'            \"charityNavigatorURL\": \"https://www.charitynavigator.org/?bay=search.profile&ein=000000030&utm_source=DataAPI&utm_content=9989397e\",'+
		'            \"_rapid_links\": {'+
		'                \"related\": {'+
		'                    \"href\": \"https://api.data.charitynavigator.org/v2/Organizations/000000030\"'+
		'                }'+
		'            }'+
		'        }'+
		'    }'+
		']';
		List<CharityOrganization> r = CharityOrganization.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.Active objActive = new CharityOrganization.Active(System.JSON.createParser(json));
		System.assert(objActive != null);
		System.assert(objActive.x_rapid_links == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.Related objRelated = new CharityOrganization.Related(System.JSON.createParser(json));
		System.assert(objRelated != null);
		System.assert(objRelated.href == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.Organization objOrganization = new CharityOrganization.Organization(System.JSON.createParser(json));
		System.assert(objOrganization != null);
		System.assert(objOrganization.charityName == null);
		System.assert(objOrganization.ein == null);
		System.assert(objOrganization.charityNavigatorURL == null);
		System.assert(objOrganization.x_rapid_links == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization objJSON2Apex = new CharityOrganization(System.JSON.createParser(json));
		System.assert(objJSON2Apex != null);
		System.assert(objJSON2Apex.charityNavigatorURL == null);
		System.assert(objJSON2Apex.mission == null);
		System.assert(objJSON2Apex.websiteURL == null);
		System.assert(objJSON2Apex.tagLine == null);
		System.assert(objJSON2Apex.charityName == null);
		System.assert(objJSON2Apex.ein == null);
		System.assert(objJSON2Apex.orgID == null);
		System.assert(objJSON2Apex.irsClassification == null);
		System.assert(objJSON2Apex.mailingAddress == null);
		System.assert(objJSON2Apex.advisories == null);
		System.assert(objJSON2Apex.organization == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.IrsClassification objIrsClassification = new CharityOrganization.IrsClassification(System.JSON.createParser(json));
		System.assert(objIrsClassification != null);
		System.assert(objIrsClassification.deductibility == null);
		System.assert(objIrsClassification.subsection == null);
		System.assert(objIrsClassification.assetAmount == null);
		System.assert(objIrsClassification.nteeType == null);
		System.assert(objIrsClassification.incomeAmount == null);
		System.assert(objIrsClassification.nteeSuffix == null);
		System.assert(objIrsClassification.filingRequirement == null);
		System.assert(objIrsClassification.classification == null);
		System.assert(objIrsClassification.latest990 == null);
		System.assert(objIrsClassification.rulingDate == null);
		System.assert(objIrsClassification.nteeCode == null);
		System.assert(objIrsClassification.groupName == null);
		System.assert(objIrsClassification.deductibilityCode == null);
		System.assert(objIrsClassification.affiliation == null);
		System.assert(objIrsClassification.foundationStatus == null);
		System.assert(objIrsClassification.nteeClassification == null);
		System.assert(objIrsClassification.accountingPeriod == null);
		System.assert(objIrsClassification.exemptOrgStatus == null);
		System.assert(objIrsClassification.deductibilityDetail == null);
		System.assert(objIrsClassification.exemptOrgStatusCode == null);
		System.assert(objIrsClassification.nteeLetter == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.Rapid_links objRapid_links = new CharityOrganization.Rapid_links(System.JSON.createParser(json));
		System.assert(objRapid_links != null);
		System.assert(objRapid_links.related == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.MailingAddress objMailingAddress = new CharityOrganization.MailingAddress(System.JSON.createParser(json));
		System.assert(objMailingAddress != null);
		System.assert(objMailingAddress.country == null);
		System.assert(objMailingAddress.stateOrProvince == null);
		System.assert(objMailingAddress.city == null);
		System.assert(objMailingAddress.postalCode == null);
		System.assert(objMailingAddress.streetAddress1 == null);
		System.assert(objMailingAddress.streetAddress2 == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CharityOrganization.Advisories objAdvisories = new CharityOrganization.Advisories(System.JSON.createParser(json));
		System.assert(objAdvisories != null);
		System.assert(objAdvisories.severity == null);
		System.assert(objAdvisories.active == null);
	}
}