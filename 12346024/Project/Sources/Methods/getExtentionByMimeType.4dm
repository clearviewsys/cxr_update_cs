//%attributes = {}
// GetCountryCode (countryName) : country Code
// this method uses constant arrays and doesn't search the table countries
// This method returns the country code based on the country name

// Unit test is written

C_TEXT:C284($1; $0; $extentionType; $MimeType)

C_LONGINT:C283($i)


Case of 
	: (Count parameters:C259=1)
		$MimeType:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($MimeTypeArr; 0)
ARRAY TEXT:C222($extentionTypeArr; 0)

populateMIMETypeDotExtArray(->$extentionTypeArr; ->$MimeTypeArr)
$i:=Find in array:C230($MimeTypeArr; $MimeType)
If ($i>0)
	$extentionType:=$extentionTypeArr{$i}
End if 

$0:=$extentionType