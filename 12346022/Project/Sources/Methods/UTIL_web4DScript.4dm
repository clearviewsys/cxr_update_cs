//%attributes = {"publishedWeb":true}
// UTIL_web4DScript ($1 string parameter from web) :  $0 return string
//TRACE
C_TEXT:C284($1; $webParameter; $0; $webReturnValue)

$webParameter:=Replace string:C233($1; "/"; "")

Case of 
	: ($webParameter="BookingPercent@") | ($webParameter="BookingHeader@")
		C_TEXT:C284(headerText; percentage)
		Case of 
			: ([Bookings:50]isConfirmed:15=False:C215) & ([Bookings:50]isHonored:18=False:C215)
				headerText:="We have received your booking request for the following. Please review:"
				percentage:="25"
			: ([Bookings:50]isHonored:18=False:C215) & ([Bookings:50]isConfirmed:15=True:C214)
				headerText:="You're booking request has been confirmed."
				percentage:="65"
			: ([Bookings:50]isHonored:18=True:C214)
				headerText:="You're booking request has been honored."
				percentage:="100"
		End case 
		
		Case of 
			: ($webParameter="BookingPercent@")
				$webReturnValue:=percentage
			: ($webParameter="BookingHeader@")
				$webReturnValue:=headerText
		End case 
		
	: ($webParameter="Greetings")
		C_TEXT:C284($greetings)
		$greetings:=getKeyValue("email.greetings.birthday"; "Happy Birthday "+[Customers:3]FirstName:3+"!")
		replaceXYZTags(->$greetings; [Customers:3]FirstName:3; [Customers:3]LastName:4)
		$webReturnValue:=$greetings
		// Happy birthday <X> from Lotus
		
	: ($webParameter="GreetingsFilePath")
		C_OBJECT:C1216(filePath)
		filePath:=ds:C1482.FilePaths.query("FilePathID = :1"; "BirthdayGreeting").first()
		$webReturnValue:="cid:Embedded"+filePath.FileName
		
	: ($webParameter="customMessageFirstParagraph")
		$webReturnValue:=keyValue_getValue("email.greetings.birthday.first.paragraph")
		
	: ($webParameter="customMessageLastParagraph")
		$webReturnValue:=keyValue_getValue("email.greetings.birthday.last.paragraph")
		
End case 

$0:=$webReturnValue

