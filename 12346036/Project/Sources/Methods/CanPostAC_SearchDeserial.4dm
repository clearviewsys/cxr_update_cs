//%attributes = {}
//author: Amir
//21st Jan 2020
//address deserializer for Canada Post Address Complete API
//converts xml result set of search to aray of objects 
//returns boolean to indicate success

// Unit test is written

C_POINTER:C301($objectArrayPtr; $1)
C_TEXT:C284($inputXml; $2)
C_POINTER:C301($errorObjPtr; $3)
C_BOOLEAN:C305($success; $0)

$objectArrayPtr:=$1
$inputXml:=$2
$errorObjPtr:=$3

ASSERT:C1129(Type:C295($objectArrayPtr)=Is pointer:K8:14; "Expected pointer to array of objects")
ASSERT:C1129(Type:C295($objectArrayPtr->)=Object array:K8:28; "Expected pointer to array of objects")
ASSERT:C1129(Type:C295($inputXml)=Is text:K8:3; "Expected text for input xml")
ASSERT:C1129(Type:C295($errorObjPtr)=Is pointer:K8:14; "Expected pointer to object to store error in")
ASSERT:C1129(Type:C295($errorObjPtr->)=Is object:K8:27; "Expected pointer to object to store error in")

//example of correct input:
//<NewDataSet>
//    <Data>
//        <Id>CA | CP | B | 6372424</Id>
//        <Text>311 Pender St E</Text>
//        <Highlight>0-3,4-10</Highlight>
//        <Cursor>0</Cursor>
//        <Description>Vancouver, BC, V6A 1V1</Description>
//        <Next>Retrieve</Next>
//    </Data>

If ($inputXml#"")
	ON ERR CALL:C155("CanPostAC_handleError")
	$rootElement:=DOM Parse XML variable:C720($inputXml)
	endErrorTrap
	If (OK=1)
		C_TEXT:C284($rootElement; $subElement; $nextElement)
		$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data/Error")
		If (OK=1)
			C_BOOLEAN:C305($errorDeserialSuccess)
			$errorDeserialSuccess:=CanPostAC_ErrorDeserial($errorObjPtr; $inputXml)
			If ($errorDeserialSuccess=False:C215)
				$errorObjPtr->:=New object:C1471("errorCause"; "Error response parse error"; "errorDescription"; "API of Canada Post returned an error. We encountered error parsing that response.")
			End if 
			$0:=False:C215
		Else 
			C_TEXT:C284($addressId; $addressText; $addressDescription; $addressNextAction)
			C_OBJECT:C1216($addressResultObj)
			C_LONGINT:C283($i)
			$i:=1
			$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data[1]/Id")  //check if xml has even one record
			If (OK=1)
				$0:=True:C214
			Else 
				$errorObjPtr->:=New object:C1471("errorCause"; "Search response parse error"; "errorDescription"; "API of Canada Post returned an xml that didn't have any records")
			End if 
			While (OK=1)
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Id")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressId)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Text")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressText)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Description")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressDescription)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Next")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressNextAction)
				
				$addressResultObj:=New object:C1471
				$addressResultObj.id:=$addressId
				$addressResultObj.text:=$addressText
				$addressResultObj.description:=$addressDescription
				$addressResultObj.action:=$addressNextAction
				APPEND TO ARRAY:C911($objectArrayPtr->; $addressResultObj)
				
				$i:=$i+1
				$nextElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]")
			End while 
			
			
		End if 
		DOM CLOSE XML:C722($rootElement)
	Else 
		$errorObjPtr->:=New object:C1471("errorCause"; "Search response parse error"; "errorDescription"; "API of Canada Post returned an invalid xml that we couldn't parse")
		$0:=False:C215  //input was not a valid xml
	End if 
	
Else 
	$0:=False:C215  //input xml was empty string
	
End if 

