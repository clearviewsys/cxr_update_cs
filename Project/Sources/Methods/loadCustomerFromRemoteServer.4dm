//%attributes = {}
//loadCustomerFromRemoteServer(uniqueID)

C_POINTER:C301($tablePtr)
C_BLOB:C604($blob)
C_TEXT:C284($key; $recordID; $1)
C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n)

$recordID:=$1

$tablePtr:=->[Customers:3]
progressBarHandlingTemplate
$progress:=launchProgressBar("Loading Customer from remote server...")

$n:=Get last field number:C255($tablePtr)
$i:=1

Repeat 
	If (Is field number valid:C1000($tablePtr; $i))  // Jan 16, 2012 18:29:02 -- I.Barclay Berry 
		$key:=Table name:C256($tablePtr)+"_"+$recordID+"_"+String:C10($i)  // create a unique key
		fieldToBLOB(Field:C253(Table:C252($tablePtr); $i); ->$blob)  // convert the value of the field to a blob
		$blob:=ws_getKeyValueAsBLOB(<>clientCode; <>clientKey; $key)  // write the blob to the remote server
		If (BLOB size:C605($blob)>0)
			BLOBtofield(Field:C253(Table:C252($tablePtr); $i); ->$blob; 0; BLOB size:C605($blob))
		End if 
		DELETE FROM BLOB:C560($blob; 0; BLOB size:C605($blob))  // reset the size fo the blob
		
		refreshProgressBar($progress; $i; $n)
		setProgressBarTitle($progress; Field name:C257(Table:C252($tablePtr); $i))
	End if 
	
	$i:=$i+1
Until (($i>$n) | (isProgressBarStopped($progress)))
HIDE PROCESS:C324($progress)


