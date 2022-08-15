//%attributes = {}

// GAML_NodeT_PersonFromCustomer

C_TEXT:C284($1; $node; $fromPerson; $tPerson; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($birthDate; $identification; $gender; $name)
C_TEXT:C284($tmp; $element; $issueDate; $expDate; $countryCode; $idGovCode; $incorporation_date; $goAMLDate)


Case of 
	: (Count parameters:C259=1)
		$node:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// If $t_conductor is Company Is not possible to report this information

If ([Customers:3]isCompany:41)
	
	// Is a compnay Change the XML Node Name
	DOM GET XML ELEMENT NAME:C730($node; $name)
	Case of 
		: ($name="from_person")
			DOM SET XML ELEMENT NAME:C867($node; "from_entity")
			
		: ($name="to_person")
			DOM SET XML ELEMENT NAME:C867($node; "to_entity")
			
	End case 
	
	If ([Customers:3]AML_ignoreKYC:35=True:C214)  // Customer is not my client
		$element:=GAML_CreateXMLNode($node; "name"; ->[Customers:3]FullName:40; True:C214)
		$tmp:="F"
		$element:=GAML_CreateXMLNode($node; "incorporation_legal_form"; ->$tmp)
		$element:=GAML_CreateXMLNode($node; "incorporation_number"; ->[Customers:3]BusinessIncorporationNo:65)
		//$element:=GAML_CreateXMLNode ($node;"business";->[Customers]BusinessType)
		
		$tmp:=""
		SetPhoneNumbers($node)
		GAML_SetAddress($node)
		
		//$element:=GAML_CreateXMLNode ($node;"email";->[Customers]Email)
		//$element:=GAML_CreateXMLNode ($node;"incorporation_state";->[Customers]BusinessIncorportedInState)
		$element:=GAML_CreateXMLNode($node; "incorporation_country_code"; ->[Customers:3]BusinessIncorporatedInCountry:67)
		
	Else 
		
		$element:=GAML_CreateXMLNode($node; "name"; ->[Customers:3]FullName:40; True:C214)
		$tmp:="F"
		$element:=GAML_CreateXMLNode($node; "incorporation_legal_form"; ->$tmp)
		$element:=GAML_CreateXMLNode($node; "incorporation_number"; ->[Customers:3]BusinessIncorporationNo:65; True:C214)
		//$element:=GAML_CreateXMLNode ($node;"business";->[Customers]BusinessType;True)
		
		$tmp:=""
		SetPhoneNumbers($node)
		GAML_SetAddress($node)
		
		//$element:=GAML_CreateXMLNode ($node;"email";->[Customers]Email)
		//$element:=GAML_CreateXMLNode ($node;"incorporation_state";->[Customers]BusinessIncorportedInState;True)
		$element:=GAML_CreateXMLNode($node; "incorporation_country_code"; ->[Customers:3]BusinessIncorporatedInCountry:67; True:C214)
		
		If ([Customers:3]BusinessIncorporationDate:29#Date:C102("00/00/00"))
			$goAMLDate:=FT_GetStringDate([Customers:3]BusinessIncorporationDate:29; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
			$element:=GAML_CreateXMLNode($node; "incorporation_date"; ->$goAMLDate)
		End if 
		
		// TODO: Add information about the director, must be a class of link
	End if 
	
Else 
	
	Case of 
			
		: ([Customers:3]AML_ignoreKYC:35=False:C215)  // Customer is my client
			
			
			If ([Customers:3]Gender:120="")
				
				Case of 
					: (([Customers:3]Salutation:2="Mr.") | ([Customers:3]Salutation:2="Mr"))  // mr. 
						$gender:="M"
					: (([Customers:3]Salutation:2="Ms.") | ([Customers:3]Salutation:2="Ms") | ([Customers:3]Salutation:2="Mrs.") | ([Customers:3]Salutation:2="Mrs") | ([Customers:3]Salutation:2="Miss.") | ([Customers:3]Salutation:2="Miss"))  // mrs. miss, ms. 
						$gender:="F"
				End case 
				
				$element:=GAML_CreateXMLNode($node; "gender"; ->$gender; True:C214)
			Else 
				$element:=GAML_CreateXMLNode($node; "gender"; ->[Customers:3]Gender:120; True:C214)
			End if 
			$tmp:=Replace string:C233([Customers:3]Salutation:2; "."; "")
			$element:=GAML_CreateXMLNode($node; "title"; ->$tmp; True:C214)
			
			C_LONGINT:C283($p)
			
			$p:=Position:C15(" "; FJ_Trim([Customers:3]FirstName:3); 1)
			If ($p>0)
				$tmp:=Substring:C12(FJ_Trim([Customers:3]FirstName:3); 1; $p-1)
				$element:=GAML_CreateXMLNode($node; "first_name"; ->$tmp; True:C214)
				
				$tmp:=Substring:C12(FJ_Trim([Customers:3]FirstName:3); $p+1)
				$element:=GAML_CreateXMLNode($node; "middle_name"; ->$tmp; True:C214)
			Else 
				$tmp:=FJ_Trim([Customers:3]FirstName:3)
				$element:=GAML_CreateXMLNode($node; "first_name"; ->$tmp; True:C214)
			End if 
			
			$tmp:=FJ_Trim([Customers:3]LastName:4)
			$element:=GAML_CreateXMLNode($node; "last_name"; ->$tmp; True:C214)
			//$element:=GAML_CreateXMLNode ($node;"last_name";->[Customers]LastName;True)
			
			
			
			$birthDate:=FT_GetStringDate([Customers:3]DOB:5; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
			$element:=GAML_CreateXMLNode($node; "birthdate"; ->$birthDate; True:C214)
			
			$idGovCode:=getGovernmentCode
			
			
			If ($idGovCode#"")
				$element:=GAML_CreateXMLNode($identification; "type"; ->$idGovCode; True:C214)
				
				If (([Customers:3]CountryOfResidenceCode:114="NZ") & ($idGovCode=getKeyValue("nzptr.driverLic.code"; "A")))
					$tmp:=FJ_Trim([Customers:3]PictureID_Number:69)
					$element:=GAML_CreateXMLNode($node; "id_number"; ->$tmp; False:C215)
				Else 
					
					If ($idGovCode=getKeyValue("nzptr.passport.code"; "F"))
						$tmp:=FJ_Trim([Customers:3]PictureID_Number:69)
						$element:=GAML_CreateXMLNode($node; "passport_number"; ->$tmp)
						$element:=GAML_CreateXMLNode($node; "passport_country"; ->[Customers:3]PictureID_CountryCode:118)
					End if 
					
				End if 
				
			End if 
			
			
			
			$element:=GAML_CreateXMLNode($node; "nationality1"; ->[Customers:3]CountryOfBirthCode:18; True:C214)
			$element:=GAML_CreateXMLNode($node; "residence"; ->[Customers:3]CountryOfResidenceCode:114; True:C214)
			
			SetPhoneNumbers($node)
			GAML_SetAddress($node)
			
			//$element:=GAML_CreateXMLNode ($node;"nationality1";->[Customers]CountryOfBirthCode)
			//s$element:=GAML_CreateXMLNode ($node;"residence";->[Customers]CountryOfResidenceCode)
			$element:=GAML_CreateXMLNode($node; "email"; ->[Customers:3]Email:17)
			//$element:=GAML_CreateXMLNode ($node;"occupation";->[Customers]Occupation)  // What to do with [Customers]OccupationCode?
			
			$identification:=GAML_CreateXMLNode($node; "identification")
			
			$idGovCode:=getGovernmentCode
			$element:=GAML_CreateXMLNode($identification; "type"; ->$idGovCode; True:C214)
			
			$tmp:=FJ_Trim([Customers:3]PictureID_Number:69)
			$element:=GAML_CreateXMLNode($identification; "number"; ->$tmp; True:C214)
			
			If ([Customers:3]PictureID_IssueDate:16#!00-00-00!)
				$issueDate:=FT_GetStringDate([Customers:3]PictureID_IssueDate:16; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
				//$element:=GAML_CreateXMLNode ($identification;"issue_date";->$issueDate;True)
				//$element:=GAML_CreateXMLNode ($identification;"issue_date";->$issueDate;True)
			End if 
			
			
			If ([Customers:3]PictureID_ExpiryDate:71#!00-00-00!)
				$expDate:=FT_GetStringDate([Customers:3]PictureID_ExpiryDate:71; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
				$element:=GAML_CreateXMLNode($identification; "expiry_date"; ->$expDate; True:C214)
			End if 
			
			// TODO: Review for Relianz
			//$element:=GAML_CreateXMLNode ($identification;"issued_by";->[Customers]PictureID_Authority)
			$countryCode:=[Customers:3]PictureID_CountryCode:118
			If ($countryCode="")
				$countryCode:=GAML_GetCountryCode([Customers:3]PictureID_IssueCountry:73)
			End if 
			
			$element:=GAML_CreateXMLNode($identification; "issue_country"; ->$countryCode; True:C214)
			
			
		: ([Customers:3]AML_ignoreKYC:35=True:C214)  // Customer is NOT my client
			
			If ([Customers:3]Gender:120="")
				Case of 
					: ([Customers:3]Salutation:2="Mr.")  // mr. 
						$gender:="M"
					: (([Customers:3]Salutation:2="Ms.") | ([Customers:3]Salutation:2="Mrs.") | ([Customers:3]Salutation:2="Miss."))  // mrs. miss, ms. 
						$gender:="F"
				End case 
				$element:=GAML_CreateXMLNode($node; "gender"; ->$gender)
			Else 
				$element:=GAML_CreateXMLNode($node; "gender"; ->[Customers:3]Gender:120)
			End if 
			$tmp:=Replace string:C233([Customers:3]Salutation:2; "."; "")
			$element:=GAML_CreateXMLNode($node; "title"; ->$tmp)
			
			//$element:=GAML_CreateXMLNode ($node;"title";->[Customers]Salutation)
			
			$tmp:=FJ_Trim([Customers:3]FirstName:3)
			$element:=GAML_CreateXMLNode($node; "first_name"; ->$tmp; True:C214)
			//$element:=GAML_CreateXMLNode ($node;"first_name";->[Customers]FirstName;True)
			
			$tmp:=FJ_Trim([Customers:3]LastName:4)
			$element:=GAML_CreateXMLNode($node; "last_name"; ->$tmp; True:C214)
			//$element:=GAML_CreateXMLNode ($node;"last_name";->[Customers]LastName;True)
			
			
			$idGovCode:=getGovernmentCode
			
			
			
			If ($idGovCode#"")
				$element:=GAML_CreateXMLNode($identification; "type"; ->$idGovCode; True:C214)
				
				If (([Customers:3]CountryOfResidenceCode:114="NZ") & ($idGovCode=getKeyValue("nzptr.driverLic.code"; "A")))
					$tmp:=FJ_Trim([Customers:3]PictureID_Number:69)
					$element:=GAML_CreateXMLNode($identification; "id_number"; ->$tmp; False:C215)
				Else 
					
					If ($idGovCode=getKeyValue("nzptr.passport.code"; "F"))
						$tmp:=FJ_Trim([Customers:3]PictureID_Number:69)
						$element:=GAML_CreateXMLNode($identification; "passport_number"; ->$tmp)
						$element:=GAML_CreateXMLNode($identification; "passport_country"; ->[Customers:3]PictureID_CountryCode:118)
					End if 
					
				End if 
				
			End if 
			
			
			If ([Customers:3]DOB:5#!00-00-00!)
				$birthDate:=FT_GetStringDate([Customers:3]DOB:5; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
				$element:=GAML_CreateXMLNode($node; "birthdate"; ->$birthDate)
			End if 
			
			SetPhoneNumbers($node)
			GAML_SetAddress($node)
			
			$element:=GAML_CreateXMLNode($node; "email"; ->[Customers:3]Email:17)
			//$element:=GAML_CreateXMLNode ($node;"occupation";->[Customers]Occupation)  // What to do with [Customers]OccupationCode?
			
			
			// Create <identification> tag if the mandatory fields are provided
			
			If (([Customers:3]PictureID_Number:69#"") & ([Customers:3]PictureID_CountryCode:118#""))
				
				
				$identification:=GAML_CreateXMLNode($node; "identification")
				
				If ($idGovCode#"")
					$element:=GAML_CreateXMLNode($identification; "type"; ->$idGovCode; True:C214)
				Else 
					$tmp:=<>Reports_PTR_DefaultIDType
					$element:=GAML_CreateXMLNode($identification; "type"; ->$tmp; True:C214)  // -: Unknown
				End if 
				
				
				
				If ([Customers:3]PictureID_IssueDate:16#!00-00-00!)
					//$issueDate:=FT_GetStringDate ([Customers]PictureID_IssueDate;"-")+"T"+FT_GetStringTime (Time("00:00:00");":")
					//$element:=GAML_CreateXMLNode ($identification;"issue_date";->$issueDate)
				End if 
				
				If ([Customers:3]PictureID_ExpiryDate:71#!00-00-00!)
					$expDate:=FT_GetStringDate([Customers:3]PictureID_ExpiryDate:71; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
					$element:=GAML_CreateXMLNode($identification; "expiry_date"; ->$expDate)
				End if 
				
				//$element:=GAML_CreateXMLNode ($identification;"issued_by";->[Customers]PictureID_Authority)
				
				$countryCode:=[Customers:3]PictureID_CountryCode:118
				If ($countryCode="")
					$countryCode:=GAML_GetCountryCode([Customers:3]PictureID_IssueCountry:73)
				End if 
				
				$element:=GAML_CreateXMLNode($identification; "issue_country"; ->$countryCode)
				
			End if 
			
			
	End case 
	
	
End if 



