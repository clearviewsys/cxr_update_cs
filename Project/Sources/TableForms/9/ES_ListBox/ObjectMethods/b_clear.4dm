Form:C1466.searchString:=""
Form:C1466.filterPending:=0
Form:C1466.filterSettlement:=0
Form:C1466.filterForeignAccount:=0
Form:C1466.filterAgent:=0

Form:C1466.filterCash:=0
Form:C1466.filterBank:=0
Form:C1466.filterEFT:=0
Form:C1466.filterTrade:=0

Form:C1466.applyDates:=0

C_POINTER:C301($mainAccountPtr; $accountTypePtr; $agentPtr; $tillPtr; $ccyPtr; $branchPtr)

$mainAccountPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_mainAccountID")
$accountTypePtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_accountType")
$agentPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_Agent")
$tillPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_Till")
$ccyPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_CCY")
$branchPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "dd_branch")

$mainAccountPtr->:=1
$accountTypePtr->:=1
$agentPtr->:=1
$tillPtr->:=1
$ccyPtr->:=1
$branchPtr->:=1

SET TIMER:C645(1)
