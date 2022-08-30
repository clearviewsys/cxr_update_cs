//%attributes = {}
C_LONGINT:C283($winRef)

$winRef:=Open form window:C675("DateCalendarDialog"; Pop up form window:K39:11; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("DateCalendarDialog")
CLOSE WINDOW:C154($winRef)
ALERT:C41(String:C10(datePicked))