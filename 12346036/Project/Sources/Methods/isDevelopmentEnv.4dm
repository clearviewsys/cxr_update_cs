//%attributes = {"executedOnServer":true}

// isDevelopmentEnv
// Ask for a file next to the structure file, if exists is a develompent environment
// ----------------------------------------------------------------------------------------
// Execute only on SERVER SIDE
// ----------------------------------------------------------------------------------------


C_BOOLEAN:C305($0)
C_TEXT:C284($fileName)

$fileName:=Get 4D folder:C485(Database folder:K5:14)+"_IS_DEVELOPMENT_ENV.txt"
If (Test path name:C476($fileName)=Is a document:K24:1)
	$0:=True:C214
Else 
	$0:=False:C215
End if 


