C_TEXT:C284($error)
C_OBJECT:C1216($oResponse)
C_LONGINT:C283($i)
C_POINTER:C301($pError)
ARRAY TEXT:C222(twilioSubAccounts; 0)
ARRAY TEXT:C222($accountNames; 0)
ARRAY TEXT:C222(drop_subAccounts; 0)
$pError:=->$error

$oResponse:=twilioGetAllSubAccounts($pError)
If ($error#"")
	myAlert("Error getting accounts: "+$error)
Else 
	$i:=0
	While ($i<$oResponse.accounts.length)
		APPEND TO ARRAY:C911(twilioSubAccounts; $oResponse.accounts[$i].sid)
		APPEND TO ARRAY:C911($accountNames; $oResponse.accounts[$i].friendly_name)
		$i:=$i+1
	End while 
	If ($i>0)
		COPY ARRAY:C226($accountNames; drop_subAccounts)
	End if 
End if 



