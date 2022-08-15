//%attributes = {}
// pickCountryCode (->field; {forceDialog})

C_POINTER:C301($1; $fieldPtr)
C_BOOLEAN:C305($2; $forceDialog)
C_POINTER:C301($3; $countryNamePtr)

C_TEXT:C284($0)


Case of 
	: (Count parameters:C259=1)
		$fieldPtr:=$1
		$forceDialog:=False:C215
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$forceDialog:=$2
	: (Count parameters:C259=3)
		$fieldPtr:=$1
		$forceDialog:=$2
		$countryNamePtr:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickRecordForTable(->[Countries:62]; ->[Countries:62]CountryCode:1; $fieldPtr; False:C215; $forceDialog)
If (OK=1)
	If ([Countries:62]isSanctioned:7)
		// Replaced on: 2/8/2017 - BY: CVS Dev. Team
		// myAlert ("This country is on the sanction list."+CRLF +[Countries]RiskDetail)
		myAlert(GetLocalizedErrorMessage(4008)+CRLF+[Countries:62]RiskDetail:6)
	Else 
		If ([Countries:62]RiskLevel:5>2)
			// Replaced on: 2/8/2017 - BY: CVS Dev. Team
			// myAlert ("This country is on the high risk list."+CRLF +[Countries]RiskDetail)
			myAlert(GetLocalizedErrorMessage(4009)+CRLF+[Countries:62]RiskDetail:6)
		End if 
	End if 
	$0:=[Countries:62]CountryCode:1
	If (Not:C34(Is nil pointer:C315($countryNamePtr)))
		$countryNamePtr->:=[Countries:62]CountryName:2
	End if 
	
End if 
