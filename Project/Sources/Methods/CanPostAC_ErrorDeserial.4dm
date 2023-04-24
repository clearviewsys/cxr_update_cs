//%attributes = {}
//author: Amir
//16th Feb 2020
//error deserializer for Canada Post Address Complete API
//converts xml error response to object
//returns boolean to indicate success
// Unit test is written
C_POINTER:C301($objectPtr; $1)
C_TEXT:C284($inputXml; $2)
C_BOOLEAN:C305($success; $0)

$objectPtr:=$1
$inputXml:=$2
ASSERT:C1129(Type:C295($objectPtr)=Is pointer:K8:14; "Expected pointer to object")
ASSERT:C1129(Type:C295($objectPtr->)=Is object:K8:27; "Expected pointer to object")
ASSERT:C1129(Type:C295($inputXml)=Is text:K8:3; "Expected text for input xml")

//example of correct error xml input:
//<NewDataSet>  
//  <Data>    
//  <Error>1003</Error>    
//  <Description>Country Invalid</Description>    
//  <Cause>The Country parameter was not recognised. Check the spelling and, if in doubt, use a valid ISO 2 or 3 digit country code.</Cause>    
//  <Resolution>Provide a valid ISO 2 or 3 digit country code or use a web service to convert country name to ISO code.</Resolution>  
//  </Data>
//</NewDataSet>

If ($inputXml#"")
	ON ERR CALL:C155("CanPostAC_handleError")
	$rootElement:=DOM Parse XML variable:C720($inputXml)
	endErrorTrap
	If (OK=1)
		C_TEXT:C284($rootElement; $subElement; $nextElement)
		$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data/Error")
		If (OK=1)
			$0:=True:C214
			C_TEXT:C284($errorCode; $errorDescription; $errorCause; $errorResolution)
			C_OBJECT:C1216($errorObj)
			
			$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data/Error")
			DOM GET XML ELEMENT VALUE:C731($subElement; $errorCode)
			
			$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data/Description")
			DOM GET XML ELEMENT VALUE:C731($subElement; $errorDescription)
			
			$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data/Cause")
			DOM GET XML ELEMENT VALUE:C731($subElement; $errorCause)
			
			$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data/Resolution")
			DOM GET XML ELEMENT VALUE:C731($subElement; $errorResolution)
			
			C_OBJECT:C1216($addressResultObj)
			$addressResultObj:=New object:C1471
			$addressResultObj.errorCode:=$errorCode
			$addressResultObj.errorDescription:=$errorDescription
			$addressResultObj.errorCause:=$errorCause
			$addressResultObj.errorResolution:=$errorResolution
			$objectPtr->:=$addressResultObj
			
		Else 
			$0:=False:C215  //input didnt have error tag
			
		End if 
		DOM CLOSE XML:C722($rootElement)
	Else 
		$0:=False:C215  //input was not a valid xml
	End if 
	
Else 
	$0:=False:C215  //input xml was empty string
	
End if 



