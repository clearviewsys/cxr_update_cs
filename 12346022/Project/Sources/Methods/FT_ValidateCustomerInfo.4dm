//%attributes = {}

If (<>doFINTRACchecks)  // FINTRAC compliancy checks
	
	Case of 
			
		: ([Customers:3]isCompany:41=False:C215)  //Customer Is an Individual
			
			checkIfNullString(->[Customers:3]LastName:4; "Customer Last Name"; "Warning")
			checkIfNullString(->[Customers:3]FirstName:3; "Customer First Name"; "Warning")
			checkIfNullString(->[Customers:3]CustomerID:1; "Customer ID"; "Warning")
			
			checkIfNullString(->[Customers:3]Address:7; "Customer Address"; "Warning")
			checkIfNullString(->[Customers:3]City:8; "Customer City"; "Warning")
			checkIfNullString(->[Customers:3]CountryCode:113; "Customer Country"; "Warning")
			checkIfNullString(->[Customers:3]Province:9; "Customer State"; "Warning")
			checkIfNullString(->[Customers:3]PostalCode:10; "Customer Postal code/Zipcode"; "Warning")
			
			checkIfNullString(->[Customers:3]CountryOfResidence_obs:61; "Customer Country of Residence"; "Warning")
			checkIfNullString(->[Customers:3]CountryOfResidenceCode:114; "Customer Country of Residence Code"; "Warning")
			
			checkIfNullString(->[Customers:3]HomeTel:6; "Home Phone Number"; "Warning")
			If (<>COMPANYCOUNTRY="Canada")
				checkIfNullString(->[Customers:3]PictureID_GovernmentCode:20; "Picture FINTRAC code"; "Warning")
				If (Substring:C12([Customers:3]PictureID_GovernmentCode:20; 1; 1)="E")
					checkIfNullString(->[Customers:3]PictureID_Type:70; "Picture ID Type"; "Warning")
				End if 
			End if 
			
			checkIfNullString(->[Customers:3]PictureID_Number:69; "Customer ID Number"; "Warning")
			checkIfNullString(->[Customers:3]PictureID_CountryCode:118; "Customer ID Country of Issue"; "Warning")
			checkIfNullString(->[Customers:3]PictureID_IssueState:72; "Customer ID State of Issue"; "Warning")
			checkIfDateIsFilled(->[Customers:3]DOB:5; False:C215; "Customer DOB")
			checkIfNullString(->[Customers:3]Occupation:21; "Customer Individual Occupation"; "Warning")
			
			checkIfNullString(->[Customers:3]WorkTel:12; "Customer Work Phone Number"; "Warning")
			checkIfNullString(->[Customers:3]WorkTelExt:117; "Customer Work Phone Number Extension"; "Warning")
			
			
	End case 
	
End if 
