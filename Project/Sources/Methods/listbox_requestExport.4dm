//%attributes = {}
// listbox_requestExport(->listbox;"Name of listbox")
C_POINTER:C301($listboxPtr; $1)
C_TEXT:C284($listboxName; $2)

$listboxPtr:=$1
If (Count parameters:C259=2)
	$listboxName:=$2
Else 
	$listboxName:=""
End if 

openFormWindow(->[CompanyInfo:7]; "listbox_requestExport")
If (OK=1)
	Case of 
		: (listbox_exportFormat="CSV")
			listbox_exportToCSV($listboxPtr; "")
		: (listbox_exportFormat="TXT")
			listbox_exportToTextFile($listboxPtr; "")
		: (listbox_exportFormat="XML")
			listbox_exportToXML($listboxPtr; "")
		Else 
	End case 
End if 