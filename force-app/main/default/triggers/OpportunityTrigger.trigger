trigger OpportunityTrigger on Opportunity (before insert) {
	TriggerHandler_Opportunity.closeOpportunity(Trigger.new);
}