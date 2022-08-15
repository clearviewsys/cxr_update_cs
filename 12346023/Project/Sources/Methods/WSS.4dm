//%attributes = {}

//menu bars can only be shared if created by code with components
//so "copy" the design created menu and create a reference that can be used 
//by the component
C_LONGINT:C283($iProcess)
C_TEXT:C284($CurrMenuRef; $MenuRefNew)
$iProcess:=Process number:C372("LaunchBrowser_MForms")

ARRAY TEXT:C222(menuTitlesArray; 0)
ARRAY TEXT:C222(menuRefsArray; 0)

$CurrMenuRef:=Get menu bar reference:C979($iProcess)
//GET MENU ITEMS(MenuBarRef;menuTitlesArray;menuRefsArray)

//loop thru titlearray and build each one


$MenuRefNew:=Create menu:C408($CurrMenuRef)
//SET MENU ITEM($MenuRefNew;1;"TEST")

//GET MENU ITEMS($MenuRefNew;menuTitlesArray;menuRefsArray)

//GET MENU ITEMS(menuRefsArray{1};$atTitles;$atRefs)

//RELEASE MENU($MenuRefNew)