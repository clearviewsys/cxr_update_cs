//%attributes = {}
//Method to assign an expiry date returned fomr teh RAL getStatus endpoint to the companyInfo var. 
//Parameters: 
//Response (object): response object from getStatus endpoint
//oForm (object): form object for user company info screen, with pplication id

C_OBJECT:C1216($1; $response; $2; $oForm)

C_TEXT:C284($responseCode; $epochString; $dateString)
C_LONGINT:C283($licencesLength; $i; $start; $end)
C_REAL:C285($epochInt)
C_DATE:C307($date)

Case of 
	: (Count parameters:C259=2)
		$response:=$1
		$oForm:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$responseCode:=$response.code
If ($response.info#Null:C1517)
	If ($response.info.licenses#Null:C1517)
		$licencesLength:=$response.info.licenses.length
		$i:=0
		While ($i<$licencesLength)
			If ($response.info.licenses[$i].serviceId=$oForm.ApplicationID)
				If ($response.info.licenses[$i].serviceExpiryDate#Null:C1517)
					$dateString:=$response.info.licenses[$i].serviceExpiryDate
					
					If (Position:C15("Date"; $dateString)#0)
						$start:=Position:C15("e("; $dateString)
						$end:=Position:C15(")/"; $dateString)
						$epochString:=Substring:C12($response.info.licenses[$i].serviceExpiryDate; $start+2; $end-($start+2))
						$epochInt:=Num:C11($epochString)
						$oForm.LicenseExpiry:=epochToDate($epochInt)
					End if 
				Else 
					$oForm.LicenseExpiry:="N/A"
				End if 
				
			End if 
			$i:=$i+1
		End while 
	End if 
End if 




