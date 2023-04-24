//%attributes = {}
// signTopaz (->picturePtr): bool
// launches an external process to open the Topaz application signature
// the result will be returned in the picturePtr 
// returns true on successful reading of the picture

C_POINTER:C301($signaturePtr)
C_TEXT:C284($applicationPath; $imagePath)
C_BOOLEAN:C305($success; $0)
// getKeyValueDescription

Case of 
	: (Count parameters:C259=1)
		$signaturePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34(Is nil pointer:C315($signaturePtr)))
	$success:=True:C214  // assuming it will work
	
	
	If (getKeyValue("topaz.active"; "false")="true")
		$applicationPath:=getFilePathByID("Topaz.applicationPath")
		$imagePath:=getFilePathByID("Topaz.signaturePath")
		
		If ($applicationPath="")
			myAlert("FilePath key/value must be defined for Topaz.applicationPath")
		End if 
		
		If ($imagePath="")
			myAlert("FilePath key/value must be defined for Topaz.signaturePath")
		End if 
		
		If (isPathValid($imagePath))
			DELETE DOCUMENT:C159($imagePath)
		Else 
			myAlert("Invalid image path <X> for signature file!"; "Invalid filepath"; $imagePath)
		End if 
		
		If (isPathValid($applicationPath))
			LAUNCH EXTERNAL PROCESS:C811($applicationPath+" "+$imagePath)
		Else 
			myAlert("Cannot find Topaz application here: <X>"; "Invalid filepath"; $applicationPath)
		End if 
		
		
		C_LONGINT:C283($i)
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 10)
			$i:=$i+1
		Until (isPathValid($imagePath) | ($i=100))  // we need to wait until the file is written by the Topaz application
		
		If (openPicture($signaturePtr; $imagePath))
			If (Picture size:C356($signaturePtr->)>0)
				displayPicture($signaturePtr)
			End if 
		End if 
		
	Else 
		myAlert("Key Value for Topaz.active is not set!")
		$success:=False:C215
	End if 
Else   // nil pointer
	$success:=False:C215
End if 

$0:=$success
