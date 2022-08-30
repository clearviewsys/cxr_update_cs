//%attributes = {}
C_TEXT:C284(vBookingID)

If (True:C214)
	vBookingID:=pickBookingForInvoice
Else 
	pickBOOKINGS(->vBookingID; True:C214)
End if 

If (OK=1)
	setInvoiceVarsByBoookingID(vBookingID)
End if 