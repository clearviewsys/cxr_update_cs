C_POINTER:C301($marketingNotificationPopup)

$marketingNotificationPopup:=OBJECT Get pointer:C1124(Object named:K67:5; "marketingNotification")

Form:C1466.object.marketingNotification:=Form:C1466.marketing.query("popupItemText = :1"; $marketingNotificationPopup->{$marketingNotificationPopup->})[0].popupValue
