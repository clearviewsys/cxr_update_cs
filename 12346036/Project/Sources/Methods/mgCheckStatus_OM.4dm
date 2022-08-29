//%attributes = {}
// call this method from button or menu item to check status of MoneyGram transaction

C_OBJECT:C1216($state)
C_COLLECTION:C1488($statuses; $found)
C_TEXT:C284($findState; $msg; $transferNumber)

Case of 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$transferNumber:=""
		If ([WebEWires:149]paymentInfo:35.result.referenceNumber#Null:C1517)
			$transferNumber:=[WebEWires:149]paymentInfo:35.result.referenceNumber
		End if 
		
		If ($transferNumber#"")
			
			$state:=mgCheckStatus($transferNumber)
			
			$msg:="Error connecting to MoneyGram SOAP API"
			
			If ($state.success)
				
				$msg:="No results returned"
				
				If ($state.result#Null:C1517)
					
					If ($state.result.length>0)
						
						$msg:="Couldn't get transfer state"
						
						If ($state.result[0].TransferState#Null:C1517)
							
							$statuses:=mgGetStatuses
							
							$findState:=$state.result[0].TransferState
							
							$found:=$statuses.query("statusCode = :1"; Num:C11($findState))
							
							If ($found#Null:C1517)
								If ($found.length>0)
									
									$msg:="Status of transaction with reference number "
									$msg:=$msg+[WebEWires:149]paymentInfo:35.result.referenceNumber
									$msg:=$msg+" returned by MoneyGram SOAP API is code "
									$msg:=$msg+String:C10($found[0].statusCode)+" "+$found[0].status
									
									READ WRITE:C146([WebEWires:149])
									LOAD RECORD:C52([WebEWires:149])
									
									If ([WebEWires:149]paymentInfo:35.statusCheck=Null:C1517)
										[WebEWires:149]paymentInfo:35.statusCheck:=New object:C1471
									End if 
									
									[WebEWires:149]paymentInfo:35.statusCheck.lastCheckDate:=Current date:C33
									[WebEWires:149]paymentInfo:35.statusCheck.lastCheckTime:=Current time:C178
									[WebEWires:149]paymentInfo:35.statusCheck.statusCode:=$found[0].statusCode
									[WebEWires:149]paymentInfo:35.statusCheck.status:=$found[0].status
									SAVE RECORD:C53([WebEWires:149])
									
									C_POINTER:C301($ptr)
									
									$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "checktime1")
									
									If ($ptr#Null:C1517)
										If ([WebEWires:149]paymentInfo:35.statusCheck#Null:C1517)
											$ptr->:=[WebEWires:149]paymentInfo:35.statusCheck.lastCheckTime
										End if 
									End if 
									
								End if 
							End if 
						End if 
					End if 
				End if 
				
			Else 
				
				$msg:=$msg+mgGetSOAPErrorDetails($state.mgerrormsg)
				
			End if 
			
			myAlert($msg)
			
		Else 
			
			myAlert("No reference number defined, couldn't get status")
			
		End if 
		
		
	: (Form event code:C388=On Load:K2:1)
		
		If ([WebEWires:149]paymentInfo:35.origin="SOAP")
			OBJECT SET VISIBLE:C603(*; "b_checkMGStatus@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "b_checkMGStatus@"; True:C214)
		End if 
		
End case 
