//%attributes = {}
C_TEXT:C284($abbr; $IDType; $country; $state; $authority; $govCode)
C_DATE:C307($expDate; $issueDate)
C_POINTER:C301($objPtr)

$issueDate:=!00-00-00!
$expDate:=!00-00-00!

pickPictureIDType(->$abbr; ->$objPtr; ->$IDType; ->$country; ->$state; ->$authority; ->$issueDate; ->$expDate; ->$govCode)

myAlert($abbr+CRLF+$IDType+CRLF+$country+CRLF+$state+CRLF+$authority+CRLF+String:C10($issueDate)+CRLF+String:C10($expDate)+CRLF+$govCode)
