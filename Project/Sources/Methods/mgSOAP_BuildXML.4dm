//%attributes = {}
C_OBJECT:C1216($1; $credentials)  // we always have to include credentials in SOAP request body
C_TEXT:C284($2; $SOAP_Method; $argsPath; $bodyPath; $webPrefix)
C_OBJECT:C1216($3; $arguments)  // arguments for MoneyGram $SOAP_Method we are about to call
C_OBJECT:C1216($4; $soapPrefs)  // object holding paths and values for building XML payload
C_TEXT:C284($0; $root; $subelem; $name; $value)
C_LONGINT:C283($i)

$credentials:=$1
$SOAP_Method:=$2
$webPrefix:=""

$argsPath:=$SOAP_Method+"/"+"args"
$bodyPath:="/soap:Body/"+$argsPath

If (Count parameters:C259>2)
	$arguments:=$3
End if 

If (Count parameters:C259>3)
	$soapPrefs:=$4
Else 
	$soapPrefs:=mgSOAP_GetNameSpaces
End if 

If ($credentials#Null:C1517)
	
	$soapPrefs.root:="soap:Envelope"
	$soapPrefs.namespaceName1:="xmlns"
	
	$root:=DOM Create XML Ref:C861($soapPrefs.root; $soapPrefs.namespace; \
		"xmlns:xsi"; "http://www.w3.org/2001/XMLSchema-instance"; "xmlns:xsd"; "http://www.w3.org/2001/XMLSchema")
	
	If (OK=1)
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+"/soap:Body")
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+"/soap:Body/"+$SOAP_Method; $soapPrefs.namespaceName1; $soapPrefs.namespace1)
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath)
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"SystemId")
		DOM SET XML ELEMENT VALUE:C868($subelem; "mg")
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"Language")
		DOM SET XML ELEMENT VALUE:C868($subelem; "en")
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"LoginType")
		DOM SET XML ELEMENT VALUE:C868($subelem; "1")
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"PointCode")
		DOM SET XML ELEMENT VALUE:C868($subelem; $credentials.agentID)
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"UserLogin")
		DOM SET XML ELEMENT VALUE:C868($subelem; $credentials.username)
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"UserPassword")
		DOM SET XML ELEMENT VALUE:C868($subelem; $credentials.password)
		
		$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/"+$webPrefix+"Args")
		
		If ($arguments#Null:C1517)
			
			ARRAY TEXT:C222($properties; 0)
			OB GET PROPERTY NAMES:C1232($arguments; $properties)
			
			For ($i; 1; Size of array:C274($properties))
				If ($i=1)
					$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/Args/Field")
					$name:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/Args/Field/Name")
					$value:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/Args/Field/Value")
				Else 
					$subelem:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/Args/Field["+String:C10($i)+"]")
					$name:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/Args/Field["+String:C10($i)+"]"+"/Name")
					$value:=DOM Create XML element:C865($root; $soapPrefs.root+$bodyPath+"/Args/Field["+String:C10($i)+"]"+"/Value")
				End if 
				DOM SET XML ELEMENT VALUE:C868($name; $properties{$i})
				DOM SET XML ELEMENT VALUE:C868($value; $arguments[$properties{$i}])
			End for 
			
		End if 
		
		DOM EXPORT TO VAR:C863($root; $0)
		
		DOM CLOSE XML:C722($root)
		
	End if 
	
End if 
