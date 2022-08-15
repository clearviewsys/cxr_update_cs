//%attributes = {}
C_LONGINT:C283($found)

SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
QUERY:C277([TellerProof:78]; [TellerProof:78]Date:10=Current date:C33; *)  // today
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]BranchID:13=getBranchID; *)  // same branch
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]Currency:4=vCurrency; *)  // same currency
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]CashAccountID:3=vCashAccount; *)  // same account
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]Teller:2=getApplicationUser; *)  // same user
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]isEODBalance:5=True:C214)  // EOD

checkAddErrorIf($found>0; "You already did the tellerproof for this currency today.")

SET QUERY DESTINATION:C396(Into current selection:K19:1)
