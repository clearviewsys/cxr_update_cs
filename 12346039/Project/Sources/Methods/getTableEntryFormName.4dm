//%attributes = {}
C_TEXT:C284($0; $form)
C_POINTER:C301($tablePtr; $1)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[CompanyInfo:7]
		
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

Case of 
	: ($tablePtr=->[KeyValues:115])  // KeyValues is an exception and cannot look for its own 
		$form:="Entry"
	: ($tablePtr=->[Audit:118])  // Audit should not be allowed to edit so show the view 
		$form:="View"
	Else 
		$form:=getKeyValue("Form."+Table name:C256($tablePtr)+".Entry"; "Entry")
End case 
$0:=$form