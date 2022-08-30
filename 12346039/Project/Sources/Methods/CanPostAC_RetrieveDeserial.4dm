//%attributes = {}
//author: Amir
//10th Feb 2020
//address details deserializer for Canada Post Address Complete API
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
ASSERT:C1129(Type:C295($errorObjPtr)=Is pointer:K8:14; "Expected pointer to store error object in")
ASSERT:C1129(Type:C295($errorObjPtr->)=Is object:K8:27; "Expected pointer to store error object in")

//example of correct input:
//<NewDataSet>
//<Data>
//<Id>CA | CP | B | 6372424</Id>
//<DomesticId>6372424</DomesticId>
//<Language>ENG</Language>
//<LanguageAlternatives>ENG,FRE</LanguageAlternatives>
//<Department/>
//<Company/>
//<SubBuilding/> ====> this is unit number
//<BuildingNumber>311</BuildingNumber> ======> this is street number
//<BuildingName/>
//<SecondaryStreet/>
//<Street>Pender St E</Street>
//<Block/>
//<Neighbourhood/>
//<District/>
//<City>Vancouver</City>
//<Line1>311 Pender St E</Line1>
//<Line2/>
//<Line3/>
//<Line4/>
//<Line5/>
//<AdminAreaName/>
//<AdminAreaCode/>
//<Province>BC</Province>
//<ProvinceName>British Columbia</ProvinceName>
//<ProvinceCode>BC</ProvinceCode>
//<PostalCode>V6A 1V1</PostalCode>
//<CountryName>Canada</CountryName>
//<CountryIso2>CA</CountryIso2>
//<CountryIso3>CAN</CountryIso3>
//<CountryIsoNumber>124</CountryIsoNumber>
//<SortingNumber1/>
//<SortingNumber2/>
//<Barcode/>
//<POBoxNumber/>
//<Label>311 Pender St E\nVANCOUVER BC V6A 1V1\nCANADA</Label>
//<Type>Residential</Type>
//<DataLevel>Premise</DataLevel>
//</Data>
//</NewDataSet>

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
			C_TEXT:C284($addressId; $addressDepartment; $addressCompany; $addressBuildingNumber; $addressUnitNumber)
			C_TEXT:C284($addressStreet; $addressCity; $addressLine1; $addressLine2; $addressProvinceName; $addressPostalCode)
			C_TEXT:C284($addressCountryName; $addressPoBoxNumber; $addressLabel; $addressType; $addressLanguage)
			C_TEXT:C284($countryIso2)
			C_OBJECT:C1216($addressResultObj)
			C_LONGINT:C283($i)
			$i:=1
			$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data[1]/Id")  //check if xml has even one record
			If (OK=1)
				$0:=True:C214
			End if 
			While (OK=1)
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Id")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressId)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Language")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressLanguage)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Department")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressDepartment)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Company")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressCompany)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/BuildingNumber")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressBuildingNumber)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/SubBuilding")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressUnitNumber)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Street")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressStreet)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/City")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressCity)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Line1")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressLine1)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Line2")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressLine2)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/ProvinceName")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressProvinceName)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/PostalCode")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressPostalCode)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/CountryName")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressCountryName)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/POBoxNumber")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressPoBoxNumber)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Label")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressLabel)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/Type")
				DOM GET XML ELEMENT VALUE:C731($subElement; $addressType)
				
				$subElement:=DOM Find XML element:C864($rootElement; "/NewDataSet/Data["+String:C10($i)+"]/CountryIso2")
				DOM GET XML ELEMENT VALUE:C731($subElement; $countryIso2)
				
				$addressResultObj:=New object:C1471
				$addressResultObj.id:=$addressId
				$addressResultObj.language:=$addressLanguage
				$addressResultObj.department:=$addressDepartment
				$addressResultObj.company:=$addressCompany
				$addressResultObj.buildingNumber:=$addressBuildingNumber
				$addressResultObj.unitNumber:=$addressUnitNumber
				$addressResultObj.street:=$addressStreet
				$addressResultObj.city:=$addressCity
				$addressResultObj.line1:=$addressLine1
				$addressResultObj.line2:=$addressLine2
				$addressResultObj.provinceName:=$addressProvinceName
				$addressResultObj.postalCode:=$addressPostalCode
				$addressResultObj.countryName:=$addressCountryName
				$addressResultObj.poBoxNumber:=$addressPoBoxNumber
				$addressResultObj.label:=$addressLabel
				$addressResultObj.type:=$addressType
				$addressResultObj.countryIso2:=$countryIso2
				
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