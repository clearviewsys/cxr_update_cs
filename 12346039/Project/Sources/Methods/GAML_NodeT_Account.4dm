//%attributes = {}
// GAML_NodeT_Account
// Create Account node from Customer or Link

C_TEXT:C284($1; $nodeRef; $2; $type)


Case of 
	: (Count parameters:C259=2)
		$nodeRef:=$1
		$type:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($dummy; $element; $tmp; $gender; $signatory; $birthDate; $t_person; $to_account; $identification; $issueDate; $expDate; $countryCode; $t_to)

// TODO: Verify with Relianz. Hash requirement: Change this to Lotus INfo.

Case of 
	: ($type="from")
		setFromAccountSection($nodeRef)
		
	: ($type="to")
		SetToAccountSection($nodeRef)
End case 




// Example:
// <to_account>
//    <institution_name>WESTPAC BANK</institution_name>
//    <swift>N/A</swift>
//    <non_bank_institution>False</non_bank_institution>
//    <account>301870625771000</account>
//    <currency_code>NZD</currency_code>
//    <account_name>NIPPON SOUTH PACIFIC LTD</account_name>
//    <personal_account_type>B</personal_account_type>
//    <status_code>A</status_code>
//    <beneficiary>NIPPON SOUTH PACIFIC LTD</beneficiary>
//</to_account>


