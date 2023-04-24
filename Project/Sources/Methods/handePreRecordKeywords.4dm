//%attributes = {}
ARRAY TEXT:C222(arrKeywordsType; 0)
XLIFF_SetKeywordsTypes(->arrKeywordsType)
C_LONGINT:C283($p)

$p:=Find in array:C230(arrkeywordsType; [DB_Keywords:105]Type:2)
If ($p>0)
	arrkeywordsType:=$p
Else 
	arrkeywordsType:=1
End if 

