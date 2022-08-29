//%attributes = {}
// OCR_AssignFieldValues 
// After scanning an ID this function assign values to fields in a form
// Created by JA on Feb 5/17/2017


C_LONGINT:C283($i; $p)

If (Size of array:C274(arrValuesOCR)>0)
	For ($i; 1; Size of array:C274(arrFieldsToSet))
		$p:=Find in array:C230(arrFieldsDefinedKeywordsOCR; arrFieldsToGet{$i})
		If ($p>0)
			arrFieldsToSet{$i}->:=arrValuesOCR{$p}
		End if 
		
	End for 
End if 

