//%attributes = {}
// compiles project

#DECLARE->$status : Object

$status:=Compile project:C1760

build_handleCompilerInfo($status)

If ($status.success)
	logLineInLogEvent("✅ Compilation success\n")
Else 
	logLineInLogEvent("‼️ Compilation failure\n")
End if 
