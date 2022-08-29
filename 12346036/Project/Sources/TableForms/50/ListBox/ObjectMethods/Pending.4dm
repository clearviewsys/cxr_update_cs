
//QUERY([Bookings];([Bookings]isConfirmed=False & [Bookings]isCancelled=False & [Bookings]isHonored=False)
QUERY BY SQL:C942([Bookings:50]; "bookings.isConfirmed=False AND bookings.isCancelled=False AND bookings.isHonored=False")
orderByBOOKINGS