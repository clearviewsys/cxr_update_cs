//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tiran
// Date and time: 12/01/16, 11:37:02
// ----------------------------------------------------
// createDB_CodeRevisionsRecord (methodName;methodPath;sourceCode;subject;comments;reference)

// this method creates a line in the DB_CodeRevisions table
//


C_TEXT:C284($methodName; $methodPath; $sourceCode; $subject; $comments; $reference)
C_TEXT:C284($1; $2; $3; $4; $5; $6)


Case of 
	: (Count parameters:C259=6)
		$methodName:=$1
		$methodPath:=$2
		$sourceCode:=$3
		$subject:=$4
		$comments:=$5
		$reference:=$6
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

READ WRITE:C146([DB_CodeRevisions:103])
CREATE RECORD:C68([DB_CodeRevisions:103])
[DB_CodeRevisions:103]CommitMessage:2:=$subject
[DB_CodeRevisions:103]Comments:4:=$comments
[DB_CodeRevisions:103]Story:3:=$reference

[DB_CodeRevisions:103]SourceCode:5:=$sourceCode

[DB_CodeRevisions:103]CommitDate:8:=Current date:C33
[DB_CodeRevisions:103]CommitTime:9:=Current time:C178
[DB_CodeRevisions:103]Developer:10:=Current system user:C484
[DB_CodeRevisions:103]MethodName:11:=$methodName
[DB_CodeRevisions:103]MethodPath:12:=$methodPath

parseMethodPath($methodPath; ->[DB_CodeRevisions:103]TableNum:6; ->[DB_CodeRevisions:103]FormName:7; ->[DB_CodeRevisions:103]ObjectName:13)

[DB_CodeRevisions:103]version:14:=getCurrentVersion

SAVE RECORD:C53([DB_CodeRevisions:103])
//UNLOAD RECORD([DB_CodeRevisions])
READ ONLY:C145([DB_CodeRevisions:103])
