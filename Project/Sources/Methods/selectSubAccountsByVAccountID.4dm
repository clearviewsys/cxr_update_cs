//%attributes = {}
// selectSubAccountsByVAccountID
// this method is meant to be called form a picker module. The global variable needs to be passed

C_TEXT:C284(vAccountID_pick)
QUERY:C277([SubAccounts:112]; [SubAccounts:112]AccountID:4=""; *)  // search the subaccounts that are generic
QUERY:C277([SubAccounts:112];  | ; [SubAccounts:112]AccountID:4=vAccountID_pick)