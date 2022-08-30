//%attributes = {}

// ------------------------------------------------------------------------------
// Method: FT_PartBD_1 : 
// Information about the individual ordering the transaction 
// 
// Parameters: 
//   see above
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 5/3/2019
// ------------------------------------------------------------------------------


C_TEXT:C284($1; $fileName)  // Report file path (include file name)      
C_TEXT:C284($2; $customerId)  // Customer ID
C_TEXT:C284($3; $partId)
C_TEXT:C284($4; $orderingPart)
C_BOOLEAN:C305($5; $isEFTO)


Case of 
	: (Count parameters:C259=2)
		
		$fileName:=$1
		$customerId:=$2
		$partId:="B1"
		$orderingPart:="Customers"
		$isEFTO:=False:C215
		
		
	: (Count parameters:C259=3)
		
		$fileName:=$1
		$customerId:=$2
		$partId:=$3
		$orderingPart:="Customers"
		$isEFTO:=False:C215
		
	: (Count parameters:C259=4)
		
		$fileName:=$1
		$customerId:=$2
		$partId:=$3
		$orderingPart:=$4
		$isEFTO:=False:C215
		
	: (Count parameters:C259=5)
		
		$fileName:=$1
		$customerId:=$2
		$partId:=$3
		$orderingPart:=$4
		$isEFTO:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($tmp; $surname; $givenname; $middle; $streetAddress; $city; $country)
C_TEXT:C284($state; $zipCode; $indHomePhoneNumber; $indDateOfBirth; $indOccupation)
C_TEXT:C284($account; $indTypeOtherDesc; $indNum)
C_BLOB:C604($content)

READ ONLY:C145([Links:17])
QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)

If (Position:C15("SELF"; [Links:17]Relationship:26)>0)
	// WARNING: The Beneficiary is SELF, take the Picture ID and all the information ONLY if hte key value is set to YES. From Customers
	If (keyValue_getValue("FT.UseSelfInLinks"; "NO")="NO")
		$orderingPart:="Customers"
	End if 
End if 


