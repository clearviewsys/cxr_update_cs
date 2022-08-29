//%attributes = {}
// makeCommentsAccountsInOut 

C_TEXT:C284(AccountsInOutComments; $0)
AccountsInOutComments:="Montant  de "+String:C10([AccountInOuts:37]Amount:7; "|Currency")+" "+[AccountInOuts:37]Currency:8  // Ex: Amount 1000 USD...
//

Case of 
	: ([AccountInOuts:37]isPaid:9=True:C214)  // payment is paid to customer
		appendLabelString(->AccountsInOutComments; " est payé par "; [AccountInOuts:37]AccountID:6+". ")
		
	: ([AccountInOuts:37]isPaid:9=False:C215)  // payment is received 
		appendLabelString(->AccountsInOutComments; " est reçu dans le compte "; [AccountInOuts:37]AccountID:6+". ")
End case 
appendLabelString(->AccountsInOutComments; "Reference: "; [AccountInOuts:37]ReferenceNo:22)
appendLabelString(->AccountsInOutComments; "Remarque: "; [AccountInOuts:37]Memo:10)

$0:=AccountsInOutComments
CLEAR VARIABLE:C89(AccountsInOutComments)

