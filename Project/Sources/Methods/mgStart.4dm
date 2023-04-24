//%attributes = {}
// validates values and starts PROFIX Web app in new process performing transaction

C_OBJECT:C1216($1; $formObj; $formData; $endpoints; $parameters; $validation; $link; $oneError; $credentialsCheck)
C_LONGINT:C283($procID; $winref)
C_TEXT:C284($formName; $msg)

$endpoints:=mgGetEndPoints

If (Count parameters:C259>0)
	
	$formObj:=mgCopyTransactionObject($1)
	
	If ($endPoints#Null:C1517)
		
		$formObj.credentials.locale:="en"
		$formObj.credentials.isDebug:="true"
		
		$formData:=New object:C1471
		$formData.credentials:=$formObj.credentials
		$formData.transaction:=$formObj.object
		
		// duplicate this in object property so we don't need to change mgCreateWebEWire method 20211004 @milan
		$formData.object:=$formObj.object
		$formData.customerID:=$formObj.customerID
		$formData.mywa:=$formObj.mywa
		$formData.useOldLogin:=$formObj.useOldLogin
		$formData.session:=New object:C1471
		$formData.session.endpoints:=$endpoints
		
		If (Shift down:C543)
			$formData.session.showProgress:=True:C214
		Else 
			$formData.session.showProgress:=False:C215
		End if 
		
		$formData.winref:=Frontmost window:C447  // we need this in order to get result from Profix by using CALL FORM
		
		If ($formObj.formName#Null:C1517)
			$formName:=$formObj.formName
		Else 
			$formName:="mgWebArea"
		End if 
		
		If ($formObj.linkID#Null:C1517)
			
			$link:=ds:C1482.Links.query("LinkID = :1"; $formObj.linkID).first()
			
			If ($link#Null:C1517)
				$formData.palette:=Open form window:C675([Links:17]; "Palette"; Palette form window:K39:9; On the left:K39:2)
				DIALOG:C40([Links:17]; "Palette"; $link; *)
			End if 
			
		End if 
		
		$winref:=Open form window:C675($formName)
		DIALOG:C40($formName; $formData)
		CLOSE WINDOW:C154
		
		If (True:C214)
			mgSaveProfixLog($formData.log)
		End if 
		
		
		If ($formData.WebewireID="")  // @ibb 12/6/22
		Else 
			C_TEXT:C284($invoiceId)
			$invoiceId:=ds:C1482.WebEWires.query("WebEwireID == :1"; $formData.WebewireID).first().paymentInfo.reservedinvoiceID
			USE ENTITY SELECTION:C1513(ds:C1482.Invoices.query("InvoiceID == :1"; $invoiceId))
			modifyRecordInvoices
		End if 
		
	End if 
	
Else 
	
	
	If (Form:C1466.object.transactionType#Null:C1517)
		
		$credentialsCheck:=mgSOAP_CheckCredentials(Form:C1466.credentials)
		
		If ($credentialsCheck.success)
			
			$validation:=mgValidateAll(Form:C1466)
			
			If ($validation.success)
				
				$formObj:=Form:C1466
				$procID:=New process:C317(Current method name:C684; 0; "MG_"+Generate UUID:C1066; $formObj)
				If ($procID#0)
					Form:C1466.canCloseWindow:=False:C215
				End if 
				
			Else 
				
				$msg:="Following fields have errors:\n\n"
				
				For each ($oneError; $validation.errors)
					If (Value type:C1509($oneError.value)=Is text:K8:3)
						$msg:=$msg+$oneError.propertyName+" value is "+$oneError.value
					Else 
						$msg:=$msg+$oneError.propertyName+" value is "+String:C10($oneError.value)
					End if 
					
					If ($oneError.mandatory#Null:C1517)
						$msg:=$msg+" mandatory "+$oneError.mandatory+"\n\n"
					End if 
					If ($oneError.mask#Null:C1517)
						$msg:=$msg+" mask "+$oneError.mask+"\n\n"
					End if 
				End for each 
				
				myAlert($msg)
				
			End if 
			
		Else 
			
			$msg:="Error connecting to MoneyGram servers. Please, check your credentials and certificates\n\n"
			$msg:=$msg+mgGetSOAPErrorDetails($credentialsCheck.mgerrormsg)
			
			myAlert($msg)
			
		End if 
		
	End if 
	
End if 
