//%attributes = {}

C_TEXT:C284($userID; $1)
$userID:=$1
QUERY:C277([Privileges:24]; [Privileges:24]UserID:1=$userID)
//order by([Privileges];[Privileges]TableNo
orderByPrivileges
