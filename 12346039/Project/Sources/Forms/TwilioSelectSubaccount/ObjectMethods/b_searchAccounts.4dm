C_TEXT:C284($sid; $name; $error; $status)
C_OBJECT:C1216($oResponse)
C_POINTER:C301($pError)
C_LONGINT:C283($i)
ARRAY TEXT:C222(drop_subAccounts; 0)
ARRAY TEXT:C222($accountNames; 0)
ARRAY TEXT:C222(twilioSubAccounts; 0)
$pError:=->$error


$sid:=Form:C1466.accountSid
$name:=Form:C1466.accountName

If ($sid#"")
	$name:=twilioGetSubAccountById($pError; $sid)
	If ($error#"")
		myAlert("Error getting account by ID. "+$error)
	Else 
		APPEND TO ARRAY:C911(twilioSubAccounts; $sid)
		APPEND TO ARRAY:C911($accountNames; $name)
		COPY ARRAY:C226($accountNames; drop_subAccounts)
		drop_subAccounts:=1
	End if 
Else 
	If ($name#"")
		$oResponse:=twilioGetSubAccountByName($pError; $name)
		If ($error#"")
			myAlert("Error getting account by Name: "+$error)
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
	Else 
		myAlert("Please enter an accound SID or Name to search for.")
	End if 
End if 