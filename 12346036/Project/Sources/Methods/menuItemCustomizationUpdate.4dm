//%attributes = {}
// menuItemCustomizationUpdate

C_TEXT:C284(tMenuBarRef)
ARRAY TEXT:C222(arrMenuTitles; 0)
ARRAY TEXT:C222(arrMenuRefs; 0)
C_LONGINT:C283($iReportMenu)

tMenuBarRef:=Get menu bar reference:C979(Current process:C322)
GET MENU ITEMS:C977(tMenuBarRef; arrMenuTitles; arrMenuRefs)

If (getKeyValue("customization.Sharhan"; "true")="true")
	$iReportMenu:=Find in array:C230(arrMenuTitles; "Reports")  // find the report menu
	
	If ($iReportMenu>0)  // if the report menu, exists, add new item
		APPEND MENU ITEM:C411(arrMenuRefs{$iReportMenu}; "Transaction Summary")
		SET MENU ITEM METHOD:C982($iReportMenu; -1; "display_SR_TransactionSummary")
		
		APPEND MENU ITEM:C411(arrMenuRefs{$iReportMenu}; "Top 100 Customers")
		SET MENU ITEM METHOD:C982($iReportMenu; -1; "display_SR_CustomerTop100")
	End if 
	
End if 
