C_OBJECT:C1216($group; $user; $localuser)
C_LONGINT:C283($i)
C_BOOLEAN:C305($addMe)

Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		Form:C1466.members:=New collection:C1472
		
		For each ($group; Form:C1466.selectedGroups)
			
			For each ($user; Form:C1466.onlyUsers)
				
				$addMe:=False:C215
				
				If ($group.member#Null:C1517)
					
					If ($group.member.length#Null:C1517)
						
						For ($i; 1; $group.member.length)
							If ($group.member[$i-1]=$user.distinguishedName)
								$addMe:=True:C214
							End if 
						End for 
						
					Else 
						
						If ($group.member=$user.distinguishedName)
							$addMe:=True:C214
						End if 
						
					End if 
					
					If ($addMe)
						
						$localuser:=ds:C1482.Users.query("UserName = :1"; $user.sAMAccountName).first()
						
						If ($localuser#Null:C1517)
							$user.inUsers:=True:C214
							$user.allowLDAP:=$localuser.isAllowedLDAPLogin
						Else 
							$user.inUsers:=False:C215
							$user.allowLDAP:=False:C215
						End if 
						
						Form:C1466.members.push($user)
						
					End if 
					
				End if 
				
			End for each 
			
		End for each 
		
End case 
