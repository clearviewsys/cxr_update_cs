//%attributes = {}
C_POINTER:C301($marketingNotificationPopup)
C_COLLECTION:C1488($1; $col)

$col:=$1

$marketingNotificationPopup:=OBJECT Get pointer:C1124(Object named:K67:5; "marketingNotification")

ARRAY TEXT:C222($marketingNotificationPopup->; 0)

COLLECTION TO ARRAY:C1562($col; $marketingNotificationPopup->; "popupItemText")

$marketingNotificationPopup->:=1
