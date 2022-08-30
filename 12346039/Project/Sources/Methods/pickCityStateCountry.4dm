//%attributes = {}
// pickCityStateCountry(->city;->state;->countryCode;{->CountryName})
// 
C_BOOLEAN:C305(didPickRecentCity)
didPickRecentCity:=False:C215

C_POINTER:C301($cityPtr; $statePtr; $countryCodePtr; $countryNamePtr; $1; $2; $3; $4)
C_TEXT:C284($countryName)
$countryName:=""
READ ONLY:C145([Cities:60])
READ ONLY:C145([Countries:62])
READ ONLY:C145([States:61])


Case of 
		
	: (Count parameters:C259=3)
		$cityPtr:=$1
		$statePtr:=$2
		$countryCodePtr:=$3
		$countryNamePtr:=->$countryName
		
	: (Count parameters:C259=4)
		$cityPtr:=$1
		$statePtr:=$2
		$countryCodePtr:=$3
		$countryNamePtr:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($winRef)

ARRAY BOOLEAN:C223(arrCityStateCountry; 0)

$winRef:=Open form window:C675([CompanyInfo:7]; "pickCityStateCountry"; Plain window:K34:13; Horizontally centered:K39:1; Vertically centered:K39:4)
C_TEXT:C284(pick_vSearchText)
pick_vSearchText:=$cityPtr->

DIALOG:C40([CompanyInfo:7]; "pickCityStateCountry")

If (OK=1)
	
	If (didPickRecentCity)
		$cityPtr->:=[Cities:60]CityName:1
		$statePtr->:=[Cities:60]StateCode:2
		//$countryPtr->:=arrCountries{1}
		//QUERY([Countries];[Countries]CountryCode=)
		$countryCodePtr->:=[Countries:62]CountryCode:1
		$countryNamePtr->:=[Countries:62]CountryName:2
	Else 
		
		If (Size of array:C274(arrCities)>0)  // there has been a selection
			arrCities:=calcMax(1; arrCities)  // if the array is not selected then select the first item (at least pick the first)
			arrStates:=calcMax(1; arrStates)
			arrCountries:=calcMax(1; arrCountries)
			
			$cityPtr->:=arrCities{arrCities}
			$statePtr->:=arrStates{arrStates}
			//$countryPtr->:=arrCountries{1}
			
			QUERY:C277([Countries:62]; [Countries:62]CountryCode:1=arrCountries{arrCountries})
			$countryCodePtr->:=[Countries:62]CountryCode:1
			$countryNamePtr->:=[Countries:62]CountryName:2
			
		End if 
		
	End if 
End if 