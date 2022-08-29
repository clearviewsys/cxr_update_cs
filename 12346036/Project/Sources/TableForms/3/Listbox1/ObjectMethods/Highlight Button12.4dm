//
//CONFIRM("Run query on all records or currenct selection";"All Records";"Selection Only")
//
//If (OK=1)
//QUERY([Customers];[Customers]isCompany=False)
//
//Else 
//QUERY SELECTION([Customers];[Customers]isCompany=False)
//
//End if 
//
//QUERY SELECTION([Customers];[Customers]MainPictureID="";*)
//QUERY SELECTION([Customers]; | ;[Customers]DOB=!00/00/00!;*)
//QUERY SELECTION([Customers]; | ;[Customers]PictureIDIssue="";*)
//QUERY SELECTION([Customers]; | ;[Customers]Occupation="";*)
//QUERY SELECTION([Customers]; | ;[Customers]Address="")
//
//orderbyCustomers 

C_LONGINT:C283($WinRef)
$winRef:=openFormWindow(->[Customers:3]; "KYCQuery")
BRING TO FRONT:C326($winRef)
