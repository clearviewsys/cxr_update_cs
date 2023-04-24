//%attributes = {}
// returns path to b2 executable file we use to access B2 bucket functionality via LAUNCH EXTERNAL PROCESS command

If (False:C215)
	
	C_TEXT:C284($0; $binaryPath)
	
	$binaryPath:=getFilePathByID("b2_binariesPath"; "")
	
	If (Is Windows:C1573)
		
		$binaryPath:=$binaryPath+"b2-windows.exe"
		
	Else 
		
		
		If (Is macOS:C1572)
			
			$binaryPath:=Convert path system to POSIX:C1106($binaryPath)+"b2-darwin"
			$binaryPath:=LEP_Escape($binaryPath)
			
		Else 
			
			// waiting for Linux version here
			
		End if 
		
	End if 
	
	$0:=$binaryPath
	
End if 

// returns path to where B2 binaries are located

C_TEXT:C284($0; $binaryPath; $binaryFileName)

//$binaryPath:=Get 4D folder(Current resources folder)

//If (Is Windows)
//$binaryPath:=$binaryPath+"b2-windows.exe"
//Else 
//If (Is macOS)
//$binaryPath:=Convert path system to POSIX($binaryPath)+"b2-darwin"
//Else 
//  // waiting for Linux version here
//End if 
//End if 

//$0:=$binaryPath

If (True:C214)
	
	$binaryPath:=getFilePathByID("b2_binariesPath"; "")
	
	If (getKeyValue("b2.usePython")="true")
		
		$binaryFileName:="b2"
		
	Else 
		
		If (Is Windows:C1573)
			
			// $binaryPath:=$binaryPath+"b2-windows.exe"
			$binaryFileName:="b2-windows.exe"
			
		Else 
			
			If (Is macOS:C1572)
				
				$binaryPath:=Convert path system to POSIX:C1106($binaryPath)
				$binaryFileName:="b2-darwin"
				
			Else 
				
				// waiting for Linux version here
				
			End if 
			
		End if 
		
	End if   // use Python app
	
	$binaryPath:=$binaryPath+$binaryFileName
	
End if 

$0:=$binaryPath

// $0:="/Library/Frameworks/Python.framework/Versions/3.10/bin/b2"  // python version path on El Capitan
