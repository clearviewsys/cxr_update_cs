//%attributes = {}
// pickEwire (->field; command;$forceDialog)
// [eWires];"Pick"


C_POINTER:C301($1; $fieldPtr)
C_TEXT:C284($2; $command; $eWireID; $0)
C_BOOLEAN:C305($onSelection; $forceDialog; $3)

Case of 
		
	: (Count parameters:C259=0)
		$fieldPtr:=->$eWireID
		$command:="selectReceivedeWires"
		$forceDialog:=True:C214
		
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$command:=$2
		
	: (Count parameters:C259=3)
		$fieldPtr:=$1
		$command:=$2
		$forceDialog:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($command#"")
	$onSelection:=True:C214
	VQUERYCOMMAND:=$command
Else 
	$onSelection:=False:C215
End if 

pickRecordForTable(->[eWires:13]; ->[eWires:13]eWireID:1; $fieldPtr; $onSelection; $forceDialog)
