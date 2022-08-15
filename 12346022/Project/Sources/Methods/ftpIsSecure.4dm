//%attributes = {}
// Not used, there is [ServerPrefs]ftpUseSecure field for this purpose

// method returns true if the host name in server FTP preferences begins with sftp or the port is 22
// that mean we have to use SFTP instead of FTP to upload

//C_BOOLEAN($0)
//C_TEXT($1;$hostName)
//C_LONGINT($2;$portNumber;$pos)

//$hostName:=$1
//$portNumber:=$2

//$0:=False

//If ($portNumber=22)

//$0:=True

//Else 

//$pos:=Position("sftp://";$hostName)

//If ($pos=1)
//$0:=True
//End if 

//End if 
