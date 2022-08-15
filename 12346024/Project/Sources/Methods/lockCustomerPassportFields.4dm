//%attributes = {}
// lockCustomerPassportFields (true for enterable; false for lock)
// This is a customization requested by Al Sharhan
// When the scanner reads the information, the system should lock the passport
// related fields such as First Name, Last Name, DOB, etc...

C_BOOLEAN:C305($lock; $1)

Case of 
	: (Count parameters:C259=0)
		$lock:=False:C215
	: (Count parameters:C259=1)
		$lock:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
OBJECT SET ENTERABLE:C238([Customers:3]FirstName:3; $lock)
OBJECT SET ENTERABLE:C238([Customers:3]LastName:4; $lock)
OBJECT SET ENTERABLE:C238([Customers:3]Gender:120; $lock)
OBJECT SET ENTERABLE:C238([Customers:3]DOB:5; $lock)
OBJECT SET ENTERABLE:C238([Customers:3]PictureID_Number:69; $lock)
OBJECT SET ENTERABLE:C238([Customers:3]PictureID_Type:70; $lock)
OBJECT SET ENTERABLE:C238([Customers:3]PictureID_ExpiryDate:71; $lock)
