C_LONGINT:C283($i)
C_TEXT:C284($tPath)
ARRAY TEXT:C222($aDocuments; 0)

$tPath:=Select folder:C670("Select a folder whose contents you want to attach")

If ($tPath#"")
	
	DOCUMENT LIST:C474($tPath; $aDocuments)
	
	For ($i; 1; Size of array:C274($aDocuments))
		
		If (Find in array:C230(IncludesFiles; $tPath+BKP_GetDirGlyph+$aDocuments{$i})=-1)
			INSERT IN ARRAY:C227(IncludesFiles; Size of array:C274(IncludesFiles)+1)
			IncludesFiles{Size of array:C274(IncludesFiles)}:=$tPath+BKP_GetDirGlyph+$aDocuments{$i}
		End if 
		
	End for 
	
End if 