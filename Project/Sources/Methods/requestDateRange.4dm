//%attributes = {}
// requestDateRange (->fromDate; ->toDate) 

var $fromDatePtr; $toDatePtr : Pointer
C_DATE:C307(vFromDate; vToDate)
C_LONGINT:C283($winRef)

Case of 
		
	: (Count parameters:C259=0)
		
	: (Count parameters:C259=2)
		
	Else 
		
End case 


$winRef:=Open form window:C675("dateRange"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("dateRange")

BRING TO FRONT:C326($winRef)

// getBuild