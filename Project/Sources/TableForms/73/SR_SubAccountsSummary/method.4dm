//author: Amir
//date: 5th September 2018
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284(vBranchId)
C_LONGINT:C283($formEvent)
C_TEXT:C284($formTitle)
$formTitle:="Accounts and Sub-Accounts summary"
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		OBJECT SET TITLE:C194(*; "ReportTitle"; $formTitle)
	: ($formEvent=On Outside Call:K2:11)
		$formTitle:=$formTitle+" - "+String:C10(vFromDate)+" to "+String:C10(vToDate)
		OBJECT SET TITLE:C194(*; "ReportTitle"; $formTitle)
		C_POINTER:C301($showAllAccountsPtr)
		$showAllAccountsPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "showAllAccountsChkBox")
		If ($showAllAccountsPtr->=0)  // active accounts only
			//no need to consider branch in the Query here. calcAccntAndSubAccntSummary() considers branch
			QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=vFromDate; *)
			QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=vToDate)
			RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  // map registers to accounts (active ones)
		Else   //show all accounts regardless of registers in the date range 
			ALL RECORDS:C47([Accounts:9])
		End if 
		calcAccntAndSubAccntSummary
End case 
