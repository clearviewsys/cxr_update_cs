

If (Form event code:C388=On Load:K2:1)
	setFieldAsPassword(OBJECT Get pointer:C1124(Object named:K67:5; "password"))
	Form:C1466.bidwid:=(getBranchID+" - "+getCurrentMachineName)
	
	If (False:C215)
		READ ONLY:C145([Users:25])
		QUERY:C277([Users:25]; [Users:25]isInactive:18=False:C215)
		ORDER BY:C49([Users:25]; [Users:25]UserName:3; >)
		//SELECTION TO ARRAY([Users]UserName; Form.usernames)
		INSERT IN ARRAY:C227(Form:C1466.usernames; 1; 4)
		//Form.usernames{1}:="Designer"
		//Form.usernames{2}:="Administrator"
		//Form.usernames{3}:="Support"
		//Form.usernames{4}:="___________________________"
		
		//If (Records in selection([Users])=1)
		//arrUsernames:=1
		//vUserName:=arrUserNames{arrUserNames}
		//user_handleUserNameMethod 
		//End if 
		
	Else 
		
		// new code with support for SSO and LDAP
		//loginBuildUserNamesArray(LDAP_useSSO; LDAP_useLDAP)
		
	End if 
	
	BRING TO FRONT:C326(Current process:C322)
	
	SET TIMER:C645(60)
	
End if 

hideObjectsOnTrue(Not:C34(Caps lock down:C547); "capslock")
//"UsersLogin"