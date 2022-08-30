//%attributes = {}
// pickAML_RiskTemplates(object; forceDialog)

C_POINTER:C301($self; $1)
C_BOOLEAN:C305($forceDialog; $2)

Case of 
	: (Count parameters:C259=0)
		$self:=->[AML_RiskTemplates:138]RiskTemplateID:2
		$forceDialog:=True:C214
	: (Count parameters:C259=1)
		$self:=$1
		$forceDialog:=False:C215
	: (Count parameters:C259=2)
		$self:=$1
		$forceDialog:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickRecordForTable(->[AML_RiskTemplates:138]; ->[AML_RiskTemplates:138]RiskTemplateID:2; $self; True:C214; $forceDialog)