//%attributes = {}


//need to do this in a new process and return the ID

C_OBJECT:C1216($1; $o)

C_LONGINT:C283($2; $iCallingProcess)  //don't use this - This method handles this

C_LONGINT:C283($0; _CONFIRMATION_ERROR)

C_BOOLEAN:C305($bReadOnly)
C_TEXT:C284($tID)
C_LONGINT:C283($iPause; $iTimeOut; $iWait)


If (Count parameters:C259>=1)
	$o:=$1
Else 
	$o:=New object:C1471
End if 


If (Count parameters:C259>=2)  //this is the new process 
	$iCallingProcess:=$2
Else 
	$iCallingProcess:=-1  //need to create a new process
End if 

_CONFIRMATION_ERROR:=1

If ($iCallingProcess=-1)  //start a new process and pass in this process number
	
	CALL WORKER:C1389(1; Current method name:C684; $o; Current process:C322)
	
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 1)
	Until (_CONFIRMATION_ERROR<1)
	
	$0:=_CONFIRMATION_ERROR
	
Else 
	If (Current user:C182="designer")
		//TRACE
	End if 
	_CONFIRMATION_ERROR:=1  //errors will be 0 or negative
	
	$bReadOnly:=Read only state:C362([Confirmations:153])
	READ WRITE:C146([Confirmations:153])
	
	$tID:=$o.id
	
	If ($tID="")  //unknown
		_CONFIRMATION_ERROR:=confirmationNotFound
	Else 
		QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)
		
		If (Records in selection:C76([Confirmations:153])=1)
			
			If ([Confirmations:153]status:12=confirmationUnknown)  //ok to set - ONCE SET DO NOT CHANGE
				$iTimeOut:=120
				$iWait:=0
				$iPause:=30
				
				While (Locked:C147([Confirmations:153])) | ($iWait>=$iTimeOut)
					
					If (Current user:C182="designer")
						TRACE:C157
						C_OBJECT:C1216($o)
						$o:=New object:C1471
						$o:=Get locked records info:C1316([Confirmations:153])
					End if 
					
					DELAY PROCESS:C323(Current process:C322; $iPause)
					LOAD RECORD:C52([Confirmations:153])
					$iWait:=$iWait+$iPause
				End while 
				
				If (Locked:C147([Confirmations:153]))
					_CONFIRMATION_ERROR:=-1  //unsuccessful in loading record
				Else 
					
					If ($o.status=Null:C1517)  //this is an error
						[Confirmations:153]status:12:=confirmationUnknown
					Else 
						[Confirmations:153]status:12:=$o.status
					End if 
					
					If ($o.user=Null:C1517)
					Else 
						[Confirmations:153]confirmedUser:10:=$o.user
					End if 
					
					If ($o.reason=Null:C1517)
					Else 
						[Confirmations:153]confirmedReason:11:=$o.reason
					End if 
					
					[Confirmations:153]confirmedDate:8:=Current date:C33
					[Confirmations:153]confirmedTime:9:=Current time:C178
					
					SAVE RECORD:C53([Confirmations:153])
					
					_CONFIRMATION_ERROR:=0
				End if 
			End if 
			
		Else 
			_CONFIRMATION_ERROR:=confirmationNotFound
		End if 
		
		UNLOAD RECORD:C212([Confirmations:153])
		
		If ($bReadOnly)
			READ ONLY:C145([Confirmations:153])
			LOAD RECORD:C52([Confirmations:153])
		End if 
		
	End if 
	
	SET PROCESS VARIABLE:C370($iCallingProcess; _CONFIRMATION_ERROR; _CONFIRMATION_ERROR)
	
	//no $0 for this we pass back with set process var
	
End if 

