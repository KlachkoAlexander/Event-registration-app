public class CharityOrganization {
	public class Active {
		@AuraEnabled
		public Rapid_links x_rapid_links {get;set;} // in json: _rapid_links

		public Active(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == '_rapid_links') {
							x_rapid_links = new Rapid_links(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Active consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	public class Related {
		@AuraEnabled
		public String href {get;set;} 

		public Related(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'href') {
							href = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Related consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	public class Organization {
		@AuraEnabled
		public String charityName {get;set;} 
		@AuraEnabled
		public String ein {get;set;} 
		@AuraEnabled
		public String charityNavigatorURL {get;set;} 
		@AuraEnabled
		public Rapid_links x_rapid_links {get;set;} // in json: _rapid_links

		public Organization(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'charityName') {
							charityName = parser.getText();
						} else if (text == 'ein') {
							ein = parser.getText();
						} else if (text == 'charityNavigatorURL') {
							charityNavigatorURL = parser.getText();
						} else if (text == '_rapid_links') {
							x_rapid_links = new Rapid_links(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Organization consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	@AuraEnabled
	public String charityNavigatorURL {get;set;} 
	@AuraEnabled
	public Object mission {get;set;} 
	@AuraEnabled
	public Object websiteURL {get;set;} 
	@AuraEnabled
	public Object tagLine {get;set;} 
	@AuraEnabled
	public String charityName {get;set;} 
	@AuraEnabled
	public String ein {get;set;} 
	@AuraEnabled
	public Object orgID {get;set;} 
	@AuraEnabled
	public IrsClassification irsClassification {get;set;} 
	@AuraEnabled
	public MailingAddress mailingAddress {get;set;} 
	@AuraEnabled
	public Advisories advisories {get;set;} 
	@AuraEnabled
	public Organization organization {get;set;} 

	public CharityOrganization(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'charityNavigatorURL') {
						charityNavigatorURL = parser.getText();
					} else if (text == 'mission') {
						mission = parser.getText();
					} else if (text == 'websiteURL') {
						websiteURL = parser.getText();
					} else if (text == 'tagLine') {
						tagLine = parser.getText();
					} else if (text == 'charityName') {
						charityName = parser.getText();
					} else if (text == 'ein') {
						ein = parser.getText();
					} else if (text == 'orgID') {
						orgID = parser.getText();
					} else if (text == 'irsClassification') {
						irsClassification = new IrsClassification(parser);
					} else if (text == 'mailingAddress') {
						mailingAddress = new MailingAddress(parser);
					} else if (text == 'advisories') {
						advisories = new Advisories(parser);
					} else if (text == 'organization') {
						organization = new Organization(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'CharityOrganization consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class IrsClassification {
		@AuraEnabled
		public Object deductibility {get;set;} 
		@AuraEnabled
		public Object subsection {get;set;} 
		@AuraEnabled
		public Object assetAmount {get;set;} 
		@AuraEnabled
		public Object nteeType {get;set;} 
		@AuraEnabled
		public Object incomeAmount {get;set;} 
		@AuraEnabled
		public Object nteeSuffix {get;set;} 
		@AuraEnabled
		public Object filingRequirement {get;set;} 
		@AuraEnabled
		public Object classification {get;set;} 
		@AuraEnabled
		public Object latest990 {get;set;} 
		@AuraEnabled
		public Object rulingDate {get;set;} 
		@AuraEnabled
		public Object nteeCode {get;set;} 
		@AuraEnabled
		public Object groupName {get;set;} 
		@AuraEnabled
		public Object deductibilityCode {get;set;} 
		@AuraEnabled
		public Object affiliation {get;set;} 
		@AuraEnabled
		public Object foundationStatus {get;set;} 
		@AuraEnabled
		public Object nteeClassification {get;set;} 
		@AuraEnabled
		public Object accountingPeriod {get;set;} 
		@AuraEnabled
		public Object exemptOrgStatus {get;set;} 
		@AuraEnabled
		public Object deductibilityDetail {get;set;} 
		@AuraEnabled
		public Object exemptOrgStatusCode {get;set;} 
		@AuraEnabled
		public Object nteeLetter {get;set;} 

		public IrsClassification(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'deductibility') {
							deductibility = parser.getText();
						} else if (text == 'subsection') {
							subsection = parser.getText();
						} else if (text == 'assetAmount') {
							assetAmount = parser.getText();
						} else if (text == 'nteeType') {
							nteeType = parser.getText();
						} else if (text == 'incomeAmount') {
							incomeAmount = parser.getText();
						} else if (text == 'nteeSuffix') {
							nteeSuffix = parser.getText();
						} else if (text == 'filingRequirement') {
							filingRequirement = parser.getText();
						} else if (text == 'classification') {
							classification = parser.getText();
						} else if (text == 'latest990') {
							latest990 = parser.getText();
						} else if (text == 'rulingDate') {
							rulingDate = parser.getText();
						} else if (text == 'nteeCode') {
							nteeCode = parser.getText();
						} else if (text == 'groupName') {
							groupName = parser.getText();
						} else if (text == 'deductibilityCode') {
							deductibilityCode = parser.getText();
						} else if (text == 'affiliation') {
							affiliation = parser.getText();
						} else if (text == 'foundationStatus') {
							foundationStatus = parser.getText();
						} else if (text == 'nteeClassification') {
							nteeClassification = parser.getText();
						} else if (text == 'accountingPeriod') {
							accountingPeriod = parser.getText();
						} else if (text == 'exemptOrgStatus') {
							exemptOrgStatus = parser.getText();
						} else if (text == 'deductibilityDetail') {
							deductibilityDetail = parser.getText();
						} else if (text == 'exemptOrgStatusCode') {
							exemptOrgStatusCode = parser.getText();
						} else if (text == 'nteeLetter') {
							nteeLetter = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'IrsClassification consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Rapid_links {
		@AuraEnabled
		public Related related {get;set;} 

		public Rapid_links(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'related') {
							related = new Related(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Rapid_links consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class MailingAddress {
		@AuraEnabled
		public Object country {get;set;} 
		@AuraEnabled
		public String stateOrProvince {get;set;} 
		@AuraEnabled
		public Object city {get;set;} 
		@AuraEnabled
		public Object postalCode {get;set;} 
		@AuraEnabled
		public Object streetAddress1 {get;set;} 
		@AuraEnabled
		public Object streetAddress2 {get;set;} 

		public MailingAddress(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'country') {
							country = parser.getText();
						} else if (text == 'stateOrProvince') {
							stateOrProvince = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'postalCode') {
							postalCode = parser.getText();
						} else if (text == 'streetAddress1') {
							streetAddress1 = parser.getText();
						} else if (text == 'streetAddress2') {
							streetAddress2 = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'MailingAddress consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Advisories {
		@AuraEnabled
		public String severity {get;set;} 
		@AuraEnabled
		public Active active {get;set;} 

		public Advisories(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'severity') {
							severity = parser.getText();
						} else if (text == 'active') {
							active = new Active(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Advisories consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public static List<CharityOrganization> parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return arrayOfJSON2Apex(parser);
	}

	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

	private static List<CharityOrganization> arrayOfJSON2Apex(System.JSONParser p) {
		List<CharityOrganization> res = new List<CharityOrganization>();
		if (p.getCurrentToken() == null) {
			p.nextToken();
		}
		while (p.nextToken() != System.JSONToken.END_ARRAY) {
			res.add(new CharityOrganization(p));
		}
		return res;
	}

}