Case of 
		
	: ($orderingPart="Customers")
		
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerId)
		
		// Part ID
		TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)
		
		If ([Customers:3]isCompany:41)
			$tmp:=FT_StringFormat(FT_Clean([Customers:3]FullName:40); 45)
			TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)
			
			$tmp:=FT_StringFormat(" "; 45)  // Surname and others
			TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)
		Else 
			$tmp:=FT_StringFormat(" "; 45)
			TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)
			
			$surname:=FT_StringFormat(FT_Clean([Customers:3]LastName:4); 20; " ")  // Field 1
			TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
			
			$givenname:=FT_StringFormat(FT_Clean([Customers:3]FirstName:3); 15; " ")  // Field 2
			TEXT TO BLOB:C554($givenname; $content; UTF8 text without length:K22:17; *)
			
			$middle:=FT_StringFormat(""; 10; " "; "LJ")  // Field 3
			TEXT TO BLOB:C554($middle; $content; UTF8 text without length:K22:17; *)
		End if 
		
		
		// -----------------------------------------------------------
		
		
		// Street address
		If ([Customers:3]AddressUnitNo:148#"")
			$streetAddress:=FT_StringFormat(FT_Clean([Customers:3]AddressUnitNo:148+"-"+[Customers:3]Address:7); 30)
		Else 
			$streetAddress:=FT_StringFormat(FT_Clean([Customers:3]Address:7); 30)
		End if 
		
		TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
		
		// City
		$city:=FT_StringFormat(FT_Clean([Customers:3]City:8); 25)
		TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
		
		// Country
		$country:=FT_StringFormat(FT_Clean([Customers:3]CountryCode:113); 2)
		TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
		
		
		// -----------------------------------------------------------
		
		// Province/State
		$state:=FT_StringFormat(FT_Clean([Customers:3]Province:9); 20)
		TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
		
		// Postal/zip code
		$zipCode:=FT_StringFormat(FT_Clean([Customers:3]PostalCode:10); 9)
		TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
		
		// Home telephone number
		$indHomePhoneNumber:=FT_StringFormat(FT_Clean([Customers:3]HomeTel:6); 20)
		TEXT TO BLOB:C554($indHomePhoneNumber; $content; UTF8 text without length:K22:17; *)
		// Individual's date of birth
		
		If ([Customers:3]isCompany:41)
			$indDateOfBirth:=FT_StringFormat(" "; 8)
		Else 
			If ([Customers:3]DOB:5#!00-00-00!)
				$indDateOfBirth:=FT_GetStringDate([Customers:3]DOB:5)
			Else 
				$indDateOfBirth:=FT_StringFormat(" "; 8)
			End if 
			
		End if 
		
		
		TEXT TO BLOB:C554($indDateOfBirth; $content; UTF8 text without length:K22:17; *)
		
		// Individual's occupation
		If ([Customers:3]isCompany:41)
			$indOccupation:=FT_StringFormat(" "; 30)
		Else 
			$indOccupation:=FT_StringFormat(FT_Clean([Customers:3]Occupation:21); 30)
		End if 
		
		TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)
		
		// Client's account number
		If ($isEFTO)
			$account:=FT_StringFormat([Customers:3]CustomerID:1; 30)
		Else 
			If (getKeyValue("FT.UseCustomerID")="YES")
				$account:=FT_StringFormat([Customers:3]CustomerID:1; 30)
			Else 
				$account:=FT_StringFormat(" "; 30)
				//$account:=FT_StringFormat ([Links]BankAccountNo;30)
			End if 
			
		End if 
		
		
		//If (Position("SELF";[Links]Relationship)>0)  // WARNING: The Beneficiary is SELF, take the info From Customers
		//$account:=FT_StringFormat ([Customers]CustomerID;30)
		//Else 
		//$account:=FT_StringFormat ([Links]BankAccountNo;30)
		//End if 
		
		TEXT TO BLOB:C554($account; $content; UTF8 text without length:K22:17; *)
		
		
		If ([Customers:3]isCompany:41)
			$indType:=" "
			$indType:=FT_StringFormat($indType; 1)
			TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
			
			// Other description for code  ' ' must be spaces
			$indTypeOtherDesc:=FT_StringFormat(" "; 20)
			TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
			
		Else 
			QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
			$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
			$indType:=FT_StringFormat($indType; 1)
			
			TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
			
			If ($indType="E")
				// Id type Other description for code  'E' in $idType.  FUTURE USE
				$indTypeOtherDesc:=FT_StringFormat([PictureIDTypes:92]Description:14; 20)
				TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
			Else 
				$indTypeOtherDesc:=FT_StringFormat(" "; 20)
				TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
			End if 
		End if 
		
		
		If ($partId#"F1")
			// ID number
			If ([Customers:3]isCompany:41)
				$indNum:=FT_StringFormat(" "; 20)
				TEXT TO BLOB:C554($indNum; $content; UTF8 text without length:K22:17; *)
			Else 
				$indNum:=FT_StringFormat(FT_Clean([Customers:3]PictureID_Number:69); 20)
				TEXT TO BLOB:C554($indNum; $content; UTF8 text without length:K22:17; *)
			End if 
			
		End if 
		
	: ($orderingPart="Links")
		
		
		// Part ID
		TEXT TO BLOB:C554($partId; $content; UTF8 text without length:K22:17; *)
		
		If ([Links:17]isCompany:43)
			$tmp:=FT_StringFormat(FT_Clean([Links:17]FullName:4); 45)
			TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)
			
			$tmp:=FT_StringFormat(" "; 45)  // Surname and others
			TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)
		Else 
			$tmp:=FT_StringFormat(" "; 45)
			TEXT TO BLOB:C554($tmp; $content; UTF8 text without length:K22:17; *)
			
			$surname:=FT_StringFormat(FT_Clean([Links:17]LastName:3); 20; " ")  // Field 1
			TEXT TO BLOB:C554($surname; $content; UTF8 text without length:K22:17; *)
			
			$givenname:=FT_StringFormat(FT_Clean([Links:17]FirstName:2); 15; " ")  // Field 2
			TEXT TO BLOB:C554($givenname; $content; UTF8 text without length:K22:17; *)
			
			$middle:=FT_StringFormat(""; 10; " "; "LJ")  // Field 3
			TEXT TO BLOB:C554($middle; $content; UTF8 text without length:K22:17; *)
		End if 
		
		
		// -----------------------------------------------------------
		
		
		// Street address
		$streetAddress:=FT_StringFormat(FT_Clean([Links:17]Address:19); 30)
		TEXT TO BLOB:C554($streetAddress; $content; UTF8 text without length:K22:17; *)
		
		// City
		$city:=FT_StringFormat(FT_Clean([Links:17]City:11); 25)
		TEXT TO BLOB:C554($city; $content; UTF8 text without length:K22:17; *)
		
		// Country
		$country:=FT_StringFormat(FT_Clean([Links:17]countryCode:50); 2)
		TEXT TO BLOB:C554($country; $content; UTF8 text without length:K22:17; *)
		
		
		// -----------------------------------------------------------
		
		// Province/State
		$state:=FT_StringFormat(FT_Clean([Links:17]Province:60); 20)
		TEXT TO BLOB:C554($state; $content; UTF8 text without length:K22:17; *)
		
		// Postal/zip code
		$zipCode:=FT_StringFormat(FT_Clean([Links:17]PostalCode:61); 9)
		TEXT TO BLOB:C554($zipCode; $content; UTF8 text without length:K22:17; *)
		
		// Home telephone number
		$indHomePhoneNumber:=FT_StringFormat(FT_Clean([Links:17]MainPhone:8); 20)
		TEXT TO BLOB:C554($indHomePhoneNumber; $content; UTF8 text without length:K22:17; *)
		
		
		If ([Links:17]isCompany:43)
			$indDateOfBirth:=FT_StringFormat(" "; 8)
		Else 
			// Individual's date of birth
			If ([Links:17]DOB:49#!00-00-00!)
				$indDateOfBirth:=FT_GetStringDate([Links:17]DOB:49)
			Else 
				$indDateOfBirth:=FT_StringFormat(" "; 8)
			End if 
		End if 
		
		TEXT TO BLOB:C554($indDateOfBirth; $content; UTF8 text without length:K22:17; *)
		
		// Individual's occupation
		If ([Links:17]isCompany:43)
			$indOccupation:=FT_StringFormat(" "; 30)
		Else 
			$indOccupation:=FT_StringFormat(FT_Clean([Links:17]occupation:46); 30)
		End if 
		
		TEXT TO BLOB:C554($indOccupation; $content; UTF8 text without length:K22:17; *)
		
		
		// Client's account number
		//$account:=FT_StringFormat ([Links]BankAccountNo;30)
		
		
		// Client's account number
		If ($isEFTO)
			$account:=FT_StringFormat([Customers:3]CustomerID:1; 30)
		Else 
			If (getKeyValue("FT.UseCustomerID")="YES")
				$account:=FT_StringFormat([Links:17]LinkID:1; 30)
			Else 
				$account:=FT_StringFormat(" "; 30)
				//$account:=FT_StringFormat ([Links]BankAccountNo;30)
			End if 
		End if 
		TEXT TO BLOB:C554($account; $content; UTF8 text without length:K22:17; *)
		
		
		// Individual's identifier
		
		C_TEXT:C284($indType)
		
		If ([Links:17]isCompany:43)
			
			$indType:=" "
			$indType:=FT_StringFormat($indType; 1)
			TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
			
			// Other description for code  ' ' must be spaces
			$indTypeOtherDesc:=FT_StringFormat(" "; 20)
			//TEXT TO BLOB($indTypeOtherDesc;$content;UTF8 text without length;*)
			
		Else 
			
			If (Position:C15("SELF"; [Links:17]Relationship:26)>0)  // WARNING: The Beneficiary is SELF, take the Picture ID From Customers
				QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Customers:3]PictureID_TemplateID:15)
			Else 
				QUERY:C277([PictureIDTypes:92]; [PictureIDTypes:92]TemplateID:1=[Links:17]PictureIDType:34)
			End if 
			
			//QUERY([PictureIDTypes];[PictureIDTypes]TemplateID=[Links]PictureIDType)
			$indType:=Substring:C12([PictureIDTypes:92]GovernmentCode:15; 1; 1)
			$indType:=FT_StringFormat($indType; 1)
			
			TEXT TO BLOB:C554($indType; $content; UTF8 text without length:K22:17; *)
		End if 
		
		If ($indType="E")
			// Id type Other description for code  'E' in $idType.  FUTURE USE
			$indTypeOtherDesc:=FT_StringFormat([PictureIDTypes:92]Description:14; 20)
			TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
		Else 
			$indTypeOtherDesc:=FT_StringFormat(" "; 20)
			TEXT TO BLOB:C554($indTypeOtherDesc; $content; UTF8 text without length:K22:17; *)
		End if 
		
		If ($partId#"F1")
			// ID number
			If ([Links:17]isCompany:43)
				$indNum:=FT_StringFormat(" "; 20)
				TEXT TO BLOB:C554($indNum; $content; UTF8 text without length:K22:17; *)
			Else 
				$indNum:=FT_StringFormat(FT_Clean([Links:17]PictureIDNo:35); 20)
				TEXT TO BLOB:C554($indNum; $content; UTF8 text without length:K22:17; *)
			End if 
			
		End if 
End case 


AppendBlobToFile($fileName; $content)
