//%attributes = {}
// validation specific to NZ but for all transactions
// do not add any transactions that depend on a transaction volume or type

If ((<>CountryCode="NZ") | (<>CountryCode="FJ"))
	
	If ([Customers:3]isCompany:41)
		// all the important company info that need to be saved
		checkIfNullString(->[Customers:3]BusinessIncorporationNo:65; "Business Inc. No")
		checkIfNullString(->[Customers:3]BusinessIncorporatedInCountry:67; "Business Inc. in Country")
		checkIfNullString(->[Customers:3]WorkTel:12; "Business Work Phone")
		checkIfNullString(->[Customers:3]Address:7; "Address")
		checkIfNullString(->[Customers:3]City:8; "City")
		checkIfNullString(->[Customers:3]CountryCode:113; "Address Country Code")
		
	Else 
		checkIfNullString(->[Customers:3]Gender:120; "Gender")
		checkIfNullString(->[Customers:3]Salutation:2; "Salutation (Title)")
		checkIfNullString(->[Customers:3]Address:7; "Address")
		checkIfValidDOB([Customers:3]DOB:5; "Date of Birth")
		checkIfNullString(->[Customers:3]Occupation:21; "Occupation")
		checkIfNullString(->[Customers:3]CountryOfBirthCode:18; "Nationality")
		checkIfNullString(->[Customers:3]CountryCode:113; "Country Code")
		checkIfNullString(->[Customers:3]CountryOfResidenceCode:114; "Country of Residence")
		checkIfNullString(->[Customers:3]CitizenshipCountryCode:22; "Country of Citizenship")
		
		checkIfNullString(->[Customers:3]PictureID_TemplateID:15; "Picture ID Template")
		
	End if 
End if 