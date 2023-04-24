//%attributes = {"publishedWeb":true}
// Chart showMenu (Area; showflag)
// longint : area
// boolean: showflag

C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

If ($2=False:C215)
	//Ô14500;24Ô ($1;1;0)  // hide menus
Else 
	//Ô14500;24Ô ($1;1;1)  // Show menus
	
End if 