//%attributes = {}
C_TEXT:C284(vCustomerID)


QUERY:C277([Links:17]; [Links:17]CustomerID:14=vCustomerID; *)  // fill in the links array based on customer and link
QUERY:C277([Links:17];  & ; [Links:17]Country:12=[eWires:13]toCountry:10; *)


If (Records in selection:C76([Links:17])>0)
	SELECTION TO ARRAY:C260([Links:17]LinkID:1; arrLInkIDs; [Links:17]FullName:4; arrLinkNames; [Links:17]City:11; arrLinkCities)
	arrLinkIDs:=1  // select the first element
	arrLinkNames:=1
	arrLinkCities:=1
	//arrLinkUnicodeNames:=1
	//handleLinkListArrays   ` click on the first row and select it
Else 
	ARRAY TEXT:C222(arrLinkIDs; 0)
	ARRAY TEXT:C222(arrLinkNames; 0)
	ARRAY TEXT:C222(arrLinkCities; 0)
	//ARRAY TEXT(arrLinkUnicodeNames;0)
End if 
