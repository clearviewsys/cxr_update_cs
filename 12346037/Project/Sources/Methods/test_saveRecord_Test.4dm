//%attributes = {}
C_TEXT:C284($bookingID)

READ WRITE:C146([Bookings:50])  // make the table writable 
// what if the bookings table is locked? 
CREATE RECORD:C68([Bookings:50])  // create an empty record
[Bookings:50]Amount:9:=1000
SAVE RECORD:C53([Bookings:50])  // save the last record 
$bookingID:=[Bookings:50]BookingID:1
myAlert($bookingID+"-"+[Bookings:50]BookingID:1)

UNLOAD RECORD:C212([Bookings:50])  // release the record from memory
myAlert($bookingID+"-"+[Bookings:50]BookingID:1)

READ ONLY:C145([Bookings:50])  // lock the table
QUERY:C277([Bookings:50]; [Bookings:50]BookingID:1=$bookingID)  // the last added record

READ WRITE:C146([Bookings:50])  // allow modifications to table
DELETE SELECTION:C66([Bookings:50])
READ ONLY:C145([Bookings:50])

