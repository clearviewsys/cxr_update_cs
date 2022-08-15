//%attributes = {}

Case of 
		
	: ([ThirdParties:101]IsCompany:2)  // Third party is a Company
		
		checkIfNullString(->[ThirdParties:101]CompanyName:23; "Third Party Company Name")
		checkIfNullString(->[ThirdParties:101]BusinessType:24; "Third Party Business Type"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]Address:6; "Third Party Company Address"; "Warning")
		checkIfNullString(->[ThirdParties:101]City:7; "Third Party City"; "Warning")
		checkIfNullString(->[ThirdParties:101]theState:29; "Third Party State"; "Warning")
		checkIfNullString(->[ThirdParties:101]ZipCode:9; "Third Party Postal Code/Zipcode"; "Warning")
		checkIfNullString(->[ThirdParties:101]CountryCode:8; "Third Party Country"; "Warning")
		checkIfNullString(->[ThirdParties:101]WorkPhone:11; "Third Party Work Phone Number"; "Warning")
		checkIfNullString(->[ThirdParties:101]WorkPhoneExt:12; "Third Party Work Phone Number Extension"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]IncorporationNumber:25; "Third Party Company Incorporation Number"; "Warning")
		checkIfNullString(->[ThirdParties:101]IdCountryOfIssue:18; "Third Party Company Country of Issue"; "Warning")
		checkIfNullString(->[ThirdParties:101]IdIssueState:19; "Third Party Incorporation # State of Issue"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]Authorized1:26; "Name 1 of individual authorized to bind the entity"; "Warning")
		checkIfNullString(->[ThirdParties:101]Authorized2:27; "Name 2 of individual authorized to bind the entity"; "Warning")
		checkIfNullString(->[ThirdParties:101]Authorized3:28; "Name 3 of individual authorized to bind the entity"; "Warning")
		
	: ([ThirdParties:101]IsCompany:2=False:C215)  // Third party Is an Individual
		
		checkIfNullString(->[ThirdParties:101]LastName:3; "Third Party Last Name")
		checkIfNullString(->[ThirdParties:101]FirstName:4; "Third Party First Name")
		checkIfNullString(->[ThirdParties:101]OtherName:5; "Third Party Other Name"; "Warning")
		checkIfDateIsFilled(->[ThirdParties:101]DOB:13; False:C215; "Third Party Date of Birth")
		checkIfNullString(->[ThirdParties:101]Address:6; "Third Party Address"; "Warning")
		checkIfNullString(->[ThirdParties:101]City:7; "Third Party City"; "Warning")
		checkIfNullString(->[ThirdParties:101]theState:29; "Third Party State"; "Warning")
		checkIfNullString(->[ThirdParties:101]ZipCode:9; "Third Party Postal code/Zipcode"; "Warning")
		checkIfNullString(->[ThirdParties:101]CountryCode:8; "Third Party Country"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]HomePhone:10; "Third Party Home Phone Number"; "Warning")
		checkIfNullString(->[ThirdParties:101]WorkPhone:11; "Third Party Work Phone Number"; "Warning")
		checkIfNullString(->[ThirdParties:101]WorkPhoneExt:12; "Third Party Work Phone Number Extension"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]IdType:14; "Third Party ID Type"; "Warning")
		
		If (Substring:C12([ThirdParties:101]IdType:14; 1; 1)="E")
			checkIfNullString(->[ThirdParties:101]IdOtherType:15; "Third Party Other Type"; "Warning")
		End if 
		checkIfNullString(->[ThirdParties:101]IdNumber:16; "Third Party ID Number"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]IdCountryOfIssue:18; "Third Party ID Country of Issue"; "Warning")
		checkIfNullString(->[ThirdParties:101]IdIssueState:19; "Third Party ID State of Issue"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]CountryOfResidence:17; "Third Party ID Country of Residence"; "Warning")
		checkIfNullString(->[ThirdParties:101]Occupation:20; "Third Party Individual Ocupation"; "Warning")
		
		checkIfNullString(->[ThirdParties:101]RelationshipCode:21; "Third Party Relationship to Individual"; "Warning")
		
		If (Substring:C12([ThirdParties:101]RelationshipCode:21; 1; 1)="J")
			checkIfNullString(->[ThirdParties:101]OtherRelationship:22; "Third Party Other Relationship"; "Warning")
		End if 
		
End case 



