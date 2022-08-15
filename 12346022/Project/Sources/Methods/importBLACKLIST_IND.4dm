//%attributes = {}
FORM SET INPUT:C55([Occupations:2]; "import")
READ WRITE:C146([Occupations:2])
ALL RECORDS:C47([Occupations:2])
DELETE SELECTION:C66([Occupations:2])


//FldDelimit:=27  ` Set field delimiter to Escape character

//RecDelimit:=10  ` Set record delimiter to Line Feed character

IMPORT TEXT:C168([Occupations:2]; getSupportFilesPath+"BLACKLIST_ind.txt")  // Import from "NewPeople" documen

If (OK=1)
	myAlert("File is updated successfully.")
Else 
	myAlert("The system encountered an error while importing the Black List (individuals).")
End if 

