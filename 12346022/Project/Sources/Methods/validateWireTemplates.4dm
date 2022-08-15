//%attributes = {}
checkUniqueKey(->[WireTemplates:42]; ->[WireTemplates:42]WireTemplateID:1; "Wire Template ID")
checkIfNullString(->[WireTemplates:42]WireTemplateAlias:14; "Wire Template Alias")
checkIfNullString(->[WireTemplates:42]CustomerID:2; "Customer ID"; "*")
checkIfNullString(->[WireTemplates:42]AccountNo:6; "Account No."; "*")
checkIfNullString(->[WireTemplates:42]BeneficiaryFullName:9; "Beneficiary full name"; "*")
checkIfNullString(->[WireTemplates:42]relationship:34; "Relationship"; "")
