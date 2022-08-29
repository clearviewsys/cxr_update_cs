//%attributes = {}


C_LONGINT:C283($progress)
C_LONGINT:C283($i; $n; $j; $r; $pos; $len)
C_TEXT:C284($fileName; $backupFolder; $methodCode; $replacedCode; $obsPattern; $newPattern; $refPattern)
C_BLOB:C604($blobCode)
C_BOOLEAN:C305($obsFound; $isOK)
C_TEXT:C284($bkMethodCode; $phpFunctions; $type)

ARRAY TEXT:C222($arrCode; 0)
ARRAY TEXT:C222($arrFileNames; 0)
ARRAY TEXT:C222($arrMethodPaths; 0)
ARRAY TEXT:C222($arrObjects; 0)

ARRAY LONGINT:C221($arrPosFound; 0)
ARRAY LONGINT:C221($arrLengthFound; 0)

$r:=0
$backupFolder:=Get 4D folder:C485(Database folder:K5:14)+"bkMethods"+Folder separator:K24:12

If (Test path name:C476($backupFolder)#Is a folder:K24:2)
	CREATE FOLDER:C475($backupFolder; *)
End if 

$i:=1

METHOD GET PATHS:C1163(Path all objects:K72:16; $arrMethodPaths)
METHOD GET CODE:C1190($arrMethodPaths; $arrCode)

$obsPattern:="json_newObject"
$refPattern:=$obsPattern

$newPattern:="C_OBJECT(<var>)"

$phpFunctions:=Get 4D folder:C485(Current resources folder:K5:16)+"php"+Folder separator:K24:12+"CVS_PHP_Functions.php"


$n:=Size of array:C274($arrMethodPaths)
For ($i; 1; $n)
	
	If (Position:C15("_TEST_JSON_REPLACEMENT"; $arrMethodPaths{$i})>0)
		TRACE:C157
	End if 
	
	
	
	//refreshProgressBar($progress;$i;$n)
	$fileName:=$arrMethodPaths{$i}
	$fileName:=Replace string:C233($fileName; "/"; "-")
	$fileName:=Replace string:C233($fileName; "%"; "=")
	$fileName:=$fileName+".txt"
	
	// Do not allow empty file names
	
	SET BLOB SIZE:C606($blobCode; 0)
	
	$methodCode:=$arrCode{$i}
	$methodCode:=Replace string:C233($methodCode; "\r"; Char:C90(CR ASCII code:K15:14)+Char:C90(LF ASCII code:K15:11))
	
	//$p:=Position($refPattern;$methodCode)
	
	If ((Match regex:C1019($obsPattern; $methodCode; 1; $pos; $len)) & (Current method name:C684#$arrMethodPaths{$i}))
		
		$type:="json_newObject"
		$isOK:=PHP Execute:C1058($phpFunctions; "captureByRegExp"; $arrObjects; $methodCode; $type)
		$isOK:=True:C214
		
		If ($isOK)
			$bkMethodCode:=$methodCode
			//$methodCode:=Replace string($methodCode;$refPattern;$newPattern)
			
			If (Size of array:C274($arrObjects)=0)
				$r:=$r+1
				$methodCode:=Replace string:C233($methodCode; $refPattern; $newPattern)
				//TEXT TO BLOB($bkMethodCode;$blobCode;UTF8 text without length)
				//BLOB TO DOCUMENT($backupFolder+$fileName;$blobCode)
				//METHOD SET CODE($arrMethodPaths{$i};$methodCode)
				
				
			End if 
			
		End if 
		
	End if 
	
	MESSAGE:C88("Exporting source code ...  "+$fileName+" "+String:C10($i)+" of "+String:C10($n))
	
End for 

myAlert("Number of replacements of pattern \n"+$refPattern+" \nAre: "+String:C10($r))
SHOW ON DISK:C922($backupFolder)

