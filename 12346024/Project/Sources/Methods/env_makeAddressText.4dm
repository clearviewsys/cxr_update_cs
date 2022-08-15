//%attributes = {}
//Unit test written 

C_TEXT:C284($0; $Address; $City; $province; $PostalCode; $country; $1; $2; $3; $4; $5)



Case of 
	: (Count parameters:C259=5)
		$Address:=$1
		$City:=$2
		$Province:=$3
		$PostalCode:=$4
		$country:=$5
	Else 
		$Address:=[Customers:3]Address:7
		$City:=[Customers:3]City:8
		$Province:=[Customers:3]Province:9
		$PostalCode:=[Customers:3]PostalCode:10
		$country:=[Customers:3]Country_obs:11
End case 

$0:=toTitleCase(->$Address)+CRLF
$0:=$0+toTitleCase(->$City)+appendStringIfSucceded(", "; Uppercase:C13($Province))
$0:=$0+appendStringIfSucceded(", "; Uppercase:C13($PostalCode))+appendStringIfSucceded(", "; toTitleCase(->$country))
