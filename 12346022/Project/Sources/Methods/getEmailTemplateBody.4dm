//%attributes = {}

C_TEXT:C284($1; $template)
C_POINTER:C301($2; $ptrTable)
C_TEXT:C284($3; $message)  //parameter to be passed to Process 4D Tags

C_TEXT:C284($0; $html)

C_BLOB:C604($xBlob)
C_TEXT:C284($path; $tableName)


$template:=$1

If (Count parameters:C259>=2)
	$ptrTable:=$2
Else 
	//null pointer
End if 

If (Is nil pointer:C315($ptrTable))
	$tableName:=""
Else 
	$tableName:=Table name:C256($ptrTable)
End if 

If (Count parameters:C259>=3)
	$message:=$3
Else 
	$message:=""
End if 

$html:=""

If (True:C214)
	$xBlob:=getEmailTemplateFromServer($template)
	
	If (BLOB size:C605($xBlob)>0)
		$html:=BLOB to text:C555($xBlob; UTF8 text without length:K22:17)
		PROCESS 4D TAGS:C816($html; $html; $message)
	Else 
		$html:=""
	End if 
	
Else 
	$path:=""
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"email-templates"+Folder separator:K24:12+"custom"+Folder separator:K24:12+$template
	
	If (Test path name:C476($path)=Is a document:K24:1)  //all good we have a custom template
	Else   //get a default template
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"email-templates"+Folder separator:K24:12+$template
	End if 
	
	If (Test path name:C476($path)=Is a document:K24:1)
	Else   //see if a "custom default" is config'd
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"email-templates"+Folder separator:K24:12+"custom"+Folder separator:K24:12+Replace string:C233($template; $tableName; "default")
	End if 
	
	If (Test path name:C476($path)=Is a document:K24:1)
	Else   //see if a " default" is config'd
		$path:=Get 4D folder:C485(Current resources folder:K5:16)+"email-templates"+Folder separator:K24:12+Replace string:C233($template; $tableName; "default")
	End if 
	
	If (Test path name:C476($path)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($path; $xBlob)
		$html:=BLOB to text:C555($xBlob; UTF8 text without length:K22:17)
		PROCESS 4D TAGS:C816($html; $html; $message)
	Else 
		$html:=""
	End if 
End if 

$0:=$html