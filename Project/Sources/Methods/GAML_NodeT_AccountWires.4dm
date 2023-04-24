//%attributes = {}
// GAML_NodeT_AccountWires


C_TEXT:C284($1; $nodeRef; $2; $type)

Case of 
	: (Count parameters:C259=2)
		$nodeRef:=$1
		$type:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($dummy; $element; $tmp; $gender; $signatory; $birthDate; $t_person; $to_account; $identification; $issueDate; $expDate; $countryCode; $t_to)

Case of 
	: ($type="from")
		
		If ([Wires:8]isOutgoingWire:16)
			
			$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->reportingEntityName; True:C214)
			$element:=GAML_CreateXMLNode($nodeRef; "institution_code"; ->reportingEntityID; True:C214)
			
			$dummy:="true"
			$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
			
			//$dummy:=getKeyValue ("nzptr.NZ.branch.account.name";"Manukau, Auckland")
			$dummy:=[Branches:70]BranchName:2+", "+[Branches:70]City:4
			$element:=GAML_CreateXMLNode($nodeRef; "branch"; ->$dummy; True:C214)
			
			$element:=GAML_CreateXMLNode($nodeRef; "account"; ->[Customers:3]CustomerID:1; True:C214)
			$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[Customers:3]FullName:40; True:C214)
			
			
			If ([Customers:3]isCompany:41)
				$t_to:=GAML_CreateXMLNode($nodeRef; "t_entity")
			Else 
				$signatory:=GAML_CreateXMLNode($nodeRef; "signatory")
				
				//$dummy:="true"
				//$element:=GAML_CreateXMLNode ($signatory;"is_primary";->$dummy)
				
				$t_to:=GAML_CreateXMLNode($signatory; "t_person")
			End if 
			
			GAML_NodeT_PersonFromCustomer($t_to)
			
			
		Else 
			
			
		End if 
		
	: ($type="to")
		
		
		If ([Wires:8]isOutgoingWire:16)
			
			$element:=GAML_CreateXMLNode($nodeRef; "institution_name"; ->[Wires:8]BeneficiaryBankName:3; True:C214)
			If ([Wires:8]BeneficiarySWIFT:28#"")
				$element:=GAML_CreateXMLNode($nodeRef; "swift"; ->[Wires:8]BeneficiarySWIFT:28; True:C214)
			Else 
				$dummy:="N/A"
				$element:=GAML_CreateXMLNode($nodeRef; "swift"; ->$dummy; True:C214)
			End if 
			
			
			$dummy:="false"
			$element:=GAML_CreateXMLNode($nodeRef; "non_bank_institution"; ->$dummy; True:C214)
			
			$tmp:=Replace string:C233([Wires:8]BeneficiaryAccountNo:9; "-"; "")
			$element:=GAML_CreateXMLNode($nodeRef; "account"; ->$tmp; True:C214)
			$element:=GAML_CreateXMLNode($nodeRef; "account_name"; ->[Wires:8]BeneficiaryFullName:10; True:C214)
		Else 
			
			
		End if 
		
		
End case 
