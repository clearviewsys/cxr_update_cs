//%attributes = {}
//saveCustomerOnRemoteServer(uniqueID)

C_POINTER:C301($tablePtr)
C_BLOB:C604($blob)
C_TEXT:C284($key; $recordID; $1)
C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)

$recordID:=$1

$tablePtr:=->[Customers:3]

$progress:=launchProgressBar("Writing Customer to remote server...")
$i:=1
$n:=Get last field number:C255($tablePtr)
Repeat 
	If (Is field number valid:C1000($tablePtr; $i))  // Jan 16, 2012 18:30:55 -- I.Barclay Berry 
		$key:=Table name:C256($tablePtr)+"_"+$recordID+"_"+String:C10($i)  // create a unique key
		fieldToBLOB(Field:C253(Table:C252($tablePtr); $i); ->$blob)  // convert the value of the field to a blob
		//If (BLOB size($blob)>2)
		ws_setKeyValueAsBlob(<>clientCode; <>clientKey; $key; $blob)  // write the blob to the remote server
		
		
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; "Writing Field :"+String:C10($i)+"-"+Field name:C257(Table:C252($tablePtr); $i))
		//End if 
		DELETE FROM BLOB:C560($blob; 0; BLOB size:C605($blob))  // reset the size fo the blob
	End if 
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))

HIDE PROCESS:C324($progress)

