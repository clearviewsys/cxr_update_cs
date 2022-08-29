//%attributes = {}
PrependBranchPrefixTo(->[Bookings:50]BookingID:1; ->[Bookings:50]BranchID:25)
PrependBranchPrefixTo(->[Bookings:50]invoiceID:19)

If (isCustomerNotSelfNOrWalkin([Bookings:50]CustomerID:2))
	PrependBranchPrefixTo(->[Bookings:50]CustomerID:2)
End if 

