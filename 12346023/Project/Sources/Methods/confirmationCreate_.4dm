//%attributes = {}


//need to do this in a new process and return the ID

C_OBJECT:C1216($1; $o)

C_LONGINT:C283($2; $iCallingProcess)


C_TEXT:C284($0; _CONFIRMATION_ID)

C_LONGINT:C283($iProcess)


If (Count parameters:C259>=1)
	$o:=$1
Else 
	$o:=New object:C1471
End if 

//If (Count parameters>=2)
//$tMessage:=$2
//Else 
//$tMessage:="Default message"
//End if 

If (Count parameters:C259>=2)  //new process needed
	$iCallingProcess:=$2
Else 
	$iCallingProcess:=-1
End if 

_CONFIRMATION_ID:=""

If ($iCallingProcess=-1)  //start a new process and pass in this process number
	
	If (False:C215)
		$iProcess:=New process:C317(Current method name:C684; 0; Current method name:C684; $o; Current process:C322)
	Else 
		CALL WORKER:C1389(1; Current method name:C684; $o; Current process:C322)
	End if 
	
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 1)
	Until (_CONFIRMATION_ID#"")
	
	$0:=_CONFIRMATION_ID
	
Else 
	If (Current user:C182="designer")
		//TRACE
	End if 
	_CONFIRMATION_ID:=""
	
	CREATE RECORD:C68([Confirmations:153])
	[Confirmations:153]confirmationID:2:=makeConfirmationID
	[Confirmations:153]UUID:1:=Generate UUID:C1066
	[Confirmations:153]status:12:=confirmationUnknown
	[Confirmations:153]requestDate:3:=Current date:C33
	[Confirmations:153]requestTime:4:=Current time:C178
	[Confirmations:153]requestUser:7:=getSystemUserName  //"test request"
	[Confirmations:153]confirmCode:17:=generateRandomString(4)
	
	If ($o.type=Null:C1517)
		[Confirmations:153]confirmationType:5:=1
	Else 
		[Confirmations:153]confirmationType:5:=$o.type
		OB REMOVE:C1226($o; "type")
	End if 
	
	If ($o.message=Null:C1517)
		[Confirmations:153]confirmationMessage:6:=getKeyValue("confirmation.default.message"; "Please review this confirmation request and approve or deny. Thank you.")
	Else 
		[Confirmations:153]confirmationMessage:6:=$o.message
		OB REMOVE:C1226($o; "message")
	End if 
	
	If ($o.subject=Null:C1517)
		[Confirmations:153]confirmationSubject:16:=getKeyValue("confirmation.default.subject"; "[ALERT] Confirmation Request")
	Else 
		[Confirmations:153]confirmationSubject:16:=$o.subject
		OB REMOVE:C1226($o; "subject")
	End if 
	
	If ($o.relatedTable=Null:C1517)
	Else 
		[Confirmations:153]relatedTable:13:=$o.relatedTable
		OB REMOVE:C1226($o; "relatedTable")
	End if 
	
	If ($o.relatedID=Null:C1517)
	Else 
		[Confirmations:153]relatedID:14:=$o.relatedID
		OB REMOVE:C1226($o; "relatedID")
	End if 
	
	If (OB Is empty:C1297($o))
	Else 
		[Confirmations:153]confirmObject:15:=$o  //add any remaining properties to the confirmObject
	End if 
	
	SAVE RECORD:C53([Confirmations:153])
	
	_CONFIRMATION_ID:=[Confirmations:153]confirmationID:2
	
	UNLOAD RECORD:C212([Confirmations:153])
	READ ONLY:C145([Confirmations:153])
	LOAD RECORD:C52([Confirmations:153])
	
	SET PROCESS VARIABLE:C370($iCallingProcess; _CONFIRMATION_ID; _CONFIRMATION_ID)
	
	//no $0 for this we pass back with set process var
	
End if 

