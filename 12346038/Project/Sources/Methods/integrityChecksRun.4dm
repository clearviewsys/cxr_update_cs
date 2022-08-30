//%attributes = {}
//integrityChecksRun($1-json text, optional) 
// format :  "{\"orphanRegisters\":\"True\",\"unbalancedInvoices\":\"True\",\"email\":\"test@email.com\",\"sms\":\"123245\",\"countryCode\":\"NZ\"}"
// if no parameter pass the orphanRegisters and unbalancedInvoices is true by default

C_TEXT:C284($1)
C_TEXT:C284($2; $logname)

C_OBJECT:C1216($obInfo; $ICFailedRecords; $register; $registers; $invoice; $invoices; $IntegrityChecks; $unbalInvoices)
C_COLLECTION:C1488($cInvoiceIDs)
C_LONGINT:C283($iUnbalancedInvoices)
C_REAL:C285($rSumDebits; $rSumCredits)
C_TEXT:C284($tOrphanRegistersMessage; $tUnbalancedInvoicesMessage; $tMessage)
C_LONGINT:C283($i; $iPercent; $iProgress)

$iUnbalancedInvoices:=0
$tOrphanRegistersMessage:=""
$tUnbalancedInvoicesMessage:=""

If (Count parameters:C259>=1)
	$obInfo:=JSON Parse:C1218($1)
	If ($obInfo=Null:C1517)
		$obInfo:=New object:C1471
	End if 
	If ($obInfo.orphanRegisters=Null:C1517)
		$obInfo.orphanRegisters:="False"
	End if 
	If ($obInfo.unbalancedInvoices=Null:C1517)
		$obInfo.unbalancedInvoices:="False"
	End if 
Else 
	$obInfo:=New object:C1471("orphanRegisters"; "True"; "unbalancedInvoices"; "true")
End if 

If (Count parameters:C259>=2)
	$logname:=$2
Else 
	$logname:=Current method name:C684
End if 

UTIL_Log($logname; Current method name:C684+": STARTING UP")
UTIL_Log($logname; "Parameters: "+$1)

If ($obInfo.orphanRegisters="True")
	
	$ICFailedRecords:=ds:C1482.IC_FailedRecords.query("IntegrityCheckID =:1"; "orphanRegisters").drop()  // drop old failed records
	$IntegrityChecks:=ds:C1482.IntegrityChecks.query("IntegrityCheckID =:1"; "IC_orphanRegisters").drop()  // drop old integrity checks records
	
	$cInvoiceIDs:=ds:C1482.Invoices.all().distinct("InvoiceID")
	$registers:=ds:C1482.Registers.query("not(InvoiceNumber in :1)"; $cInvoiceIDs)
	
	If ($registers.length>0)
		For each ($register; $registers)
			integrityChecksCreate("orphanRegisters"; $register.RegisterID; Table:C252(->[Registers:10]); "Register linked to a missing invoice")
		End for each 
	End if 
	
	UTIL_Log($logname; "Orphan Register ran with "+String:C10($registers.length)+" orphans found.")
End if 

If ($obInfo.unbalancedInvoices="True")
	$ICFailedRecords:=ds:C1482.IC_FailedRecords.query("IntegrityCheckID =:1"; "unbalancedInvoices").drop()  // drop old failed records
	$IntegrityChecks:=ds:C1482.IntegrityChecks.query("IntegrityCheckID =:1"; "IC_unbalancedInvoices").drop()  // drop old integrity checks records
	
	$invoices:=ds:C1482.Invoices.all()
	$unbalInvoices:=ds:C1482.Invoices.newSelection()
	
	$iProgress:=Progress New
	Progress SET ICON($iProgress; <>CompanyLogo)  //optional - add an icon
	Progress SET TITLE($iProgress; "Unbalanced Invoices")  //optional - add title line to the progress indicator (top)
	Progress SET BUTTON ENABLED($iProgress; True:C214)  //optional - enable the "stop" button
	
	$i:=0
	For each ($invoice; $invoices) While ($i<$invoices.length)
		$i:=$i+1
		$registers:=ds:C1482.Registers.query("InvoiceNumber =:1"; $invoice.InvoiceID)
		$rSumDebits:=$registers.sum("DebitLocal")
		$rSumCredits:=$registers.sum("CreditLocal")
		
		If ($rSumDebits#$rSumCredits)
			$iUnbalancedInvoices:=$iUnbalancedInvoices+1
			integrityChecksCreate("unbalancedInvoices"; $invoice.InvoiceID; Table:C252(->[Invoices:5]); "invoice balances are square")
			$unbalInvoices.add($invoice)
		End if 
		
		If (Progress Stopped($iProgress))  //did the user click the stop button
			$i:=$invoices.length+1  //bail out of the loop
		Else 
			If (Mod:C98($i; 100)=0)
				$iPercent:=$i/$invoices.length  //get percent complete
				Progress SET PROGRESS($iProgress; $iPercent; "Updating... "+String:C10($i))  //update the progress bar and the message
			End if 
		End if 
		
	End for each 
	
	
	Progress QUIT($iProgress)  //clean up
	
	UTIL_Log($logname; "Unbalanced Invoices ran with "+String:C10($iUnbalancedInvoices)+" invoices found.")
	
End if 


If ($obInfo.email#Null:C1517) | ($obInfo.sms#Null:C1517)
	If ($registers.length>0)
		$tOrphanRegistersMessage:="You have "+String:C10($registers.length)+" register records linked to a missing invoice."
	End if 
	If ($iUnbalancedInvoices>0)
		$tUnbalancedInvoicesMessage:="You have "+String:C10($iUnbalancedInvoices)+" unbalanced invoices."
	End if 
	
	If ($obInfo.sms#Null:C1517)
		sendNotificationBySMS($obInfo.sms; $tOrphanRegistersMessage+"|"+$tUnbalancedInvoicesMessage; $obInfo.countryCode)
	End if 
	
	If ($obInfo.email#Null:C1517)
		$tOrphanRegistersMessage:=$tOrphanRegistersMessage+"\r"
		For each ($register; $registers)
			$tOrphanRegistersMessage:=$tOrphanRegistersMessage+$register.RegisterID+"\r"
		End for each 
		
		$tUnbalancedInvoicesMessage:=$tUnbalancedInvoicesMessage+"\r"
		For each ($invoice; $unbalInvoices)
			$tUnbalancedInvoicesMessage:=$tUnbalancedInvoicesMessage+$invoice.InvoiceID+"\r"
		End for each 
		
		sendNotificationByEmail($obInfo.email; <>CompanyName+": Integrity check"; $tOrphanRegistersMessage+$tUnbalancedInvoicesMessage)  //UTIL_recordToText (Table($ptrTable)))
	End if 
	
	
End if 

UTIL_Log($logname; Current method name:C684+": COMPLETE")