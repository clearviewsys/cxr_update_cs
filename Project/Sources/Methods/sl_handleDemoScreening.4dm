//%attributes = {}
#DECLARE($inputTypeParam : Text; $formEventParam : Integer)

var $inputType : Text
var $formEvent : Integer
var $trigger : Boolean

Case of 
	: (Count parameters:C259=1)
		$inputType:=$inputTypeParam
		$formEvent:=Form event code:C388
		
	: (Count parameters:C259=2)
		$inputType:=$inputTypeParam
		$formEvent:=$formEventParam
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

If ($inputType=sl_ForInputBox)
	$trigger:=$formEvent=On Data Change:K2:15
	var $isScreenReady : Boolean
	$isScreenReady:=Form:C1466.names.currentValue#""
	If (OB Is defined:C1231(Form:C1466; "options"))
		$isScreenReady:=$isScreenReady && (Form:C1466.options.data.dob#!00-00-00!)
		$isScreenReady:=$isScreenReady && (Form:C1466.options.data.nationality#"")
		$isScreenReady:=$isScreenReady && (Form:C1466.options.data.idNumber#"")
		Form:C1466.options.isScreenReady:=$isScreenReady
	End if 
Else 
	$trigger:=$formEvent=On Clicked:K2:4
	If (OB Is defined:C1231(Form:C1466; "options"))
		Form:C1466.options.isScreenReady:=True:C214
	End if 
End if 

If ($trigger)
	Form:C1466.result:=""
	Form:C1466.ran:=""
	Form:C1466.sanctions:=""
	Form:C1466.peps:=""
End if 

var $result : cs:C1710.SanctionListResult
$result:=sl_handleScreening($inputType; Form:C1466.isEntity; Form:C1466.names.currentValue; Form:C1466.options)
If ($result#Null:C1517)
	OBJECT Get pointer:C1124(Object named:K67:5; "var_indicator")->:=\
		sl_setSanctionListIcon($result.resultCode)
	OBJECT Get pointer:C1124(Object named:K67:5; "txt_result")->:=$result.resultText
	If (Form:C1466.alwaysShow=1)
		If ($result.resultCode=0)
			$result.displayResults(False:C215)
		End if 
	End if 
Else 
	If (Form:C1466.options.useWorker)
		SET TIMER:C645(1)
	End if 
End if 