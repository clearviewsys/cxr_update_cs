//%attributes = {}
C_TEXT:C284($1; $accountID; $formName)
C_TEXT:C284($2; $webeWireID)
C_OBJECT:C1216($account; $webEwire; $formObj)

C_LONGINT:C283($winref)

$accountID:=$1
$webeWireID:=$2

$account:=ds:C1482.Accounts.query("AccountID = :1"; $accountID).first()

If ($account#Null:C1517)
	If ($account.AccountCode="MGRAM")
		
		$formName:="MG_PayReceive"
		
		$webEwire:=ds:C1482.WebEWires.query("WebEwireID = :1"; $webeWireID).first()
		
		If ($webEwire#Null:C1517)
			
			$formObj:=$webEwire.toObject()
			
			$winref:=Open form window:C675([WebEWires:149]; "MG_PayReceive")
			DIALOG:C40([WebEWires:149]; "MG_PayReceive"; $formObj)
			CLOSE WINDOW:C154
			
			If (OK=1)
				// do nothing here, nothing can be change at the moment
			End if 
			
		End if 
		
	End if 
End if 

