//%attributes = {"publishedWeb":true}

C_TEXT:C284($1; $path)

C_TEXT:C284($0; $result)

C_TEXT:C284($root)
C_BLOB:C604($xBlob)

$path:=$1
$result:=""

If (Substring:C12($path; 1; 1)="/")
	$path:=Substring:C12($path; 2; Length:C16($path))
End if 

$root:=Get 4D folder:C485(Database folder UNIX syntax:K5:15)
$path:=$root+$path
$path:=Convert path POSIX to system:C1107($path)

If (Test path name:C476($path)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($path; $xBlob)
	$result:=BLOB to text:C555($xBlob; UTF8 text without length:K22:17)
End if 

$0:=Char:C90(1)+$result