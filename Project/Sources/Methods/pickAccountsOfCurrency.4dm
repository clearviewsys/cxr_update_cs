//%attributes = {}
// pickAccountsOfCurrency (object;Currency;{request string})
C_POINTER:C301($1)
C_TEXT:C284($2; vAccountCurrency; $3)
C_BOOLEAN:C305($doSearch)

vAccountCurrency:=$2

//Case of 
//: (Count parameters=3)
//setRequestString ($3)
//End case 


// Modified by: Barclay (3/5/2012)

Case of   // 4/30/22 ibb added case for doSearch so as to not badger the query engine
	: (Form event code:C388=On Data Change:K2:15)
		$doSearch:=True:C214
	: ($1->="")
		$doSearch:=True:C214
	Else 
		$doSearch:=False:C215
End case 

If ($doSearch)
	If (Count parameters:C259>=3)
		setRequestString($3)
		pickAccounts($1; "selectAccountsByCurrency"; $3)
	Else 
		pickAccounts($1; "selectAccountsByCurrency")
	End if 
End if 




