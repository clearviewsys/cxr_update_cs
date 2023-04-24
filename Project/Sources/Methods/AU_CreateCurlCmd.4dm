//%attributes = {}
// AU_CreateCurlCmd ($url;$destPath)
C_TEXT:C284($0; $1; $url; $2; $destPath)

Case of 
		
	: (Count parameters:C259=0)
		// Just for testing
		$url:=setKeyValue("au.url.update.latestversion"; "www.clearviewsys.com/updates/CXR/LatestVersion.zip")
		$destPath:=getFilePathByID("au.download.path")
		
	: (Count parameters:C259=2)
		$url:=$1
		$destPath:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($cmd)

If (Is Windows:C1573)
	$cmd:=Char:C90(Double quote:K15:41)+Get 4D folder:C485(Database folder:K5:14)+"Commands"+Folder separator:K24:12+"curl"+Folder separator:K24:12+"bin"+Folder separator:K24:12+"curl.exe "+Char:C90(Double quote:K15:41)
	$cmd:=Char:C90(Double quote:K15:41)+Folder separator:K24:12+"curl.exe "+Char:C90(Double quote:K15:41)
Else 
	$cmd:=Char:C90(Double quote:K15:41)+"/usr/bin/curl "+Char:C90(Double quote:K15:41)
End if 

$cmd:=$cmd+" --silent --show-error --retry-delay 30 --retry 2 --url "+$url+" -o "+$destPath
$0:=$cmd

