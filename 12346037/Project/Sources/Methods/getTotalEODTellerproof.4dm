//%attributes = {}

C_LONGINT:C283($n; $0)
C_REAL:C285($ratio)

SET QUERY DESTINATION:C396(Into variable:K19:4; $n)

// search all tellerproof record that are matching the user
// and a particular cash account

QUERY:C277([TellerProof:78]; [TellerProof:78]Teller:2=getApplicationUser; *)  // current user
QUERY:C277([TellerProof:78]; [TellerProof:78]BranchID:13=getBranchID; *)  // current branch
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]Date:10=Current date:C33; *)  // today
QUERY:C277([TellerProof:78];  & ; [TellerProof:78]isEODBalance:5=True:C214)  // EOD

SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=$n