//%attributes = {}
// IdentityMind_testName($testId)
// Gets a human readable test name for the id
//
// Paramters:
// $testId (C_Text)
//    the name of the id
//
// Return: 
//    the name of the test id

C_TEXT:C284($1; $testId)
C_TEXT:C284($0)  // name of the test

Case of 
	: (Count parameters:C259=1)
		$testId:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

C_TEXT:C284($path)
C_TIME:C306($refDoc)
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"testNames.txt"
//C_DocRef($refDoc)
$refDoc:=Open document:C264($path; "TEXT"; Read mode:K24:5)

ARRAY TEXT:C222($testIds; 0)
ARRAY TEXT:C222($testNames; 0)
If (OK=1)
	Repeat 
		C_TEXT:C284($mappedId)
		RECEIVE PACKET:C104($refDoc; $mappedId; Char:C90(Tab:K15:37))
		APPEND TO ARRAY:C911($testIds; $mappedId)
		
		C_TEXT:C284($mappedName)
		RECEIVE PACKET:C104($refDoc; $mappedName; Char:C90(Line feed:K15:40))
		APPEND TO ARRAY:C911($testNames; $mappedName)
	Until (OK=0)
End if 

CLOSE DOCUMENT:C267($refDoc)

ASSERT:C1129(Size of array:C274($testIds)>0; "Empty Test ID")
ASSERT:C1129(Size of array:C274($testNames)>0; "Empty Test Names")

C_REAL:C285($index)
$index:=Find in array:C230($testIds; $testId)
If ($index>0)
	$0:=$testNames{$index}
Else 
	$0:=""
End if 