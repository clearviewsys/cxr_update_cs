//%attributes = {}
// Builds user login array

C_BOOLEAN:C305($1; $useSSO)
C_BOOLEAN:C305($2; $useLDAP)

$useSSO:=False:C215
$useLDAP:=False:C215

If (Count parameters:C259>0)
	$useSSO:=$1
	If (Count parameters:C259>1)
		$useLDAP:=$2
	End if 
End if 

ARRAY TEXT:C222(arrUserNames; 0)

If ($useSSO)
	APPEND TO ARRAY:C911(arrUserNames; "Login using SSO")
Else 
	If ($useLDAP)
		QUERY:C277([Users:25]; [Users:25]isAllowedLDAPLogin:45=True:C214)
	Else 
		QUERY:C277([Users:25]; [Users:25]isInactive:18=False:C215)
	End if 
	ORDER BY:C49([Users:25]; [Users:25]UserName:3; >)
	SELECTION TO ARRAY:C260([Users:25]UserName:3; arrUserNames)
End if 

INSERT IN ARRAY:C227(arrUserNames; 1; 4)
arrUserNames{1}:="Designer"
arrUserNames{2}:="Administrator"
arrUserNames{3}:="Support"
arrUserNames{4}:="---------------------------"

If ($useSSO | $useLDAP)
	OBJECT SET VISIBLE:C603(*; "changePassword"; False:C215)
	OBJECT SET VISIBLE:C603(*; "forgetPassword"; False:C215)
Else 
	If (arrUserNames{arrUserNames}#"")
		OBJECT SET VISIBLE:C603(*; "changePassword"; True:C214)
		OBJECT SET VISIBLE:C603(*; "forgetPassword"; True:C214)
	End if 
End if 
