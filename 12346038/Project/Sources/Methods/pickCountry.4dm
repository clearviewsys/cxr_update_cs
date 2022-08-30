//%attributes = {}
C_POINTER:C301($1)
pickRecordForTable(->[Countries:62]; ->[Countries:62]CountryCode:1; $1)
$1->:=[Countries:62]CountryName:2


If ([Countries:62]isSanctioned:7)
	myAlert("This country is on the sanction list."+CRLF+[Countries:62]RiskDetail:6)
Else 
	If ([Countries:62]RiskLevel:5>=3)  // low:0; medium: 1; high:3
		myAlert("This country is on the high risk list."+CRLF+[Countries:62]RiskDetail:6)
	End if 
	
End if 
