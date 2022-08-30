//%attributes = {"publishedWeb":true}
// RecordLog (LoginID; CntxtID; IPnumber; LoginDate; LoginT; LogoutD; LogoutT) 
C_TEXT:C284($1)
C_TEXT:C284($2; $3)
C_DATE:C307($4; $6)
C_TIME:C306($5; $7)

CREATE RECORD:C68([WebAccessLog:16])
[WebAccessLog:16]loginID:1:=$1
[WebAccessLog:16]contextID:2:=$2
[WebAccessLog:16]IPNumber:3:=$3
[WebAccessLog:16]loginDate:4:=$4
[WebAccessLog:16]loginTime:5:=$5
[WebAccessLog:16]logoutDate:6:=$6
[WebAccessLog:16]logoutTime:7:=$7
SAVE RECORD:C53([WebAccessLog:16])