//%attributes = {}
declareAuditFormVariables

cbIncludeDebit:=1
cbIncludeCredit:=1
cbIncludeCash:=0
cbIncludeWires:=0
cbIncludeEwires:=0
cbIncludeAccounts:=0
cbIncludeCheques:=0
cbIncludeItems:=0

vAccountID:=""
vCurrency:=""
vCustomerID:=""
vBranchID:=""
vRiskRating:=0
cbSuspicious:=0
cbPEP:=0

UNLOAD RECORD:C212([Accounts:9])
UNLOAD RECORD:C212([Customers:3])

