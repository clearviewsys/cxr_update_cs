//%attributes = {"publishedWeb":true}
// Make VRecNum
// set the VRecNum variable on input forms
C_TEXT:C284(vRecNum)

If (Selected record number:C246(Current form table:C627->)<0)
	vRecNum:=""
Else 
	vRecNum:=String:C10(Selected record number:C246(Current form table:C627->))+" of "+String:C10(Records in selection:C76(Current form table:C627->))
End if 
