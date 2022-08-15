
//QUERY([Bookings];([Bookings]isConfirmed=True & [Bookings]isHonored=False))
QUERY BY SQL:C942([Bookings:50]; "bookings.isConfirmed=True AND bookings.isHonored=False")
orderByBOOKINGS