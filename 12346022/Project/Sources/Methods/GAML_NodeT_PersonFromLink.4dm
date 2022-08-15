//%attributes = {}

// GAML_NodeT_PersonFromLink

C_TEXT:C284($1; $node; $element; $phones; $contactType; $commType; $addresses; $address; $addressType)
C_TEXT:C284($birthDate; $fn; $ln; $tmp)
C_LONGINT:C283($pos)
C_TEXT:C284($empty)
$empty:=""

Case of 
	: (Count parameters:C259=1)
		$node:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ([eWires:13]LinkID:8#"")
	QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
	
	Case of 
		: (Records in selection:C76([Links:17])=1) & ([Links:17]isCompany:43=False:C215)
			
			$element:=GAML_CreateXMLNode($node; "gender"; ->[Links:17]Gender:47)
			$tmp:=Replace string:C233([Links:17]Salutation:25; "."; "")
			$element:=GAML_CreateXMLNode($node; "title"; ->$tmp)
			
			//$element:=GAML_CreateXMLNode ($node;"title";->[Links]Salutation)
			
			
			$tmp:=FJ_Trim([Links:17]FirstName:2)
			$element:=GAML_CreateXMLNode($node; "first_name"; ->$tmp)
			
			//$element:=GAML_CreateXMLNode ($node;"first_name";->[Links]FirstName)
			
			$tmp:=FJ_Trim([Links:17]LastName:3)
			$element:=GAML_CreateXMLNode($node; "last_name"; ->$tmp)
			
			//$element:=GAML_CreateXMLNode ($node;"last_name";->[Links]LastName)
			
			If ([Links:17]DOB:49#!00-00-00!)
				$birthDate:=FT_GetStringDate([Links:17]DOB:49; "-")+"T"+FT_GetStringTime(Time:C179("00:00:00"); ":")
				$element:=GAML_CreateXMLNode($node; "birthdate"; ->$birthDate)
			End if 
			
			
			//$element:=GAML_CreateXMLNode ($node;"id_number";->[Links]PictureIDNo)
			
			GAML_SetPhones($node; ->[Links:17]MainPhone:8; ->[Links:17]SecondaryPhone:7)
			GAML_SetAddress($node; ->[Links:17]Address:19; ->[Links:17]City:11; ->$empty; ->$empty; ->[Links:17]countryCode:50)
			$element:=GAML_CreateXMLNode($node; "email"; ->[Links:17]email:5)
			$element:=GAML_CreateXMLNode($node; "occupation"; ->[Links:17]occupation:46)
			$element:=GAML_CreateXMLNode($node; "comments"; ->[Links:17]Relationship:26)
			
		: (Records in selection:C76([Links:17])=1) & ([Links:17]isCompany:43=True:C214)
			DOM SET XML ELEMENT NAME:C867($node; "to_entity")
			$element:=GAML_CreateXMLNode($node; "name"; ->[Links:17]FullName:4)
			GAML_SetPhones($node; ->[Links:17]MainPhone:8; ->[Links:17]SecondaryPhone:7)
			GAML_SetAddress($node; ->[Links:17]Address:19; ->[Links:17]City:11; ->$empty; ->$empty; ->[Links:17]countryCode:50)
			$element:=GAML_CreateXMLNode($node; "email"; ->[Links:17]email:5)
			
		: (Records in selection:C76([Links:17])=0)
			
			Case of 
					
				: ([eWires:13]isBeneficiaryCompany:93=False:C215)
					
					$pos:=Position:C15(" "; [eWires:13]BeneficiaryFullName:5)
					$fn:=Substring:C12([eWires:13]BeneficiaryFullName:5; 1; $pos-1)
					$ln:=Substring:C12([eWires:13]BeneficiaryFullName:5; $pos+1)
					
					
					$element:=GAML_CreateXMLNode($node; "gender"; ->[eWires:13]BeneficiaryGender:108)
					$tmp:=Replace string:C233([eWires:13]BeneficiarySalutation:109; "."; "")
					$element:=GAML_CreateXMLNode($node; "title"; ->$tmp)
					//$element:=GAML_CreateXMLNode ($node;"title";->[eWires]BeneficiarySalutation)
					C_LONGINT:C283($p)
					$p:=Position:C15(" "; FJ_Trim($fn); 1)
					If ($p>0)
						$tmp:=Substring:C12(FJ_Trim($fn); 1; $p-1)
						$element:=GAML_CreateXMLNode($node; "first_name"; ->$tmp)
						
						$tmp:=Substring:C12(FJ_Trim($fn); $p+1)
						$element:=GAML_CreateXMLNode($node; "middle_name"; ->$tmp)
					Else 
						$tmp:=FJ_Trim($fn)
						$element:=GAML_CreateXMLNode($node; "first_name"; ->$tmp)
					End if 
					
					$ln:=FJ_Trim($ln)
					$element:=GAML_CreateXMLNode($node; "last_name"; ->$ln)
					
					
				: ([eWires:13]isBeneficiaryCompany:93=True:C214)
					DOM SET XML ELEMENT NAME:C867($node; "to_entity")
					$element:=GAML_CreateXMLNode($node; "name"; ->[eWires:13]BeneficiaryFullName:5)
					GAML_SetPhones($node; ->[eWires:13]BeneficiaryCellPhone:61)
					GAML_SetAddress($node; ->[eWires:13]BeneficiaryAddress:59; ->[eWires:13]BeneficiaryCity:60; ->$empty; ->$empty; ->[eWires:13]toCountryCode:112)
					$element:=GAML_CreateXMLNode($node; "email"; ->[eWires:13]BeneficiaryEmail:63)
					
			End case 
	End case 
	
Else 
	Case of 
			
		: ([eWires:13]isBeneficiaryCompany:93=False:C215)
			
			$pos:=Position:C15(" "; [eWires:13]BeneficiaryFullName:5)
			$fn:=Substring:C12([eWires:13]BeneficiaryFullName:5; 1; $pos-1)
			$ln:=Substring:C12([eWires:13]BeneficiaryFullName:5; $pos+1)
			
			
			$element:=GAML_CreateXMLNode($node; "gender"; ->[eWires:13]BeneficiaryGender:108)
			$tmp:=Replace string:C233([eWires:13]BeneficiarySalutation:109; "."; "")
			$element:=GAML_CreateXMLNode($node; "title"; ->$tmp)
			//$element:=GAML_CreateXMLNode ($node;"title";->[eWires]BeneficiarySalutation)
			
			$fn:=FJ_Trim($fn)
			$element:=GAML_CreateXMLNode($node; "first_name"; ->$fn)
			
			$ln:=FJ_Trim($ln)
			$element:=GAML_CreateXMLNode($node; "last_name"; ->$ln)
			
			
		: ([eWires:13]isBeneficiaryCompany:93=True:C214)
			
			DOM SET XML ELEMENT NAME:C867($node; "to_entity")
			$element:=GAML_CreateXMLNode($node; "name"; ->[eWires:13]BeneficiaryFullName:5)
			GAML_SetPhones($node; ->[eWires:13]BeneficiaryCellPhone:61)
			GAML_SetAddress($node; ->[eWires:13]BeneficiaryAddress:59; ->[eWires:13]BeneficiaryCity:60; ->$empty; ->$empty; ->[eWires:13]toCountryCode:112)
			$element:=GAML_CreateXMLNode($node; "email"; ->[eWires:13]BeneficiaryEmail:63)
			
	End case 
	
	
End if 


