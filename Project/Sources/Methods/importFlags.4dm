//%attributes = {}
//Documentation for Open Documnet:
//https://doc.4d.com/4Dv15/4D/15.6/Open-document.301-3817272.en.html
//example uses C_TIME for the docRef variable
C_TIME:C306($vhDocRef)

setErrorTrap("importFlag")
READ ONLY:C145([Flags:19])
ALL RECORDS:C47([Flags:19])
If (Records in selection:C76([Flags:19])=0)
	C_BLOB:C604($project)
	C_TEXT:C284($path; $supportPath)
	
	//$supportpath:=getSupportFilesPath 
	//If ($path#"")
	//$path:=$supportpath+"importFlags.4si"
	//End if 
	$path:=Select folder:C670("Please select the root CurrencyXchanger folder")
	
	//$path:=Get 4D folder(Database Folder)
	$Supportpath:=$path+"CX_SupportFiles"+pathSeparator
	If (Test path name:C476($supportPath)#Is a folder:K24:2)
		//$path:=Select folder("Please locate CurrencyXchanger folder") //changed by Tiran on March 25th, 2012
		$Supportpath:=$path+"CX_SupportFiles"+pathSeparator
	End if 
	
	
	$vhDocRef:=Open document:C264($supportpath+"importFlags.4si")  // Select the document of your choice
	If (OK=1)  // If a document has been chosen
		CLOSE DOCUMENT:C267($vhDocRef)  // We don't need to keep it open
		DOCUMENT TO BLOB:C525(Document; $project)  // Load the document
		If (OK=0)
			myAlert("The 'flags.4DD' data file is mislocated")
			// Handle error
		Else 
			READ WRITE:C146([Flags:19])
			IMPORT DATA:C665($supportPath+"flags.4IE"; $project)
			READ ONLY:C145([Flags:19])
		End if 
	Else 
		myAlert(Current method name:C684+": Can't open "+$path)
	End if 
End if 

endErrorTrap

