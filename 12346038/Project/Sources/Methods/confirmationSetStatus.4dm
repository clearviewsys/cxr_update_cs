//%attributes = {}


C_TEXT:C284($1; $tID)
C_LONGINT:C283($2; $iStatus)
C_TEXT:C284($3; $tUser)
C_TEXT:C284($4; $tReason)


C_LONGINT:C283($0; $iError)

C_BOOLEAN:C305($bReadOnly)
C_LONGINT:C283($iTimeOut; $iWait; $iPause)

$tID:=$1
$iStatus:=$2

If (Count parameters:C259>=3)
	$tUser:=$3
Else 
	$tUser:=getSystemUserName
End if 

If (Count parameters:C259>=4)
	$tReason:=$4
Else 
	$tReason:=""
End if 


$iError:=0

If (In transaction:C397)  //do this in a new process
	If (Current user:C182="designer")
		//TRACE
	End if 
	
	C_OBJECT:C1216($o)
	$o:=New object:C1471
	$o.status:=$iStatus
	$o.id:=$tID
	$o.user:=$tUser
	$o.reason:=$tReason
	
	$iError:=confirmationSetStatus_($o)
	
Else 
	
	$bReadOnly:=Read only state:C362([Confirmations:153])
	
	READ WRITE:C146([Confirmations:153])
	
	
	If ($tID=[Confirmations:153]confirmationID:2)  //already have the confirmation
	Else 
		QUERY:C277([Confirmations:153]; [Confirmations:153]confirmationID:2=$tID)
	End if 
	
	
	If (Records in selection:C76([Confirmations:153])=1)
		
		If ([Confirmations:153]status:12=confirmationUnknown)  //ok to set - ONCE SET DO NOT CHANGE
			$iTimeOut:=120
			$iWait:=0
			$iPause:=30
			
			While (Locked:C147([Confirmations:153])) | ($iWait>=$iTimeOut)
				DELAY PROCESS:C323(Current process:C322; $iPause)
				LOAD RECORD:C52([Confirmations:153])
				$iWait:=$iWait+$iPause
			End while 
			
			If (Locked:C147([Confirmations:153]))
				$iError:=-1  //unsuccessful in loading record
			Else 
				[Confirmations:153]status:12:=$iStatus
				[Confirmations:153]confirmedReason:11:=$tReason
				[Confirmations:153]confirmedUser:10:=$tUser
				[Confirmations:153]confirmedDate:8:=Current date:C33
				[Confirmations:153]confirmedTime:9:=Current time:C178
				SAVE RECORD:C53([Confirmations:153])
			End if 
		End if 
	End if 
	
	
	If ($bReadOnly)
		UNLOAD RECORD:C212([Confirmations:153])
		READ ONLY:C145([Confirmations:153])
		LOAD RECORD:C52([Confirmations:153])
	End if 
	
End if 

$0:=$iError