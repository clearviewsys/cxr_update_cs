//%attributes = {}
// getItemInOutSums (itemId;->openingPtr;->qtyIn;->qtyOut;->inventory;->volumeIn;->volumeOut;fromDate;toDate;applyDateRange)
C_TEXT:C284($1; $itemID)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $openingPtr; $qtyInPtr; $qtyOutPtr; $inventoryPtr; $volumeInPtr; $volumeOutPtr)
C_DATE:C307($8; $9; $fromDate; $toDate)
C_BOOLEAN:C305($10; $applyDateRange)
C_REAL:C285($opening; $qtyIn; $qtyOut; $inventory; $volumeIn; $volumeOut)
C_REAL:C285($volumeIn; $volumeOut)

$itemID:=$1
$openingPtr:=$2
$qtyInPtr:=$3
$qtyOutPtr:=$4
$inventoryPtr:=$5
$volumeInPtr:=$6
$volumeOutPtr:=$7
$fromDate:=$8
$toDate:=$9
$applyDateRange:=$10


If ($applyDateRange)
	QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemID:2=$itemID; *)
	QUERY:C277([ItemInOuts:40];  & ; [ItemInOuts:40]Date:3<$fromDate)
	$opening:=Sum:C1([ItemInOuts:40]Qty:8)-(2*Sum:C1([ItemInOuts:40]QtySold:23))
	
	QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemID:2=$itemID)
	QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]Date:3>=$fromDate; *)
	QUERY SELECTION:C341([ItemInOuts:40]; [ItemInOuts:40]Date:3<=$toDate)
Else 
	QUERY:C277([ItemInOuts:40]; [ItemInOuts:40]ItemID:2=$itemID)
	$opening:=0
End if 

If ((Records in selection:C76([ItemInOuts:40])>0) & ([Items:39]ItemID:1#""))  // This extra condition is checked to make sure the relate one is active and we're not calculating values for null item
	$qtyOut:=Sum:C1([ItemInOuts:40]QtySold:23)
	$qtyIn:=Sum:C1([ItemInOuts:40]Qty:8)-$qtyOut
	$inventory:=$qtyIn-$qtyOut
	
	$volumeOut:=Sum:C1([ItemInOuts:40]AmountSold:24)
	$volumeIn:=Sum:C1([ItemInOuts:40]Amount:22)-$volumeOut
Else 
	$qtyOut:=0
	$qtyIn:=0
	$inventory:=0
	$volumeOut:=0
	$volumeIn:=0
End if 

$openingPtr->:=$opening
$qtyInPtr->:=$qtyIn
$qtyOutPtr->:=$qtyOut
$inventoryPtr->:=$Inventory+$opening
$volumeInPtr->:=$volumeIn
$volumeOutPtr->:=$volumeOut



