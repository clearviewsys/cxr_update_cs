//%attributes = {}
// validateInvoice_AMLRulesPro
//[ServerPrefs];"Preferences"
// [invoices];"Entry"

C_LONGINT:C283($n)
C_BOOLEAN:C305($isAMLRuleEngineLicensed)

$n:=ds:C1482.AML_AggrRules.all().length  // number of rules defined
$isAMLRuleEngineLicensed:=(getKeyValue("AMLRule.License"; "Basic")="Pro")

checkAddWarningOnTrue((($n>0) & (Not:C34($isAMLRuleEngineLicensed))); "The AML Rule Pro engine is not licensed!")
checkAddWarningOnTrue((<>doFINTRACChecks & isSLAExpired); "SLA has expired! some Compliance features have been deactivated!")
// getbuild
If (isSLAValid & <>useAMLRules & $isAMLRuleEngineLicensed & ($n>=1))  // SLA must be valid, Rule Engine Pro; at least one rule defined
	// getBuild
	agg_validateInvoiceOnSave
End if 