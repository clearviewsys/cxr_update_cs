//%attributes = {}
// compiles project

#DECLARE($compileOptions : Object)->$status : Object

If (Count parameters:C259=0)
	$status:=Compile project:C1760
Else 
	$status:=Compile project:C1760($compileOptions)
End if 

build_handleCompilerInfo($status)

If ($status.success)
	logLineInLogEvent("✅ Compilation successfull\n")
Else 
	logLineInLogEvent("‼️ Compilation failure\n")
End if 

