//%attributes = {"publishedWeb":true}
// this method is called from bFirstRecord, bNextRecord, etc

// it handle enable / disable for navigation buttons

// buttons must be named bFirst, bPrevious, bNext, bLast


C_POINTER:C301($1)

If (Selected record number:C246($1->)<=1)
	OBJECT SET ENABLED:C1123(bPrevious; False:C215)
	OBJECT SET ENABLED:C1123(bFirst; False:C215)
Else 
	OBJECT SET ENABLED:C1123(bPrevious; True:C214)
	OBJECT SET ENABLED:C1123(bFirst; True:C214)
End if 

If (Selected record number:C246($1->)>=Records in selection:C76($1->))
	OBJECT SET ENABLED:C1123(bNext; False:C215)
	OBJECT SET ENABLED:C1123(bLast; False:C215)
Else 
	OBJECT SET ENABLED:C1123(bNext; True:C214)
	OBJECT SET ENABLED:C1123(bLast; True:C214)
End if 