If (False:C215)
	
	C_TEXT:C284($dummy; $element; $tmp)
	$element:=GAML_CreateXMLNode($to_account; "institution_name"; ->[eWires:13]BeneficiaryBankName:76; True:C214)
	
	If ([eWires:13]BeneficiarySWIFT:105#"")
		$element:=GAML_CreateXMLNode($to_account; "swift"; ->[eWires:13]BeneficiarySWIFT:105; True:C214)
	Else 
		
		If ([eWires:13]BeneficiaryBankTransitCode:77#"")
			$element:=GAML_CreateXMLNode($to_account; "swift"; ->[eWires:13]BeneficiaryBankTransitCode:77; True:C214)
		Else 
			$tmp:="N/A"
			$element:=GAML_CreateXMLNode($to_account; "swift"; ->$tmp; True:C214)
		End if 
		
		
		$dummy:="false"
		$element:=GAML_CreateXMLNode($to_account; "non_bank_institution"; ->$dummy; True:C214)
		$dummy:="N/A"
		$element:=GAML_CreateXMLNode($to_account; "branch"; ->$dummy; True:C214)
		
		$tmp:=Replace string:C233([eWires:13]BeneficiaryBankAccountNo:66; "-"; "")
		$element:=GAML_CreateXMLNode($to_account; "account"; ->$tmp; True:C214)
		//$element:=GAML_CreateXMLNode ($to_account;"account";->[eWires]BeneficiaryBankAccountNo;True)
		
		$element:=GAML_CreateXMLNode($to_account; "currency_code"; ->[eWires:13]Currency:12; True:C214)
		$element:=GAML_CreateXMLNode($to_account; "account_name"; ->[eWires:13]BeneficiaryFullName:5; True:C214)
		
		$tmp:=""  // G
		$element:=GAML_CreateXMLNode($to_account; "personal_account_type"; ->$tmp)
		
		$tmp:=""  // A
		$element:=GAML_CreateXMLNode($to_account; "status_code"; ->$tmp)
		
		$element:=GAML_CreateXMLNode($to_account; "beneficiary"; ->[eWires:13]BeneficiaryFullName:5; True:C214)
	End if 
	
End if 


If (False:C215)
	
	
	If ([Customers:3]Gender:120="")
		
		Case of 
			: (([Customers:3]Salutation:2="Mr.") | ([Customers:3]Salutation:2="Mr"))  // mr. 
				$gender:="M"
			: (([Customers:3]Salutation:2="Ms.") | ([Customers:3]Salutation:2="Ms") | ([Customers:3]Salutation:2="Mrs.") | ([Customers:3]Salutation:2="Mrs") | ([Customers:3]Salutation:2="Miss.") | ([Customers:3]Salutation:2="Miss"))  // mrs. miss, ms. 
				$gender:="F"
		End case 
		
		$element:=GAML_CreateXMLNode($t_person; "gender"; ->$gender; True:C214)
	Else 
		$element:=GAML_CreateXMLNode($t_person; "gender"; ->[Customers:3]Gender:120; True:C214)
	End if 
	
	
	$tmp:=Replace string:C233([Customers:3]Salutation:2; "."; "")
	$element:=GAML_CreateXMLNode($t_person; "title"; ->$tmp; True:C214)
	C_LONGINT:C283($p)
	$p:=Position:C15(" "; FJ_Trim([Customers:3]FirstName:3); 1)
	If ($p>0)
		$tmp:=Substring:C12(FJ_Trim([Customers:3]FirstName:3); 1; $p-1)
		$element:=GAML_CreateXMLNode($t_person; "first_name"; ->$tmp)
		
		$tmp:=Substring:C12(FJ_Trim([Customers:3]FirstName:3); $p+1)
		$element:=GAML_CreateXMLNode($t_person; "middle_name"; ->$tmp)
	Else 
		$tmp:=FJ_Trim([Customers:3]FirstName:3)
		$element:=GAML_CreateXMLNode($t_person; "first_name"; ->$tmp)
	End if 
	
	$tmp:=FJ_Trim([Customers:3]LastName:4)
	$element:=GAML_CreateXMLNode($t_person; "last_name"; ->$tmp; True:C214)
	
	$birthDate:=FT_GetStringDate([Customers:3]DOB:5; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
	$element:=GAML_CreateXMLNode($t_person; "birthdate"; ->$birthDate; True:C214)
	
	
	If ([Customers:3]CountryOfResidenceCode:114="NZ")
		$element:=GAML_CreateXMLNode($t_person; "id_number"; ->[Customers:3]PictureID_Number:69; False:C215)
	End if 
	
	$element:=GAML_CreateXMLNode($t_person; "nationality1"; ->[Customers:3]CountryOfBirthCode:18; True:C214)
	$element:=GAML_CreateXMLNode($t_person; "residence"; ->[Customers:3]CountryOfResidenceCode:114; True:C214)
	
	SetPhoneNumbers($t_person)
	GAML_SetAddress($t_person)
	
	$identification:=GAML_CreateXMLNode($t_person; "identification")
	QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
	
	If (Records in selection:C76([PictureIDTypes:92])>0)
		$element:=GAML_CreateXMLNode($identification; "type"; ->[PictureIDTypes:92]GovernmentCode:15; True:C214)
	Else 
		$tmp:=<>Reports_PTR_DefaultIDType
		$element:=GAML_CreateXMLNode($identification; "type"; ->$tmp; True:C214)  // -: Unknown
	End if 
	
	
	$element:=GAML_CreateXMLNode($identification; "number"; ->[Customers:3]PictureID_Number:69; True:C214)
	
	If ([Customers:3]PictureID_IssueDate:16#!00-00-00!)
		//$issueDate:=FT_GetStringDate ([Customers]PictureID_IssueDate;"-")+"T"+FT_GetStringTime (Time("00:00:00");":")
		//$element:=GAML_CreateXMLNode ($identification;"issue_date";->$issueDate;True)
	End if 
	
	If ([Customers:3]PictureID_ExpiryDate:71#!00-00-00!)
		$expDate:=FT_GetStringDate([Customers:3]PictureID_ExpiryDate:71; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
		$element:=GAML_CreateXMLNode($identification; "expiry_date"; ->$expDate; True:C214)
	End if 
	
	// TODO: Review for Relianz. Hash Requirement
	//$element:=GAML_CreateXMLNode ($identification;"issued_by";->[Customers]PictureID_Authority)
	//$countryCode:=[Customers]PictureID_CountryCode
	//If ($countryCode="")
	//$countryCode:=GAML_GetCountryCode ([Customers]PictureID_IssueCountry)
	//End if 
	
	$element:=GAML_CreateXMLNode($identification; "issue_country"; ->$countryCode; True:C214)
End if 