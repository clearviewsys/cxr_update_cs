//note: the widget is designed to work on page 0 or 1 only

//you should activate the following object events
//On Data Change

//you can handle the following custom events
//-On Clicked
//-On Load

C_LONGINT:C283($event)
$event:=SIGPAD_FORM_EVENT(OBJECT Get name:C1087(Object current:K67:2))

Case of 
		
	: ($event=On Data Change:K2:15)
		
		//this event is invoked after every stroke
		//the picture variable (Self) contains the signature image (SVG)
		//you can convert it to text or BLOB, as you like
		
	: ($event=-On Clicked:K2:4)
		// Ignore
		
	: ($event=-On Load:K2:1)
		
		handleSignatureEntryForm
		
		
End case 