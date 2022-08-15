//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/07/13, 23:04:20
// ----------------------------------------------------
// Method: rep_buildMenu
// Description
// 
//
// Parameters
// ----------------------------------------------------



ARRAY LONGINT:C221($aiTables; 0)



ARRAY TEXT:C222($menuTitlesArray; 0)
ARRAY TEXT:C222($menuRefsArray; 0)
C_TEXT:C284($MenuBarRef; $RptMenu; $sMenuRef)
C_LONGINT:C283($iElem; $i; $j)

SET MENU BAR:C67(1)
$MenuBarRef:=Get menu bar reference:C979  //(Frontmost process)
GET MENU ITEMS:C977($MenuBarRef; $menuTitlesArray; $menuRefsArray)

$iElem:=Find in array:C230($menuTitlesArray; "Reports")  //find the report menu

If ($iElem>0)  //now find contents of reports menu
	$RptMenu:=$menuRefsArray{$iElem}
	
	GET MENU ITEMS:C977($menuRefsArray{$iElem}; $menuTitlesArray; $menuRefsArray)
	
	ALL RECORDS:C47([Reports:73])
	
	DISTINCT VALUES:C339([Reports:73]TableNo:8; $aiTables)
	
	//_O_ARRAY STRING(30;$asTables;0)
	ARRAY TEXT:C222($asTables; 0)
	For ($i; 1; Size of array:C274($aiTables))
		//create a submenu for each table and append to Reports menu
		//submenu will have the name of each report in the [Reports] table
		If ($aiTables{$i}>0)  //valid table num
			APPEND TO ARRAY:C911($asTables; Table name:C256($aiTables{$i}))
		End if 
	End for 
	
	SORT ARRAY:C229($asTables; $aiTables)
	
	If (Size of array:C274($asTables)>0)
		APPEND MENU ITEM:C411($RptMenu; "-")
		
		For ($i; 1; Size of array:C274($asTables))
			
			QUERY:C277([Reports:73]; [Reports:73]TableNo:8=$aiTables{$i})
			
			If (Records in selection:C76([Reports:73])>0)
				ORDER BY:C49([Reports:73]; [Reports:73]Name:2; >)
				
				FIRST RECORD:C50([Reports:73])
				$sMenuRef:=Create menu:C408
				
				For ($j; 1; Records in selection:C76([Reports:73]))
					APPEND MENU ITEM:C411($sMenuRef; [Reports:73]Name:2)
					SET MENU ITEM PROPERTY:C973($sMenuRef; -1; "Report_ID"; [Reports:73]ID:1)
					SET MENU ITEM METHOD:C982($sMenuRef; -1; "rep_ExecuteRpt")
					NEXT RECORD:C51([Reports:73])
				End for 
				
				If (Records in selection:C76([Reports:73])>0)
					APPEND MENU ITEM:C411($RptMenu; $asTables{$i}; $sMenuRef)
				End if 
				
				RELEASE MENU:C978($sMenuRef)
			End if 
			
		End for 
		
	End if 
	
	SET MENU BAR:C67($MenuBarRef)
	
End if 