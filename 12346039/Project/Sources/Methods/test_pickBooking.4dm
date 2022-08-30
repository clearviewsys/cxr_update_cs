//%attributes = {}
C_TEXT:C284($picked)
C_LONGINT:C283($i)

For ($i; 1; 2)
	pickBOOKINGS(->$picked; True:C214)
	myAlert([Bookings:50]BookingID:1+" "+[Bookings:50]autoComments:24)
End for 