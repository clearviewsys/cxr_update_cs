//%attributes = {"shared":true}
//
//  // ----------------------------------------------------
//  // User name (OS): Barclay Berry
//  // Date and time: 04/24/18, 21:36:17
//  // ----------------------------------------------------
//  // Method: webCreateBookings
//  // Description
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------
//
//
//C_POINTER($1;$ptrNameArray)
//C_POINTER($2;$ptrValueArray)
//C_LONGINT($0)
//
//
//[Bookings]BookingDate:=Current date
//[Bookings]BookedByUser:="web"
//[Bookings]CustomerID:=[Customers]CustomerID  //need to use web session to get customera id
//
//SAVE RECORD([Bookings])
//
//  //create email confirmation
//
//UNLOAD RECORD([Bookings])
//REDUCE SELECTION([Bookings];0)
//
//webErrorMessage:="Your booking has been submitted. Please check your email for confirmation."
//webMessageType:=1  //success
//webMessage (webErrorMessage;webMessageType)
//webSendWelcomePage 
//
//$0:=0