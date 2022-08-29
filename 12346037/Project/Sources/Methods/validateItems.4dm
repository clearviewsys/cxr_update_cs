//%attributes = {}
// validateItems

checkUniqueKey(->[Items:39]; ->[Items:39]ItemID:1; "Internal Product ID")
checkIfNullString(->[Items:39]AccountID:12; "Account ID")
checkIfAccountIDExists(->[Items:39]AccountID:12)
checkIfNullString(->[Items:39]ItemName:2; "Product (Item) Name")
If ([Items:39]isBarCoded:23)
	checkIfNullString(->[Items:39]ItemCode:27; "Product Code (SKU)")
End if 
checkIfPictureSizeIsLT(->[Items:39]Picture:4; 300; True:C214; "Picture")  // Picture field

//checkGreaterThan (->[Items]BuyUnitPrice;"Buy Price";)
checkGreaterThan(->[Items:39]SellUnitPrice:7; "Sell Price"; 0)
