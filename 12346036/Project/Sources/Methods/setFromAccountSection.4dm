//%attributes = {}
// setFromAccountSection ($nodeRef)

C_TEXT:C284($1; $nodeRef)

Case of 
	: (Count parameters:C259=1)
		$nodeRef:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($dummy; $element; $tmp; $gender; $signatory; $birthDate; $t_person; $to_account; $identification; $issueDate; $expDate; $countryCode; $t_to)

If ([eWires:13]isPaymentSent:20)
	
	$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->reportingEntityName; True:C214)
	$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->reportingEntityID; True:C214)
	
	$dummy:="true"
	$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
	$dummy:=[Branches:70]BranchName:2+", "+[Branches:70]City:4
	$element:=GAML_CreateXMLNode($nodeRef; "branch"; ->$dummy; True:C214)
	
	$element:=GAML_CreateXMLNode($nodeRef; "account"; ->[Customers:3]CustomerID:1; True:C214)
	$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[Customers:3]FullName:40; True:C214)
	
	//$signatory:=GAML_CreateXMLNode ($nodeRef;"signatory")
	If ([Customers:3]isCompany:41)
		$t_to:=GAML_CreateXMLNode($nodeRef; "t_entity")
	Else 
		$signatory:=GAML_CreateXMLNode($nodeRef; "signatory")
		$t_to:=GAML_CreateXMLNode($signatory; "t_person")
	End if 
	
	GAML_NodeT_PersonFromCustomer($t_to)
	
	
Else 
	
	
	$tmp:="Lotus Foreign Exchange Limited "+[eWires:13]fromCountry:9
	$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->$tmp; True:C214)
	
	Case of 
		: ([eWires:13]fromCountryCode:111="FJ")
			$tmp:=getKeyValue("nzptr.NZ.institution.code"; "15292")
			$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
			
			
		: ([eWires:13]fromCountryCode:111="AU")
			
			$tmp:=getKeyValue("nzptr.AU.institution.code"; "71108877050")
			$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
			
		: ([eWires:13]fromCountryCode:111="NZ")
			
			$tmp:=getKeyValue("nzptr.NZ.institution.code"; "870")
			$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
			
		Else 
			$tmp:="*UNKOWN*"
			$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
			
	End case 
	
	$dummy:="true"
	$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
	
	$element:=GAML_CreateXMLNode($nodeRef; "account"; ->[eWires:13]eWireID:1; True:C214)
	$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[eWires:13]SenderName:7; True:C214)
	
	
End if 
