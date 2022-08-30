//%attributes = {"executedOnServer":true}


C_TEXT:C284($1; $template; $path; $tableName)

C_BLOB:C604($0; $xBlob)


$template:=$1


$path:=""

// IS THERE A CUSTOM TEMPLATE
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
End if 


$0:=$xBlob