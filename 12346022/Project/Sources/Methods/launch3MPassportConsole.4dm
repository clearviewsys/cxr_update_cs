//%attributes = {}
// lauch3MPassportConsole (filename; isPassport:bool)


C_TEXT:C284($commandPath; $input; $output; $filename; $xmlPath; $scanFolderPath; $1; $xmlFolderPath)
C_BOOLEAN:C305($isPassport; $0)

$isPassport:=True:C214

Case of 
	: (Count parameters:C259=0)
		$filename:=Request:C163("Name of file"; "Scan")
		$isPassport:=True:C214
	: (Count parameters:C259=1)
		$filename:=$1
		$isPassport:=True:C214
		
	Else 
		$filename:=$1
		$isPassport:=$2
End case 


$commandPath:=getFilePathByID("3M Scanner:ConsoleFolder")
$scanFolderPath:=getFilePathByID("3M Scanner:ScanFolder")
$xmlFolderPath:=getFilePathByID("3M Scanner:XMLFolder")


//Usage: QPassportConsoleApplication.exe -img outputImagePath [-xml xmlOutputPath]

If (($commandPath="") | ($scanFolderPath="") | ($xmlFolderPath=""))
	myAlert("Make sure to define all three 3M Scanner properties in FilePaths.")
	displayListFilePaths
	
Else 
	
	If (Is Windows:C1573)  // windows only
		$commandPath:=$commandPath+"QPassportConsoleApplication.exe -img "+$scanFolderPath+$filename
		
		
		If ($isPassport=True:C214)  // add the additional parameter to save the XML file
			$commandPath:=$commandPath+" -xml "+$xmlFolderPath+$filename+".xml"
		End if 
		
		LAUNCH EXTERNAL PROCESS:C811($commandPath; $input; $output)
	Else 
		myAlert("This Scanner console is only availabe on Windows platform.")
	End if 
	
End if 