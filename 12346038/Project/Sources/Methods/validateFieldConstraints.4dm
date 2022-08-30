//%attributes = {}


checkIfNullString(->[FieldConstraints:69]TableName:5; "Table Name")
checkIfNullString(->[FieldConstraints:69]FieldName:6; "Field Name")
checkIfNullString(->[FieldConstraints:69]FieldLabel:3; "Field")

checkGreaterThan(->[FieldConstraints:69]FieldNo:2; "Field No"; 0)
checkGreaterThan(->[FieldConstraints:69]TableNo:1; "Table No"; 0)

If ([FieldConstraints:69]isConditional:7)  // do not cheque for conditional fields
	checkIfNullString(->[FieldConstraints:69]GroupName:8; "Conditional Group Name")
End if 