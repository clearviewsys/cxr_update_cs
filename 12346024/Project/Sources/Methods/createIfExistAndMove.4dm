//%attributes = {}

C_TEXT:C284($1; $source; $2; $dest)
C_BOOLEAN:C305($3; $xcopy)
C_TEXT:C284($0; $cmd)

Case of 
	: (Count parameters:C259=2)
		
		$source:=$1
		$dest:=$2
		$xcopy:=False:C215
		
	: (Count parameters:C259=3)
		
		$source:=$1
		$dest:=$2
		$xcopy:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$cmd:="if exist "
$cmd:=$cmd+Char:C90(Double quote:K15:41)+$source+Char:C90(Double quote:K15:41)
$cmd:=$cmd+" ("+CRLF
If ($xcopy)
	$cmd:=$cmd+"    XCOPY /q /e /y "+Char:C90(Double quote:K15:41)+$source+Char:C90(Double quote:K15:41)+" "+Char:C90(Double quote:K15:41)+$dest+Folder separator:K24:12+getFileName($source)+Folder separator:K24:12+Char:C90(Double quote:K15:41)+CRLF
	$cmd:=$cmd+"    RMDIR /s /q "+Char:C90(Double quote:K15:41)+$source+Char:C90(Double quote:K15:41)+CRLF
Else 
	$cmd:=$cmd+"    MOVE /y "+Char:C90(Double quote:K15:41)+$source+Char:C90(Double quote:K15:41)+" "+Char:C90(Double quote:K15:41)+$dest+Char:C90(Double quote:K15:41)
	//$cmd:=$cmd+" && DEL "+Char(Double quote)+$source+Char(Double quote)+CRLF 
End if 

$cmd:=$cmd+CRLF+") "+CRLF
$0:=$cmd





