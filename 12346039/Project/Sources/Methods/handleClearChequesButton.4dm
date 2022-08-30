//%attributes = {}
//handle batch clearing of cheques
C_BOOLEAN:C305($confirm)
C_TEXT:C284($selectionSet; $1)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=1)
		$selectionSet:=$1
	Else 
		$selectionSet:="UserSet"
End case 


CREATE SET:C116([Cheques:1]; "$originalSet")
CREATE EMPTY SET:C140([Cheques:1]; "$manualUpdate")

USE SET:C118($selectionSet)
COPY SET:C600($selectionSet; "$tempSet")

If (Records in selection:C76([Cheques:1])>0)
	QUERY SELECTION:C341([Cheques:1]; [Cheques:1]chequeStatus:14#1)  // select non-cleared cheques (ie. pending or bounced)  
	If (Records in selection:C76([Cheques:1])=0)
		myAlert("All cheques were already cleared.")
	Else 
		CONFIRM:C162("Do you want confirmation for each cheques cleared?"; "Yes"; "No")
		If (Ok=1)
			$confirm:=True:C214
		Else 
			$confirm:=False:C215
		End if 
		
		
		FIRST RECORD:C50([Cheques:1])
		For ($i; 1; Records in selection:C76([Cheques:1]))
			// Select the bank account for that currency
			QUERY:C277([Accounts:9]; [Accounts:9]Currency:6=[Cheques:1]Currency:9; *)
			QUERY:C277([Accounts:9];  & ; [Accounts:9]isBankAccount:7=True:C214)
			If (handleAutoClearoutCheque)
				If ($confirm)
					myAlert("Cheque "+[Cheques:1]ChequeID:1+" has been cleared.")
				End if 
			Else   // there's either no bank or more banks to deposit the cheque into
				If ([Cheques:1]DueDate:3<=Current date:C33)
					//MODIFY RECORD([Cheques])
					ADD TO SET:C119([Cheques:1]; "$manualUpdate")
				Else 
					myAlert("Cheque "+[Cheques:1]ChequeID:1+"could not be cleared because it is postdated for "+String:C10([Cheques:1]DueDate:3))
				End if 
			End if 
			NEXT RECORD:C51([Cheques:1])
		End for 
		
		
	End if 
	
	UNLOAD RECORD:C212([Cheques:1])
	READ ONLY:C145([Cheques:1])
Else 
	myAlert("Please highlight some records first.")
End if 

// manual clearing of cheques
If (Records in set:C195("$manualUpdate")>0)
	myAlert("Some cheques need to be cleared manually, probably there's more than one bank acc"+"ount to clear them.")
	USE SET:C118("$manualUpdate")
	HIGHLIGHT RECORDS:C656("$manualUpdate")
Else 
	USE SET:C118("$originalSet")
	HIGHLIGHT RECORDS:C656("$tempSet")
End if 


CLEAR SET:C117("$tempSet")
CLEAR SET:C117("$originalSet")
CLEAR SET:C117("$manualUpdate")