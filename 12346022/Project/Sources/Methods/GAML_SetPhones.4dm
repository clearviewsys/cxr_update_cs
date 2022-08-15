//%attributes = {}
// GAML_SetPhones
C_TEXT:C284($1; $node)
C_POINTER:C301($2; $ptrWorkTel; $3; $ptrHomeTel)
C_TEXT:C284($nullPhone; $phone)
C_TEXT:C284($phones; $phone1; $contactType; $commType; $phone2)
C_POINTER:C301($ptrCellPhone)

$nullPhone:=""

Case of 
	: (Count parameters:C259=1)
		$node:=$1
		$ptrHomeTel:=->[Customers:3]HomeTel:6
		$ptrCellPhone:=->[Customers:3]CellPhone:13
		$ptrWorkTel:=->[Customers:3]WorkTel:12
		
	: (Count parameters:C259=2)
		$node:=$1
		$ptrHomeTel:=$2
		$ptrCellPhone:=->$nullPhone
		$ptrWorkTel:=->$nullPhone
		
	: (Count parameters:C259=3)
		$node:=$1
		$ptrHomeTel:=$2
		$ptrCellPhone:=$3
		$ptrWorkTel:=->$nullPhone
		
	: (Count parameters:C259=4)
		$node:=$1
		$ptrHomeTel:=$2
		$ptrCellPhone:=$3
		$ptrWorkTel:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


// Main Phone/Land Line: HomeTel, Cell: CellPhone, WorkPhone: WorkTel

If ($ptrHomeTel->#"")
	$phones:=GAML_CreateXMLNode($node; "phones")
	$phone:=GAML_CreateXMLNode($phones; "phone")
	
	$contactType:="L"  // I-Home Adress, S-Work
	$commType:="B"  // B-Landline phone, C-Mobile Phone
	GAML_SetPhone($phone; $contactType; $commType; $ptrHomeTel->)
Else 
	
	If ($ptrCellPhone->#"")
		$phones:=GAML_CreateXMLNode($node; "phones")
		$phone:=GAML_CreateXMLNode($phones; "phone")
		
		$contactType:="L"  // I-Home Adress, S-Work
		$commType:="C"  // C-Mobile Phone, B-Landline phone
		GAML_SetPhone($phone; $contactType; $commType; $ptrCellPhone->)
	Else 
		
		If ($ptrWorkTel->#"")
			$phones:=GAML_CreateXMLNode($node; "phones")
			$phone:=GAML_CreateXMLNode($phones; "phone")
			
			$contactType:="L"  // I-Home Adress, S-Work
			$commType:="B"  // C-Mobile Phone, B-Landline phone
			GAML_SetPhone($phone; $contactType; $commType; $ptrWorkTel->)
		End if 
		
		
	End if 
	
End if 



If (False:C215)
	
	If (($ptrWorkTel->#"") & ($ptrHomeTel->#""))
		
		$phones:=GAML_CreateXMLNode($node; "phones")
		$phone1:=GAML_CreateXMLNode($phones; "phone")
		
		$contactType:="L"  // I-Home Adress, S-Work
		$commType:="B"  // C-Mobile Phone, B-Landline phone
		GAML_SetPhone($phone1; $contactType; $commType; $ptrWorkTel->)
		
		//$phone2:=GAML_CreateXMLNode ($phones;"phone")
		
		//$contactType:="I"  // I-Home Adress, S-Work
		//$commType:="B"  // C-Mobile Phone, B-Landline phone
		//GAML_SetPhone ($phone2;$contactType;$commType;$ptrHomeTel->)
		
	Else 
		
		If ($ptrWorkTel->#"")
			$phones:=GAML_CreateXMLNode($node; "phones")
			$phone1:=GAML_CreateXMLNode($phones; "phone")
			
			$contactType:="-"  // I-Home Adress, S-Work
			$commType:="-"  // C-Mobile Phone, B-Landline phone
			GAML_SetPhone($phone1; $contactType; $commType; $ptrWorkTel->)
		Else 
			
			
		End if 
		
		
	End if 
	
End if 
