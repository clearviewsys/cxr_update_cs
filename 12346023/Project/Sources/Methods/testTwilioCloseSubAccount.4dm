//%attributes = {}
C_TEXT:C284($error)
C_POINTER:C301($pError)
C_OBJECT:C1216($response; $deleteResponse)
C_LONGINT:C283($i)
$pError:=->$error

$response:=twilioGetAllSubAccounts($pError)

If ($error#"")
	myAlert($error)
Else 
	$i:=0
	While ($i<=$response.accounts.length)
		If ($response.accounts[$i].sid#$response.accounts[$i].owner_account_sid)
			$deleteResponse:=twilioCloseSubAccount($pError; $response.accounts[$i].sid)
			$i:=$i+1
		End if 
	End while 
End if 

myAlert("done "+String:C10($i))