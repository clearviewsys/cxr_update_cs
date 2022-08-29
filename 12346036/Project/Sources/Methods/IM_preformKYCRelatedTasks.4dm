//%attributes = {}
// IM_preformKYCRelatedTasks($option)
// #ORDA
// $option = one of "onload", "send", "update", "detialing", "autocheck"
// Author: Wai-Kin

C_OBJECT:C1216($0; $log)
C_TEXT:C284($1; $option)

Case of 
	: (Count parameters:C259=1)
		$option:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($sendNew)
C_BOOLEAN:C305($update)

If (getKeyValue("identityMind.activated")="true")
	Case of 
		: ($option="onload")  // For when data is being loaded
			C_OBJECT:C1216($selection)
			$selection:=ds:C1482.IM_KYCLog.query("CustomerID=:1"; [Customers:3]CustomerID:1)
			If ($selection.length>0)
				$selection:=$selection.orderBy("ResponseDate desc, ResponseTime desc")
				$log:=$selection.first()
				$update:=True:C214
			End if 
			
		: ($option="send")  // For "Send to IdentityMind" Button
			$sendNew:=True:C214
			$update:=True:C214
			FORM GOTO PAGE:C247(6)
			
		: ($option="update")  // For "Update IdentityMind KYC" Button
			C_OBJECT:C1216($selection; $log)
			$selection:=ds:C1482.IM_KYCLog.query("IdentityMindID=:1"; IM_KYCId)
			$selection:=$selection.orderBy("ResponseDate desc, ResponseTime desc")
			$log:=IM_updateKYCReport($selection.first())
			$update:=True:C214
			
		: ($option="detailing")  // For "Show IdentityMind Details" Button
			C_OBJECT:C1216($selection; $log)
			$selection:=ds:C1482.IM_KYCLog.query("IdentityMindID=:1"; IM_KYCId)
			$selection:=$selection.orderBy("ResponseDate desc, ResponseTime desc")
			$log:=$selection.first()
			IM_showDetailKYCReport($log)
		: ($option="autoCheck")  // For the auto save option
			If ((getKeyValue("identityMind.autoCheckOnSave"; "False")="True"))
				If (Is new record:C668([Customers:3]))
					$sendNew:=True:C214
					$update:=True:C214
				End if 
			End if 
	End case 
End if 

If ($sendNew)
	C_OBJECT:C1216($customer)
	// $customer:=Create entity selection([Customers]) 
	// above doesn't work with new customer; workaround below
	$customer:=ds:C1482.Customers.new()
	C_LONGINT:C283($i)
	C_POINTER:C301($fldPtr)
	For ($i; 0; Get last field number:C255(->[Customers:3]))
		If (Is field number valid:C1000(->[Customers:3]; $i))
			C_TEXT:C284($fieldName)
			$fieldName:=Field name:C257(Table:C252(->[Customers:3]); $i)
			$fldPtr:=Field:C253(Table:C252(->[Customers:3]); $i)
			If ($fieldName#"_Sync_Data")
				$customer[$fieldName]:=$fldPtr->
			End if 
		End if 
	End for 
	// end workaround
	
	$log:=IM_evaluateCustomerKYC($customer)
End if 

If ($update)
	IM_KYCId:=$log.IdentityMindID
	IM_fraudRule:=$log.FraudRuleDetailFired
	IM_KYC_state:=$log.State
	Case of 
		: (IM_KYC_state="A")
			IM_KYC_state:="Accept"
		: (IM_KYC_state="D")
			IM_KYC_state:="Deny"
		: (IM_KYC_state="R")
			IM_KYC_state:="Under Review"
	End case 
	
	// set on hold
	If (IM_KYC_state#"Accept")
		C_TEXT:C284($frn; $message)
		$frn:=$log.FraudRuleNameFired
		$message:="IdentityMind match: "+$frn
		
		If ($option#"autoCheck")
			[Customers:3]isOnHold:52:=True:C214
			[Customers:3]AML_OnHoldNotes:127:=$message
		Else 
			// TODO Fix validateKYC
		End if 
	End if 
End if 
