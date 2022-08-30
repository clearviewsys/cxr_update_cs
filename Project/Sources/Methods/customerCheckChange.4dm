//%attributes = {}
// customerCheckChange 
// $atOldValue & $atNewValue array is the actual text that shows in the email

ARRAY TEXT:C222($atOldValue; 0)
ARRAY TEXT:C222($atNewValue; 0)
If (isFieldValueChanged(->[Customers:3]Email:17))
	APPEND TO ARRAY:C911($atOldValue; Old:C35([Customers:3]Email:17))
	APPEND TO ARRAY:C911($atNewValue; [Customers:3]Email:17)
End if 
If (isFieldValueChanged(->[Customers:3]Address:7))
	APPEND TO ARRAY:C911($atOldValue; Old:C35([Customers:3]Address:7))
	APPEND TO ARRAY:C911($atNewValue; [Customers:3]Address:7)
End if 

If (isFieldValueChanged(->[Customers:3]isAllowedInternetAccess:50))
	Case of 
		: ([Customers:3]isAllowedInternetAccess:50=True:C214)
			APPEND TO ARRAY:C911($atOldValue; "Not Allowed Web Access")
			APPEND TO ARRAY:C911($atNewValue; "Allowed Web Access")
		: ([Customers:3]isAllowedInternetAccess:50=False:C215)
			APPEND TO ARRAY:C911($atOldValue; "Allowed Web Access")
			APPEND TO ARRAY:C911($atNewValue; "Not Allowed Web Access")
	End case 
End if 

If (Size of array:C274($atNewValue)>=1)
	createEmailForCustomer(->$atOldValue; ->$atNewValue)
End if 