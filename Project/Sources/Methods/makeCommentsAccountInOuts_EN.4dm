//%attributes = {}
// makeCommentsAccountsInOut 

C_TEXT:C284(AccountsInOutComments; $0)
AccountsInOutComments:=String:C10([AccountInOuts:37]Amount:7; "|Currency")+" "+[AccountInOuts:37]Currency:8  // Ex: Amount 1000 USD...
//

Case of 
	: ([AccountInOuts:37]isPaid:9=True:C214)  // payment is paid to customer
		appendLabelString(->AccountsInOutComments; " paid from "; [AccountInOuts:37]AccountID:6+". ")
		
	: ([AccountInOuts:37]isPaid:9=False:C215)  // payment is received 
		appendLabelString(->AccountsInOutComments; " received in "; [AccountInOuts:37]AccountID:6+". ")
		//appendLabelString (->AccountsInOutComments;" has been credited to (received by) account ";[AccountInOuts]AccountID+".")
End case 
appendLabelString(->AccountsInOutComments; "Ref.#: "; [AccountInOuts:37]ReferenceNo:22)
appendLabelString(->AccountsInOutComments; "Notes: "; [AccountInOuts:37]Memo:10)

$0:=AccountsInOutComments
CLEAR VARIABLE:C89(AccountsInOutComments)
