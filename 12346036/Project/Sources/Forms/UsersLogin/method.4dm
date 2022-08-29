C_PICTURE:C286(vPicture)
C_TEXT:C284(vUserName; vPassword)
C_LONGINT:C283(vCountTries)

If (Form event code:C388=On Load:K2:1)
	clearPictureField(->vPicture)
	vUserName:=""
	vPassword:=""
	vCountTries:=0
	setFieldAsPassword(->vPassword)
	OBJECT SET TITLE:C194(*; "bidWid"; getBranchID+" - "+getCurrentMachineName)
	
	If (False:C215)
		ARRAY TEXT:C222(arrUserNames; 0)
		QUERY:C277([Users:25]; [Users:25]isInactive:18=False:C215)
		ORDER BY:C49([Users:25]; [Users:25]UserName:3; >)
		SELECTION TO ARRAY:C260([Users:25]UserName:3; arrUserNames)
		INSERT IN ARRAY:C227(arrUserNames; 1; 4)
		arrUserNames{1}:="Designer"
		arrUserNames{2}:="Administrator"
		arrUserNames{3}:="Support"
		arrUserNames{4}:="---------------------------"
		
		//If (Records in selection([Users])=1)
		//arrUsernames:=1
		//vUserName:=arrUserNames{arrUserNames}
		//user_handleUserNameMethod 
		//End if 
		
	Else 
		
		// new code with support for SSO and LDAP
		loginBuildUserNamesArray(LDAP_useSSO; LDAP_useLDAP)
		
	End if 
	
	BRING TO FRONT:C326(Current form window:C827)
	
	SET TIMER:C645(60)
	
End if 

hideObjectsOnTrue(Not:C34(Caps lock down:C547); "capslock")
