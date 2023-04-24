//%attributes = {"publishedWeb":true}
// newRECORDS (-> [TABLE] { { ;boolean repeat} ; String EntryFormName} )

C_POINTER:C301($1; $tablePtr)
C_LONGINT:C283($param)
C_BOOLEAN:C305($2; $repeat)
C_TEXT:C284($3; $inputForm)
C_LONGINT:C283($winRef)

C_LONGINT:C283($i; $iCurrTransLevel; $iStartLevel)
C_TEXT:C284($tResult)

$param:=Count parameters:C259
$repeat:=False:C215

Case of 
	: ($param=0)
		$tablePtr:=->[Customers:3]
		
	: ($param=1)
		$tablePtr:=$1
		
	: ($Param=2)
		$tablePtr:=$1
		$repeat:=$2
		
	: ($param=3)
		$tablePtr:=$1
		$repeat:=$2
		$inputForm:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
If ($inputForm="")
	$inputForm:="Entry"
End if 
$inputForm:=getKeyValue("Form."+Table name:C256($tablePtr)+".Entry"; $inputForm)  // added by TB

READ WRITE:C146($tablePtr->)


Repeat 
	If (isTableAuthorizedforAddRecord($tablePtr))
		If (isUserAuthorizedToAddRecord($tablePtr))
			
			FORM SET INPUT:C55($tablePtr->; $inputForm)
			
			If ((Not:C34(Shift down:C543)) & (<>doRememberWindowPositions))
				$winRef:=Open form window:C675($tablePtr->; $inputForm; Plain window:K34:13; Horizontally centered:K39:1; At the top:K39:5; *)
			Else 
				$winRef:=Open form window:C675($tablePtr->; $inputForm; Plain window:K34:13; Horizontally centered:K39:1; At the top:K39:5)
			End if 
			
			BRING TO FRONT:C326($winRef)
			
			START TRANSACTION:C239
			
			$iStartLevel:=Transaction level:C961
			
			TM_Add2Stack($tablePtr; Current method name:C684; $iStartLevel)  //8/31/16
			
			// Modified by: Tiran Behrouz (2012-11-04)
			//DEFAULT TABLE($tablePtr->)  //IBB 4/2/20
			ADD RECORD:C56($tablePtr->; *)
			
			$iCurrTransLevel:=Transaction level:C961
			
			$tResult:=""
			
			Case of 
					//7/29/16 -- IBB added the validation testing and alerts
					
					//: (isApplyButtonClicked)  // Modified by: Barclay Berry (8/19/13)
					//isApplyButtonClicked:=False=
				: ($iCurrTransLevel=0)  //this shouldn't happen. if it does something else is validating the trans
					//nothing to validate at this point
					$tResult:="**[1]Transaction Validation Debug: Current="+String:C10($iCurrTransLevel)+" Starting="+String:C10($iStartLevel)+" Final level: "+String:C10(Transaction level:C961)+" OK Var: "+String:C10(OK)
					$tResult:=$tResult+"---"+Table name:C256($tablePtr)+" saved no validation: [1] invoice: "+[Invoices:5]InvoiceID:1+" "+[Invoices:5]CustomerFullName:54+" - "+[Invoices:5]comments:43+" From:"+String:C10([Invoices:5]fromAmount:25)+[Invoices:5]fromCurrency:3+" To:"+String:C10([Invoices:5]toAmount:26)+[Invoices:5]toCurrency:8
					myAlert($tResult)
					Sync_Log(Current method name:C684; $tResult)
					
					
				: ($iCurrTransLevel>$iStartLevel)
					//validate until we match the level we started at
					For ($i; 1; $iCurrTransLevel-$iStartLevel+1)
						If (OK=1)
							VALIDATE TRANSACTION:C240
						Else 
							CANCEL TRANSACTION:C241
						End if 
						TM_RemoveFromStack  //8/31/16
					End for 
					
					//UNLOAD RECORD($tablePtr->)
					
					$tResult:="Transaction Validation Debug: Current="+String:C10($iCurrTransLevel)+" Starting="+String:C10($iStartLevel)+" Final level: "+String:C10(Transaction level:C961)+" OK Var: "+String:C10(OK)
					$tResult:=$tResult+"---"+Table name:C256($tablePtr)+" force validated: [2] invoice: "+[Invoices:5]InvoiceID:1+" "+[Invoices:5]CustomerFullName:54+" - "+[Invoices:5]comments:43+" From:"+String:C10([Invoices:5]fromAmount:25)+[Invoices:5]fromCurrency:3+" To:"+String:C10([Invoices:5]toAmount:26)+[Invoices:5]toCurrency:8
					
					myAlert($tResult)
					Sync_Log(Current method name:C684; $tResult)
					
					
				: ($iCurrTransLevel<$iStartLevel)
					//don't need to validate b/c another process should be finishing
					
					$tResult:="**[3]Transaction Validation Debug: Current="+String:C10($iCurrTransLevel)+" Starting="+String:C10($iStartLevel)+" Final level: "+String:C10(Transaction level:C961)+" OK Var: "+String:C10(OK)
					$tResult:=$tResult+"---"+Table name:C256($tablePtr)+" saved no validation: [3] invoice: "+[Invoices:5]InvoiceID:1+" "+[Invoices:5]CustomerFullName:54+" - "+[Invoices:5]comments:43+" From:"+String:C10([Invoices:5]fromAmount:25)+[Invoices:5]fromCurrency:3+" To:"+String:C10([Invoices:5]toAmount:26)+[Invoices:5]toCurrency:8
					
					myAlert($tResult)
					Sync_Log(Current method name:C684; $tResult)
					
					
				: (OK=1)  //trans level is correct and user saved
					VALIDATE TRANSACTION:C240
					
					TM_RemoveFromStack  //8/31/16
					
					$tResult:="Transaction Validation Debug: Current level="+String:C10($iCurrTransLevel)+" Starting level="+String:C10($iStartLevel)+" Final level: "+String:C10(Transaction level:C961)+" OK Var: "+String:C10(OK)
					$tResult:=$tResult+"---"+Table name:C256($tablePtr)+" validated: [4] invoice:"+[Invoices:5]InvoiceID:1+" "+[Invoices:5]CustomerFullName:54+"-"+[Invoices:5]comments:43+" From:"+String:C10([Invoices:5]fromAmount:25)+[Invoices:5]fromCurrency:3+" To:"+String:C10([Invoices:5]toAmount:26)+[Invoices:5]toCurrency:8
					
					
					If ($tablePtr=(->[Invoices:5]))  //8/24/16
						While (Transaction level:C961>0)
							
							$tResult:="**"+$tResult+" ** PARENT=["+TM_GetCurrMessage+"]"
							
							VALIDATE TRANSACTION:C240
							TM_RemoveFromStack  //8/31/16
							$tResult:="**"+$tResult
						End while 
					End if 
					
					Sync_Log(Current method name:C684; $tResult)
					
					//UNLOAD RECORD($tablePtr->)
				Else 
					BEEP:C151
					CANCEL TRANSACTION:C241  // Modified by: Tiran Behrouz (2012-11-04)
					
					TM_RemoveFromStack  //8/31/16
					
					$tResult:="Transaction Validation Debug: Current level="+String:C10($iCurrTransLevel)+" Starting level="+String:C10($iStartLevel)+" Final level: "+String:C10(Transaction level:C961)+" OK Var: "+String:C10(OK)
					$tResult:=$tResult+" ---- "+Table name:C256($tablePtr)+" cancelled: [5] invoice: "+[Invoices:5]InvoiceID:1+" "+[Invoices:5]CustomerFullName:54+" - "+[Invoices:5]comments:43+" From:"+String:C10([Invoices:5]fromAmount:25)+[Invoices:5]fromCurrency:3+" To:"+String:C10([Invoices:5]toAmount:26)+[Invoices:5]toCurrency:8
					Sync_Log(Current method name:C684; $tResult)
					
					OK:=0  //reset -- 9/6/16 sync_log is setting the OK var to 1 so we need to reset it here
			End case 
			
			CLOSE WINDOW:C154($winRef)
			
		Else 
			myAlert("You are not authorized to add any entries to this table.")
			$repeat:=False:C215
		End if 
	Else 
		myAlert(Table name:C256($tablePtr)+" has reached its maximum allowed records.")
		$repeat:=False:C215
	End if 
Until ((OK=0) | Not:C34($repeat))

//UTIL_unloadAllRecords ($tablePtr)

UNLOAD RECORD:C212($tablePtr->)
READ ONLY:C145($tablePtr->)  // release the lock
LOAD RECORD:C52($tablePtr->)