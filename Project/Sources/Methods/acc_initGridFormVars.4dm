//%attributes = {}
// Initializes all form variables for filtering the accounts & register table
// this is called from [Accounts];"Grid" form method

Form:C1466.customerFullName:=""
Form:C1466.liveCalculations:=0  // live vs. cached

Form:C1466.filterBank:=0
Form:C1466.filterChequing:=0
Form:C1466.filterCash:=0
Form:C1466.filterEFT:=0
Form:C1466.filterPending:=0
Form:C1466.filterSettlement:=0
Form:C1466.filterTrade:=0
Form:C1466.filterForeignAccount:=0
Form:C1466.filterInternational:=0
Form:C1466.filterAgent:=0

Form:C1466.filterCCY:=""
Form:C1466.filterTill:=""
Form:C1466.filterAccountType:=""
Form:C1466.filterMainAccountID:=""
Form:C1466.filterAgentID:=""

// the following filters are for Registers
Form:C1466.fromDate:=Current date:C33
Form:C1466.toDate:=Current date:C33
Form:C1466.applyDateRange:=0

Form:C1466.filter:=New object:C1471  // this is for register filtering
Form:C1466.filter.userID:=""
Form:C1466.filter.subAccountID:=""
Form:C1466.filter.branchID:=""
Form:C1466.filter.customerID:=""