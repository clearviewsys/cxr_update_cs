//%attributes = {"publishedWeb":true}
// bQuickReport ( {listboxptr; {tablePtr})


C_POINTER:C301($listboxPtr; $1)
C_POINTER:C301($tablePtr; $2)

C_LONGINT:C283(mainListBox)

Case of 
	: (Count parameters:C259=1)
		$listboxPtr:=$1
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=2)
		$listboxPtr:=$1
		$tablePtr:=$2
	Else 
		$listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")
		$tablePtr:=Current form table:C627
End case 

If (isUserAuthorizedToPrint($tablePtr))
	If (Macintosh option down:C545)
		C_TEXT:C284($reportName)
		$reportName:=getElegantTableName($tablePtr)+" Report."+CRLF+" Printed on "+String:C10(Current date:C33)+" at "+String:C10(Current time:C178)+" by "+getApplicationUser
		printListbox($listboxPtr; qr printing dialog:K14907:1; $reportName)
	Else 
		
		If (Shift down:C543)
			
			openFormWindow(->[CompanyInfo:7]; "QuickReportPage")
			
		Else 
			
			SET AUTOMATIC RELATIONS:C310(True:C214; False:C215)
			QR REPORT:C197($tablePtr->; Char:C90(1); False:C215; True:C214; False:C215)
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		End if 
		
	End if 
Else 
	myAlert("Sorry! You are not authorized to print records from "+getElegantTableName($listboxPtr))
End if 