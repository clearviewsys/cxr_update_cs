//%attributes = {}
// itm_fillitemsListBoxRow (row)
C_LONGINT:C283($i; $1)
$i:=$1

If (False:C215)  // for compiler's sake
	ARRAY TEXT:C222(arrItemIDs; 0)
	ARRAY TEXT:C222(arrItemNames; 0)
	ARRAY TEXT:C222(arrItemCategories; 0)
	ARRAY TEXT:C222(arrItemCodes; 0)
End if 

//RELATE ONE([Items]ItemCategory)
//RELATE ONE([items]Currency)

getItemsBalanceInDateRange([Items:39]ItemID:1; vFromDate; vToDate; numToBoolean(cbApplyDateRange); ->arrOpenings{$i}; ->arrIns{$i}; ->arrOuts{$i}; ->arrBalances{$i}; ->arrDebits{$i}; ->arrCredits{$i})


arritemIDs{$i}:=[Items:39]ItemID:1
arritemNames{$i}:=[Items:39]ItemName:2
arrItemCategories{$i}:=[Items:39]Category:3
arrItemCodes{$i}:=[Items:39]ItemCode:27
itm_RecalcItemsListBoxRow($i)