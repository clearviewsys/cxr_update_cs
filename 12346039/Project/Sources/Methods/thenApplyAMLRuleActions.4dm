//%attributes = {}
// thenApplyRuleActions
// #ORDA
// #AML ; #TB; #KYC

C_OBJECT:C1216($ruleEntity; $customerEntity; $invoiceObj; $1; $2; $3)
C_BOOLEAN:C305($isDuringInvoice; $4)

C_TEXT:C284($methodName)

Case of 
	: (Count parameters:C259=3)
		$ruleEntity:=$1
		$invoiceObj:=$2
		$customerEntity:=$3
		$isDuringInvoice:=True:C214
	: (Count parameters:C259=4)
		$ruleEntity:=$1
		$invoiceObj:=$2
		$customerEntity:=$3
		$isDuringInvoice:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// remote #CONFIRMATION 
If (($ruleEntity.thenRequireApproval) & ($isDuringInvoice) & (Not:C34(isUserManager)))  // don't require approval when running a batch process
	// #IBB #confirmation
	
	// Barclay's confirmation method shall be executed here
	C_TEXT:C284($confirmID)
	C_LONGINT:C283($iError; $iStatus)
	
	If (checkErrorExist)
		myAlert("Supervisor Approval required!"+CRLF+" Please fix these errors before proceeding: "+CRLF+checkGetErrorString)
	Else 
		C_OBJECT:C1216($confirmObj)
		$confirmObj:=confirmationRequestForInvoice
		$iStatus:=$confirmObj.status
		
		If ($iStatus=confirmationApprove)
			myAlert(confirmationGetStatusText($iStatus))
		End if 
		checkAddErrorIf($iStatus#confirmationApprove; "Remote Authorization Status: "+confirmationGetStatusText($iStatus))
	End if 
End if 


checkAddWarningIf($ruleEntity.thenWarn; $ruleEntity.WarningMessage)
//[AML_AggrRules]WarningMessage

If ($ruleEntity.thenAML_Alert)  // create a new AML_Alert record
	createRecordAML_Alert($ruleEntity.ruleID; $ruleEntity.ruleName; $ruleEntity.description+CRLF+checkGetWarningString+CRLF+checkGetErrorString; [Invoices:5]CustomerID:2; Table:C252(->[Invoices:5]); [Invoices:5]InvoiceID:1)
End if 
//[AML_AggrRules]ruleID
If ($ruleEntity.thenReject)
	//[AML_AggrRules]thenReject
	checkAddErrorIf($ruleEntity.thenReject; "Transaction REJECTED! \r\nPlease Refer to AML Rule:"+$ruleEntity.ruleID+"\r\n"+$ruleEntity.ruleName+"\r\n"+$ruleEntity.description)
End if 

setBooleanIf($ruleEntity.thenSetFlag; ->[Invoices:5]isFlagged:41)
setBooleanIf($ruleEntity.thenSetLCT; ->[Invoices:5]isLCT:76)
setBooleanIf($ruleEntity.thenSetEFT; ->[Invoices:5]isEFT:77)
setBooleanIf($ruleEntity.thenSetSTR; ->[Invoices:5]isSuspicious:30)
setBooleanIf($ruleEntity.thenSetReportable; ->[Invoices:5]isAMLReportable:46)

C_DATE:C307($date)
$date:=Add to date:C393([Invoices:5]invoiceDate:44; 0; 0; $ruleEntity.thenReportInDays)
If ($ruleEntity.thenSetReportable)
	//[Invoices];"Entry"
	[Invoices:5]AMLmustReportBeforeDate:78:=$date
End if 

If (($ruleEntity.thenSetSTR) & ([Invoices:5]suspiciousNotes:31=""))
	[Invoices:5]suspiciousNotes:31:="Matched with Rule "+$ruleEntity.ruleName+" on "+String:C10(Current date:C33)+CRLF+$ruleEntity.description
End if 

If ($ruleEntity.thenAddTag#"")
	// if the tag doesn't exist in the tag then add it
	If (Position:C15($ruleEntity.thenAddTag; $customerEntity.tags)=0)
		$customerEntity.tags:=$ruleEntity.thenAddTag+" "+$customerEntity.tags
	End if 
End if 

//[AML_AggrRules];"Match"
If ($isDuringInvoice)
	$methodName:=$ruleEntity.thenExecuteMethod
	If ($methodName#"")
		If (UTIL_isMethodExists($methodName))
			EXECUTE METHOD:C1007($methodName)
		Else 
			notifyAlert("Execution failed"; "Method does not exist: "+$methodName; 15)
		End if 
	End if 
End if 