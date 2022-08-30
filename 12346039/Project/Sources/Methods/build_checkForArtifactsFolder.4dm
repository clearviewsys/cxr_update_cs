//%attributes = {}
// we use artifacts folder to attach logs, information or similar from each build
// we use upload-artifact@v3 github action to zip this folder and "upload" at the end of build process
// github actions will keep those for 90 days
// this methods checks if folder exists and it creates it if not

If (Test path name:C476(System folder:C487(Documents folder:K41:18)+"artifacts")#Is a folder:K24:2)
	CREATE FOLDER:C475(System folder:C487(Documents folder:K41:18)+"artifacts")
End if 
