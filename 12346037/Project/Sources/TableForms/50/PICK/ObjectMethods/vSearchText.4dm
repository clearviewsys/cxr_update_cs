C_TEXT:C284(vSearchText; vCustomerID)
handlePICKSearchVariable(->vSearchText; ->[Bookings:50]; ->[Bookings:50]BookingID:1; ->[Bookings:50]CustomerID:2; ->[Bookings:50]Amount:9; ->[Bookings:50]Currency:10; ->[Bookings:50]customerRemarks:14)

QUERY SELECTION:C341([Bookings:50]; [Bookings:50]CustomerID:2=vCustomerID)  // look for a customer
QUERY SELECTION:C341([Bookings:50]; [Bookings:50]isHonored:18=False:C215)  // look for pending only
