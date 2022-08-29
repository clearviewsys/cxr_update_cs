//%attributes = {}
ARRAY TEXT:C222($menuTitlesArray; 0)
ARRAY TEXT:C222($menuRefsArray; 0)
C_TEXT:C284($MenuBarRef)
$MenuBarRef:=Get menu bar reference:C979(Current process:C322)
GET MENU ITEMS:C977($MenuBarRef; $menuTitlesArray; $menuRefsArray)

