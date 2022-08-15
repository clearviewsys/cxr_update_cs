//%attributes = {}
C_TEXT:C284($0; $domain; $1; $email)
C_LONGINT:C283($idx; $len; $afna)
C_BOOLEAN:C305($found)

ASSERT:C1129(Count parameters:C259>0)

$email:=$1
$domain:=""
$found:=False:C215

$len:=Length:C16($email)
$afna:=Character code:C91("@")

$idx:=$len

While (($idx>0) & (Not:C34($found)))
	
	If ($email[[$idx]]#">")  // if email is within < and >
		$domain:=$email[[$idx]]+$domain
		If (Character code:C91($email[[$idx]])=$afna)
			$found:=True:C214
		End if 
	End if 
	
	$idx:=$idx-1
	
End while 

If ($found)
	$0:=$domain
Else 
	$0:=""
End if 
