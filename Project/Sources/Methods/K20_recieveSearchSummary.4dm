//%attributes = {}
// K20_recieveSearchSummary($catGroupName;$idFieldPtr;$name;{$address;$identifiction;$date})
// Author: Wai-Kin Chau

C_BOOLEAN:C305($0; $pass)
C_TEXT:C284($1; $catGroupName)
C_POINTER:C301($2; $idFieldPtr)
C_TEXT:C284($3; $name)
C_TEXT:C284($4; $address)
C_TEXT:C284($5; $identification)
C_DATE:C307($6; $date)

$catGroupName:=""
$name:=""
$address:=""
$identification:=""
$date:=nullDate

Case of 
	: (Count parameters:C259=3)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
	: (Count parameters:C259=4)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
		$address:=$4
	: (Count parameters:C259=5)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
		$address:=$4
		$identification:=$5
	: (Count parameters:C259=6)
		$catGroupName:=$1
		$idFieldPtr:=$2
		$name:=$3
		$address:=$4
		$identification:=$5
		$date:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($url)
$url:="https://api.kyc2020.com:8088/KYC2020/V2/SearchSummary"

C_OBJECT:C1216($content)
$content:=New object:C1471

OB SET:C1220($content; "APIKey"; getKeyValue("KYC2020.APIkey"))

OB SET:C1220($content; "Email"; getKeyValue("KYC2020.Email"))

OB SET:C1220($content; "CategoryCodeList"; "all")

If ($catGroupName#"")
	OB SET:C1220($content; "catGroupName"; $catGroupName)
End if 

OB SET:C1220($content; "Name"; $name)

If ($address#"")
	OB SET:C1220($content; "Address"; $address)
End if 

If ($identification#"")
	OB SET:C1220($content; "Identification"; $identification)
End if 

If ($date#nullDate)
	OB SET:C1220($content; "Date"; $date)
End if 

C_TEXT:C284($mustMatch)
$mustMatch:=getKeyValue("KYC2020.MustMatch"; "")
If ($mustMatch="")
	OB SET:C1220($content; "SearchType"; "1")
Else 
	OB SET:C1220($content; "SearchType"; "2")
	OB SET:C1220($content; "Mustmatch"; $mustMatch)
End if 

OB SET:C1220($content; "Query Count"; getKeyValue("KYC2020.QueryCount"; "100"))

C_TEXT:C284($responseType; $threshold)
$threshold:=getKeyValue("KYC2020.FilterThreshold"; "1")
OB SET:C1220($content; "userSrchPref_FilterThreshod"; $threshold)

$responseType:=getKeyValue("KYC2020.ResponseType"; "1")
OB SET:C1220($content; "response-type"; $responseType)

C_OBJECT:C1216($response)
$response:=New object:C1471
C_LONGINT:C283($statusCode)
$statusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)

$pass:=False:C215
If (OB Is defined:C1231($response; "status"))
	Case of 
		: ($response.status="ERROR")
			myAlert($response.reason; "KYC2020 Error")
		Else 
			
			If ($idFieldPtr#Null:C1517)
				CREATE RECORD:C68([KYC2020Log:159])
				[KYC2020Log:159]InternalTableID:5:=Table:C252($idFieldPtr)
				[KYC2020Log:159]InternalRecordID:6:=($idFieldPtr->)
				[KYC2020Log:159]Name:7:=$name
				[KYC2020Log:159]Address:8:=$address
				[KYC2020Log:159]Identification:9:=$identification
				[KYC2020Log:159]SignificantDate:10:=$date
				[KYC2020Log:159]CategoryGroupName:11:=$catGroupName
				[KYC2020Log:159]Response:14:=$response
				[KYC2020Log:159]MustMatch:4:=$mustMatch
				[KYC2020Log:159]FilterThreshold:15:=$threshold
				[KYC2020Log:159]ResponseType:16:=$responseType
				SAVE RECORD:C53([KYC2020Log:159])
			End if 
			$pass:=True:C214
	End case 
End if 

$0:=$pass