//%attributes = {"shared":true}
// rep_printAgentPO_Out
//PRE: the records must be selected already in eWire or else nothing will be printed out 

C_TEXT:C284($formName)
$formName:="rep_PaymentOrderOutgoing"
C_REAL:C285(vOrderSums)
C_LONGINT:C283(vNumberOfOrders)
C_TEXT:C284(vAmountInString)
C_TEXT:C284(vRowNo)
C_DATE:C307(vPODate)
C_TEXT:C284(vPOReference)
C_LONGINT:C283($n; $i)
If (isUserAllowedToPrintReports)
	$n:=Records in selection:C76([eWires:13])
	If ($n>0)
		printSettings
		If (OK=1)
			vRowNo:=""
			vOrderSums:=0
			vNumberOfOrders:=0
			vPODate:=Current date:C33
			vPOReference:=<>branchID+"-"+String:C10(convDate2Serial(Current date:C33))+String:C10(getTableNextSerialNo(->[AgentPOs:71]))
			// print header ________________________________________
			
			Print form:C5([eWires:13]; $formName; Form header:K43:3)  // Use footer for the sum
			//print body ________________________________________
			FIRST RECORD:C50([eWires:13])
			
			For ($i; 1; $n)
				vRowNo:=String:C10($i)+"/"+String:C10($n)
				LOAD RECORD:C52([eWires:13])
				RELATE ONE:C42([eWires:13]LinkID:8)  // load the link
				vAmountInString:=NumToText([eWires:13]ToAmount:14)
				Print form:C5([eWires:13]; $formName; Form detail:K43:1)  // Use footer for the sum
				vOrderSums:=vOrderSums+[eWires:13]ToAmount:14
				NEXT RECORD:C51([eWires:13])
			End for 
			
			vNumberOfOrders:=$n
			Print form:C5([eWires:13]; $formName; Form footer:K43:2)  // Use footer for the sum
			PAGE BREAK:C6
			
			// print footer ________________________________________
			
			// stamp the ewires as printed
			CONFIRM:C162("Please wait for all pages to print. Did all the pages print correctly?"; "Yes"; "No")
			If (OK=1)
				// this where we need to stamp all the records
				READ WRITE:C146([eWires:13])
				APPLY TO SELECTION:C70([eWires:13]; [eWires:13]includedInAgentPO:49:=vPOReference)
				READ ONLY:C145([eWires:13])
				
			End if 
			
			CLOSE WINDOW:C154
			
		End if 
	Else 
		myAlert("There are no records to print. ")
	End if 
	
	
Else 
	myAlert("Sorry, please ask the admiistratorn to give you permission to print this report.")
End if 