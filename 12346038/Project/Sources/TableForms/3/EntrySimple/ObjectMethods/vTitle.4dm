Case of 
		
	: (Form event code:C388=On Load:K2:1)
		// once the form is loaded, assign the default value of the box to the field
		//ARRAY TEXT(vTitle; 0)
		//LIST TO ARRAY("Titles"; vTitle)
		// modify record
		//vTitle{0}:=[Customers]Salutation
		
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
		// after the combo box has been selected, assign the field to the new value 
		
		// fixed compiler error by @milan
		
		C_POINTER:C301($vtitle)
		
		$vtitle:=OBJECT Get pointer:C1124(Object named:K67:5; "vTitle")
		
		If (Size of array:C274($vtitle->)>0)
			[Customers:3]Salutation:2:=$vtitle->{0}
		End if 
		
		//
End case 