//%attributes = {}
// method is not used anymore

//C_TEXT($1;$2;$3;$4;$5)
//C_TEXT($sourcePath;$hostDirectory;$hostName;$userName;$password;$protocolPrefix)
//C_BOOLEAN($0)
//C_OBJECT($options;$localFileobj;$serverPrefs)
//C_LONGINT($error)

//Case of 
//: (Count parameters=1)
//$sourcePath:=$1
//$hostDirectory:=""
//$hostName:=<>ftpHostName
//$userName:=<>ftpUserName
//$password:=<>ftpPassword
//: (Count parameters=2)
//$sourcePath:=$1
//$hostDirectory:=$2
//$hostName:=<>ftpHostName
//$userName:=<>ftpUserName
//$password:=<>ftpPassword
//: (Count parameters=5)
//$sourcePath:=$1
//$hostDirectory:=$2
//$hostName:=$3
//$userName:=$4
//$password:=$5
//Else 
//$sourcePath:=getSupportFilesPath +c_PanelRatesInputFilename 
//$hostDirectory:=[ServerPrefs]ftpUploadPath+c_PanelRatesInputFilename 
//$hostName:=[ServerPrefs]ftpHostName
//$userName:=[ServerPrefs]ftpUserName
//$password:=[ServerPrefs]ftpPassword
//End case 

//$localFileobj:=Path to object($sourcePath)

//$serverPrefs:=ds.ServerPrefs.all().first()

//If ($serverPrefs.ftpUseSecure)
//$protocolPrefix:="sftp://"
//Else 
//$protocolPrefix:="ftp://"
//End if 

//$options:=New object

//$options.USERNAME:=$userName
//$options.PASSWORD:=$password
//$options.SSL_VERIFYHOST:=0
//$options.SSL_VERIFYPEER:=0
//If ($serverPrefs.ftpPort#"")
//$options.PORT:=$serverPrefs.ftpPort#""
//End if 

//If ($hostDirectory#"")
//$options.URL:=$protocolPrefix+$hostName+"/"+$hostDirectory+"/"+$localFileobj.name+$localFileobj.extension
//Else 
//$options.URL:=$protocolPrefix+$hostName+"/"+$localFileobj.name+$localFileobj.extension
//End if 

//$error:=cURL_FTP_Send (JSON Stringify($options);$sourcePath)

//If ($error=0)
//$0:=True
//Else 
//$0:=False
//End if 
