//%attributes = {}

// SetToAccountSection

C_TEXT:C284($1; $nodeRef)

Case of 
	: (Count parameters:C259=1)
		$nodeRef:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($dummy; $element; $tmp; $gender; $signatory; $birthDate; $t_person; $to_account; $identification; $issueDate; $expDate; $countryCode; $t_to)

If ([eWires:13]isPaymentSent:20)
	
	If ([eWires:13]doTransferToBank:33)
		$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->[eWires:13]BeneficiaryBankName:76; True:C214)
		$element:=GAML_CreateXMLNode($nodeRef; "swift"; ->[eWires:13]BeneficiarySWIFT:105; True:C214)
		//$element:=GAML_CreateXMLNode ($nodeRef;"swift";->[eWires]BeneficiaryBankTransitCode;True)
		
		//If ([eWires]BeneficiarySWIFT#"")
		//$element:=GAML_CreateXMLNode ($nodeRef;"swift";->[eWires]BeneficiarySWIFT;True)
		
		//Else 
		
		//If ([eWires]BeneficiaryBankTransitCode#"")
		//$element:=GAML_CreateXMLNode ($nodeRef;"swift";->[eWires]BeneficiaryBankTransitCode;True)
		//Else 
		//$tmp:=""
		//$element:=GAML_CreateXMLNode ($nodeRef;"swift";->$tmp;True)
		//End if 
		
		//End if 
		
		$dummy:="false"
		$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
		
		$tmp:=Replace string:C233([eWires:13]BeneficiaryBankAccountNo:66; "-"; "")
		$element:=GAML_CreateXMLNode($nodeRef; "account"; ->$tmp; True:C214)
		//$element:=GAML_CreateXMLNode ($to_account;"account";->[eWires]BeneficiaryBankAccountNo;True)
		
		//$element:=GAML_CreateXMLNode ($nodeRef;"account";->[eWires]eWireID;True)
		$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[eWires:13]BeneficiaryFullName:5; True:C214)
		//$element:=GAML_CreateXMLNode ($nodeRef;"branch";->[Branches]BranchName;True)
	Else 
		
		$tmp:="Lotus Foreign Exchange Limited "+[eWires:13]toCountry:10
		$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->$tmp; True:C214)
		
		Case of 
			: ([eWires:13]toCountryCode:112="FJ")
				
				$tmp:=getKeyValue("nzptr.NZ.institution.code"; "15292")
				$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
				
				
			: ([eWires:13]toCountryCode:112="AU")
				
				$tmp:=getKeyValue("nzptr.AU.institution.code"; "71108877050")
				$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
				
			: ([eWires:13]toCountryCode:112="NZ")
				
				$tmp:=getKeyValue("nzptr.NZ.institution.code"; "870")
				$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
				
				
			Else 
				$tmp:="*UNKOWN*"
				$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->$tmp; True:C214)
				
		End case 
		
		$dummy:="true"
		$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
		
		$element:=GAML_CreateXMLNode($nodeRef; "account"; ->[eWires:13]eWireID:1; True:C214)
		$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[eWires:13]BeneficiaryFullName:5; True:C214)
	End if 
	
	
Else 
	
	
	$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->reportingEntityName; True:C214)
	$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->reportingEntityID; True:C214)
	
	$dummy:="true"
	$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
	
	//$dummy:=getKeyValue ("nzptr.NZ.branch.account.name";"Manukau, Auckland")
	$dummy:=[Branches:70]BranchName:2+", "+[Branches:70]City:4
	$element:=GAML_CreateXMLNode($nodeRef; "branch"; ->$dummy; True:C214)
	
	$element:=GAML_CreateXMLNode($nodeRef; "account"; ->[Customers:3]CustomerID:1; True:C214)
	$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[Customers:3]FullName:40; True:C214)
	
	//$signatory:=GAML_CreateXMLNode ($nodeRef;"signatory")
	If ([Customers:3]isCompany:41)
		$t_to:=GAML_CreateXMLNode($nodeRef; "t_entity")
	Else 
		$signatory:=GAML_CreateXMLNode($nodeRef; "signatory")
		
		$dummy:="true"
		$element:=GAML_CreateXMLNode($signatory; "is_primary"; ->$dummy)
		
		$t_to:=GAML_CreateXMLNode($signatory; "t_person")
	End if 
	
	GAML_NodeT_PersonFromCustomer($t_to)
	
	
	
End if 

