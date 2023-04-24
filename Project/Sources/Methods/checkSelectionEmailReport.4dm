//%attributes = {}


C_TEXT:C284($confirmString; $errorString)
C_BOOLEAN:C305($hasError; $isEmailValid)
C_TEXT:C284($reportText)

// adding some declaration to fix bugs
C_REAL:C285($setSize)
C_OBJECT:C1216($cus; $customers; $res)
C_OBJECT:C1216($status)  // to see if saving is successful or not.
C_LONGINT:C283($repeatCount; $progressBarID; $currentRecordNum)


$setSize:=Records in selection:C76([Customers:3])
$confirmString:="You are about to check "+String:C10($setSize)+" email(s). Would you like to continue?"+\
"\n"+"This may take a few moments!"
myConfirm($confirmString)
If (OK=1)
	$reportText:=""
	
	$currentRecordNum:=0
	$progressBarID:=Progress New
	Progress SET MESSAGE($progressBarID; "Checking "+String:C10($setSize)+" emails...")
	
	
	$customers:=Create entity selection:C1512([Customers:3])
	
	
	
	For each ($cus; $customers)
		$hasError:=False:C215
		Progress SET PROGRESS($progressBarID; $currentRecordNum/$setSize)
		
		If ($cus.Email="")
			$res:=New object:C1471
			OB SET:C1220($res; "response"; New object:C1471)
		Else 
			$res:=validateEmailWithZeroBounce($cus.Email)
			
			If (OB Is defined:C1231($res; "response"))
				If (OB Is defined:C1231($res.response; "status"))
					
					If ($res.response.status#"invalid")
						$isEmailValid:=True:C214
					Else 
						$isEmailValid:=False:C215
					End if 
					
					If ($isEmailValid=False:C215)
						$reportText:=$reportText+$cus.CustomerID+"\t"+$cus.LastName+"\t"+$cus.Email+"\r"
					End if 
					
				Else 
					$hasError:=True:C214
					// This code here is only run when the server fails 
				End if 
				
			Else 
				$hasError:=True:C214
			End if 
			
		End if 
		
		
		
		If ($hasError=True:C214)
			$errorString:=$errorString+"\n"+String:C10($cus.CustomerID)+" - "+$cus.Email
		End if 
		$currentRecordNum:=$currentRecordNum+1
	End for each 
	
	Progress QUIT($progressBarID)
	
	//If ($hasError=True)
	//myAlert ($errorString)
	//End if 
	
	Case of 
		: ($reportText="") & ($errorString="")
			myAlert("Emails have been verified - ALL VALID")
			
		: ($errorString#"")
			$errorString:="There was an error validating emails for the following customers:\r"+$errorString
			
			SET TEXT TO PASTEBOARD:C523($errorString)
			myAlert("ERROR records are on the clipboard.\r"+$errorString)
			
		Else 
			SET TEXT TO PASTEBOARD:C523($reportText)
			myAlert("Emails have been verified - INVALID records are on the clipboard.\r"+$reportText)
	End case 
	
End if 

