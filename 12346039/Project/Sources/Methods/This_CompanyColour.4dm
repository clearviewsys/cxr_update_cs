//%attributes = {}
// call this method from the Colour Expression of the Customers.ListBox form

// getBuild

If ([Customers:3]isCompany:41)
	$0:=calcRGB(0; 0; 120)
Else 
	$0:=calcRGB(130; 130; 256)
End if 