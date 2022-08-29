
pickAccountsOfCurrency(->[eWires:13]AccountID:30; [eWires:13]Currency:12; "Pick a Sub-ledger Account for sending eWire")
C_POINTER:C301($subAccountPtr)
$subAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "SubAccountID")
handleDropDown_SubAccount($subAccountPtr; ->[eWires:13]SubAccountID:118; [eWires:13]AccountID:30; True:C214)
[eWires:13]toCountryCode:112:=[Accounts:9]CountryCode:39
[eWires:13]toCountry:10:=getCountryNameByCode([Accounts:9]CountryCode:39)
[eWires:13]AgentID:26:=[Accounts:9]AgentID:16
selectLinksByCustIDnCountry