//%attributes = {}

/* Read me

Some methods that are very useful for the AggrRule engine to work are listed here
*/

// form
// initStorageObject
// [AML_AggrRules];"match"
// [Customers];"View"




If (False:C215)
	
	agg_newRuleEntity  // creates a new AggrRule entity in memory and initalizes the object with default values 
	agg_newFilterFromForm  // creates a filter object from Form objects 
	agg_newFilterFromRule  // creates a filter object from a Rule entity
	// a filter is the object that initializes the rule
	// if the rule is the variable, the filter is the value 
	
	
	// getTransactionStats
	agg_getStatsObject  // returns a stat object with calculations on the registers table
	
	
	agg_runRulesOnInvoices()  // runs a series of rules on a selection of invoices
	agg_applyRulesToInvoices  // runs the rules on invoices during a date range
	agg_runRulesOnTodaysInvoices  // runs the rules on today's invoices only
	
	
	//validateInvoice_AML_AggrRules()  // loop that does the matching and then calls the actions
	agg_validateInvoiceOnSave()  // loop that does the matching and then calls the actions
	
	agg_valideInvoiceKYC  // checkCustomerKYCRequirements  // then check KYC requirements
	agg_validateInvoiceEDD  // checkInvoiceEDDRequirements  // then check EDD requirements
	
	
	// matchThisInvoice_vs_AMLRule renamed to
	agg_isRuleMatchingThisInvoice  // if rule applies ot 1 invoice only
	
	// matchCustomer_vs_AMLRule renamed to
	agg_isRuleMatchingThisCustomer  // if rule applies to a selection of records (same customer)
	
	
	// thenApplyAMLRuleActions()  // then actions are all here
	agg_thenApplyRuleActions
	
	//previous name: validateInvoice_AMLRulesPro
	agg_validateLicense  // this method checks to see if customer has valid license to use the pro rule engine
	
	//getHighRiskCountries
	//getHighRiskPOT
	//getHighRiskSOF
	
End if 
