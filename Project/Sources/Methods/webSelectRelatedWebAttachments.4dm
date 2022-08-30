//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 07/16/19, 08:21:03
// ----------------------------------------------------
// Method: webSelectRelatedWebAttachments
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $tTable)

C_POINTER:C301($ptrTable)

$tTable:=$1
If (Substring:C12($tTable; 1; 1)="/")  //strip it
	$tTable:=Substring:C12($tTable; 2; Length:C16($tTable))
End if 

$ptrTable:=UTIL_getFieldPointer($tTable)

REDUCE SELECTION:C351([WebAttachments:86]; 0)  //init

If (Records in selection:C76($ptrTable->)=1)
	Case of 
		: ($ptrTable=(->[WebEWires:149]))
			QUERY:C277([WebAttachments:86]; [WebAttachments:86]RelatedTableNum:11=Table:C252($ptrTable); *)
			QUERY:C277([WebAttachments:86];  & ; [WebAttachments:86]RelatedID:2=[WebEWires:149]WebEwireID:1)
			
		: ($ptrTable=(->[eWires:13]))
			QUERY:C277([WebAttachments:86]; [WebAttachments:86]RelatedTableNum:11=Table:C252($ptrTable); *)
			QUERY:C277([WebAttachments:86];  & ; [WebAttachments:86]RelatedID:2=[eWires:13]eWireID:1)
			
		: ($ptrTable=(->[Links:17]))
			QUERY:C277([WebAttachments:86]; [WebAttachments:86]RelatedTableNum:11=Table:C252($ptrTable); *)
			QUERY:C277([WebAttachments:86];  & ; [WebAttachments:86]RelatedID:2=[Links:17]LinkID:1)
			
		: ($ptrTable=(->[Customers:3]))
			QUERY:C277([WebAttachments:86]; [WebAttachments:86]RelatedTableNum:11=Table:C252($ptrTable); *)
			QUERY:C277([WebAttachments:86];  & ; [WebAttachments:86]RelatedID:2=[Customers:3]CustomerID:1)
			
		Else 
			
	End case 
	
End if 