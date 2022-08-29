//%attributes = {}
// AU_UnzipPHP
// Uncompress a ZIP File

C_TEXT:C284($1; $src)  //Zip document (folder) FULL path name to uncompress
C_TEXT:C284($2; $dest)  //Folder where to put the uncompressed files and folders


Case of 
		
	: (Count parameters:C259=2)
		
		$src:=$1
		$dest:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($phpFunctions)
C_BOOLEAN:C305($isOk)

$phpFunctions:=Get 4D folder:C485(Current resources folder:K5:16)+"php"+Folder separator:K24:12+"CVS_PHP_Functions.php"

C_BOOLEAN:C305($isOk)
C_BOOLEAN:C305($result)

$isOK:=PHP Execute:C1058($phpFunctions; "unzip"; $result; $src; $dest)

$0:=$result
