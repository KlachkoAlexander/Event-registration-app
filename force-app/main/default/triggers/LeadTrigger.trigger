trigger LeadTrigger on Lead (before update) {
	TriggerHandler_Lead.preventDupLead(Trigger.new);
}