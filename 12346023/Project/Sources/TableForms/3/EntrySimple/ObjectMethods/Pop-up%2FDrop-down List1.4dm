Case of 
		
	: (Form event code:C388=On Load:K2:1)
		// once the form is loaded, assign the default value of the box to the field
		//ARRAY TEXT(vTitle; 0)
		//LIST TO ARRAY("Titles"; vTitle)
		// modify record
		//vTitle{0}:=[Customers]Salutation
		
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
		// after the combo box has been selected, assign the field to the new value    
		[Customers:3]Salutation:2:=vTitle{0}
		//
End case 