Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		C_OBJECT:C1216($versionObject)
		C_POINTER:C301($build; $majorVersion)
		
		$majorVersion:=OBJECT Get pointer:C1124(Object named:K67:5; "majorVersion")
		$build:=OBJECT Get pointer:C1124(Object named:K67:5; "build")
		
		$versionObject:=getVersions  // get information from JSON file in Resources folder
		
		If ($versionObject#Null:C1517)
			$build->:="build: "+String:C10($versionObject.buildNumber)
			// $majorVersion->:="Version: "+$versionObject.version
			$majorVersion->:=$versionObject.version
		Else 
			$build->:="build: "+getBuild
			$majorVersion->:="Version: "+getMajorVersion
		End if 
		
End case 
