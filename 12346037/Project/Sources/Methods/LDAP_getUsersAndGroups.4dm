//%attributes = {}
C_TEXT:C284($ldapServer; $dnSearchRootEntry; $filter)
C_OBJECT:C1216($adminUser)
C_LONGINT:C283($i)

$ldapServer:=LDAP_GetServerURL
$adminUser:=LDAP_GetAdminCredentials

If (LDAP_Login($ldapServer; $adminUser.userName; $adminUser.password))
	
	$dnSearchRootEntry:=LDAP_GetRootEntry
	
	ARRAY OBJECT:C1221($entries; 0)
	ARRAY TEXT:C222($attributes; 0)
	ARRAY BOOLEAN:C223($attributesAsArray; 0)
	
	APPEND TO ARRAY:C911($attributes; "cn")
	APPEND TO ARRAY:C911($attributesAsArray; False:C215)
	APPEND TO ARRAY:C911($attributes; "objectCategory")
	APPEND TO ARRAY:C911($attributesAsArray; False:C215)
	APPEND TO ARRAY:C911($attributes; "memberOf")
	APPEND TO ARRAY:C911($attributesAsArray; True:C214)
	APPEND TO ARRAY:C911($attributes; "member")
	APPEND TO ARRAY:C911($attributesAsArray; True:C214)
	APPEND TO ARRAY:C911($attributes; "distinguishedName")
	APPEND TO ARRAY:C911($attributesAsArray; False:C215)
	APPEND TO ARRAY:C911($attributes; "name")
	APPEND TO ARRAY:C911($attributesAsArray; False:C215)
	APPEND TO ARRAY:C911($attributes; "servicePrincipalName")
	APPEND TO ARRAY:C911($attributesAsArray; False:C215)
	APPEND TO ARRAY:C911($attributes; "sAMAccountName")
	APPEND TO ARRAY:C911($attributesAsArray; False:C215)
	
	$filter:=""
	
	LDAP SEARCH ALL:C1329($dnSearchRootEntry; $entries; $filter; LDAP all levels:K83:3; $attributes; $attributesAsArray)
	
	LDAP LOGOUT:C1327
	
	If ($entries#Null:C1517)
		
		Form:C1466.allEntries:=New collection:C1472
		Form:C1466.onlyUsers:=New collection:C1472
		Form:C1466.groups:=New collection:C1472
		
		For ($i; 1; Size of array:C274($entries))
			
			Form:C1466.allEntries.push($entries{$i})
			
			If ($entries{$i}.objectCategory#Null:C1517)
				
				If (Position:C15("CN=Group"; $entries{$i}.objectCategory)>0)
					Form:C1466.groups.push($entries{$i})
				End if 
				
				If (Position:C15("CN=Person"; $entries{$i}.objectCategory)>0)
					Form:C1466.onlyUsers.push($entries{$i})
				End if 
				
			End if 
			
		End for 
		
	End if 
	
Else 
	
	myAlert("Couldn't authenticate to LDAP server.")
	
End if 
