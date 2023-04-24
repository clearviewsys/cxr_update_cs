//%attributes = {}
// ftpUpload(sourcePath;destDirectory) ->success: boolean
// uses Miyako curl-ftp plugin for both FTP and SFTP

// #ORDA

C_TEXT:C284($sourcePath; $remotePath; $hostDirectory; $hostName; $userName; $password; $protocolPrefix; $ftpPort)
C_TEXT:C284($1; $2; $3; $4; $5)
C_BOOLEAN:C305($6; $OK; $useSFTP)

C_OBJECT:C1216($0; $status)

C_OBJECT:C1216($serverPrefs; $options; $localFileobj)

$OK:=False:C215
$serverPrefs:=ds:C1482.ServerPrefs.all().first()
$ftpPort:=""

$status:=New object:C1471("success"; True:C214; "status"; 0; "statusText"; "")

//FTP_Login (hostName;userName;password;ftp_ID{;welcomeText})Integer
//FTP_Progress (left;top;windowTitle;thermoText;CANCEL)Integer

C_LONGINT:C283(vFTP_ID; $error)
// ftpUpload (sourcePath; host directory; { hostName; username ; password }_
C_TEXT:C284(vFTP_Msg)


Case of 
	: (Count parameters:C259=0)
		$sourcePath:=getSupportFilesPath+c_PanelRatesInputFilename
		$hostDirectory:=[ServerPrefs:27]ftpUploadPath:41
		$hostName:=[ServerPrefs:27]ftpHostName:37
		$userName:=[ServerPrefs:27]ftpUserName:38
		$password:=[ServerPrefs:27]ftpPassword:39
		$useSFTP:=$serverPrefs.ftpUseSecure
		
	: (Count parameters:C259=1)
		$sourcePath:=$1
		$hostDirectory:=""
		$hostName:=<>ftpHostName
		$userName:=<>ftpUserName
		$password:=<>ftpPassword
		$useSFTP:=$serverPrefs.ftpUseSecure
		
	: (Count parameters:C259=2)
		$sourcePath:=$1
		$hostDirectory:=$2
		$hostName:=<>ftpHostName
		$userName:=<>ftpUserName
		$password:=<>ftpPassword
		$useSFTP:=$serverPrefs.ftpUseSecure
		
	: (Count parameters:C259=5)
		$sourcePath:=$1
		$hostDirectory:=$2
		$hostName:=$3
		$userName:=$4
		$password:=$5
		$useSFTP:=$serverPrefs.ftpUseSecure
		
	: (Count parameters:C259=6)
		$sourcePath:=$1
		$hostDirectory:=$2
		$hostName:=$3
		$userName:=$4
		$password:=$5
		$useSFTP:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If (Test path name:C476($sourcePath)=Is a document:K24:1)
	$hostDirectory:=strTrim($hostDirectory)  // trim leading and trailing spaces from remote path
	
	$localFileobj:=Path to object:C1547($sourcePath)
	
	// curl requires full path to local file, and FTP_Send form 4DIC commands also fails with filename only
	// so we are building full path according the documentation for FTP_Send command (if only filename is passed, the file should be 
	// in the same folder as database structure
	
	If ($localFileobj.parentFolder="")
		If (Application type:C494#4D Remote mode:K5:5)
			$localFileobj.parentFolder:=Get 4D folder:C485(Database folder:K5:14)
		Else 
			$localFileobj.parentFolder:=Get 4D folder:C485(4D Client database folder:K5:13)
		End if 
		$sourcePath:=$localFileobj.parentFolder+$sourcePath
	End if 
	
	
	//getKeyValueDescription 
	
	If ((getKeyValue("ftp.method"; "curl")="curl") | ($useSFTP))  // changed by #TB to be able to change the method of FTP to the new #curl implementation by #milan, #milan added check for ftpSecure, 4DIC doesn't support sftp
		
		If ($useSFTP)
			$protocolPrefix:="sftp://"
		Else 
			$protocolPrefix:="ftp://"
		End if 
		
		$options:=New object:C1471
		
		$options.USERNAME:=$userName
		$options.PASSWORD:=$password
		$options.SSL_VERIFYHOST:=0
		$options.SSL_VERIFYPEER:=0
		
		$options.FTP_RESPONSE_TIMEOUT:=Num:C11(getKeyValue("ftp.timeout"; String:C10(<>webTimeOut)))
		
		// check if we have to use non-standard port
		If ($serverPrefs.ftpPortNo#Null:C1517)
			If ($serverPrefs.ftpPortNo#0)
				// $options.FTPPORT:=$serverPrefs.ftpPort
				$ftpPort:=":"+String:C10($serverPrefs.ftpPortNo)
			End if 
		End if 
		
		// prepare $hostName and $hostDirectory to build correct URL without repeating "/" separators
		$hostName:=Replace string:C233($hostName; "/"; "")+$ftpPort+"/"
		If ($hostDirectory#"")
			If (Position:C15("/"; $hostDirectory)=1)
				$hostDirectory:=Substring:C12($hostDirectory; 2)
			End if 
			If (Length:C16($hostDirectory)>0)
				If ($hostDirectory[[Length:C16($hostDirectory)]]#"/")
					$hostDirectory:=$hostDirectory+"/"
				End if 
			End if 
			
			$options.URL:=$protocolPrefix+$hostName+$hostDirectory+$localFileobj.name+$localFileobj.extension
			
		Else 
			
			$options.URL:=$protocolPrefix+$hostName+$localFileobj.name+$localFileobj.extension
			
		End if 
		
		$error:=cURL_FTP_Send(JSON Stringify:C1217($options); $sourcePath)
		
		If ($error=0)
			//$0:=True
		Else 
			$status.success:=False:C215
			$status.status:=$error
			//$0:=False
		End if 
		
	Else 
		
		
		If (getKeyValue("ftp.method")="4DIC")  // #TB ; if the KeyValue ftp.method is 4DIC, CXR will use the 4D component to upload the rates 
			
			// old code using 4D IC commands
			checkInit
			$error:=FTP_Login($hostName; $userName; $password; vFTP_ID; vFTP_Msg)
			checkAddErrorIf($error>0; "FTP login failure "+String:C10($error))
			
			//9/16/19 IBB seems to be a bug with the following returning error 
			//$error:=FTP_Progress (-1;-1;"Progress window";"Sending file…";"Cancel")
			//checkAddErrorIf ($error#0;"Progress Stoped "+String($error))
			
			$error:=FTP_SetType(vFTP_ID; "A")  // set mode to ascii
			checkAddErrorIf($error#0; "Progress Stoped "+String:C10($error))
			
			If ($serverPrefs.ftpPort#Null:C1517)
				If ($serverPrefs.ftpPort#"")
					$error:=IT_SetPort(1; $serverPrefs.ftpPort)
					checkAddErrorIf($error#0; "Error setting FTP port "+String:C10($error))
				End if 
			End if 
			
			If ($hostDirectory#"")
				$remotePath:=$hostDirectory+$localFileobj.name+$localFileobj.extension
			Else 
				$remotePath:=""
			End if 
			
			If (Application type:C494=4D Server:K5:6)
				$error:=FTP_Send(vFTP_ID; $sourcePath; $remotePath; 0)
			Else 
				$error:=FTP_Send(vFTP_ID; $sourcePath; $remotePath; 1)
			End if 
			
			checkAddErrorIf($error#0; "Error in sending file "+String:C10($error))
			
			$error:=FTP_Logout(vFTP_ID)
			checkAddErrorIf($error#0; "Error in logout "+String:C10($error))
			
		End if 
		
		If (checkErrorExist)
			//myALERT(checkGetErrorString )
			//$0:=False
			$status.success:=False:C215
			$status.status:=-1
		Else 
			//$0:=True  // success
		End if 
		
	End if 
	
Else 
	$status.success:=False:C215
	$status.status:=-2
	$status.statusText:="Path not found: "+$sourcePath
End if 

$0:=$status
