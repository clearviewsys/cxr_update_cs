//%attributes = {}
// isAccountTypeDebit (string: accountType) ->boolean

// returns true if the account is generally a debit account


C_TEXT:C284($1)
C_BOOLEAN:C305($0)


C_LONGINT:C283($accountTypeNo)
$accountTypeNo:=getAccountTypeNumber($1)

Case of 
	: ($accountTypeNo=1)  // assets
		
		$0:=True:C214
	: ($accountTypeNo=2)  // liabilities
		
		$0:=False:C215
	: ($accountTypeNo=3)  //equities 
		
		$0:=False:C215
	: ($accountTypeNo=4)  // revenues (eg : cash (debit:1000) / sales (credit:1000)
		
		$0:=False:C215
	: ($accountTypeNo=5)  // expenses (eg: cash (credit 400) / expenses (debit:400)
		
		$0:=True:C214
End case 