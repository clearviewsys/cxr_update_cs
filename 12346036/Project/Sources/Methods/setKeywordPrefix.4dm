//%attributes = {}
// setKeywordPrefix

C_POINTER:C301($1)
C_TEXT:C284($2; $3)
C_TEXT:C284($max)

If ($2="errors")
	
	Begin SQL
		SELECT DB_Keywords.keyword FROM DB_Keywords 
		WHERE DB_Keywords.Type = 'errors' 
		ORDER BY DB_Keywords.keyword DESC
		LIMIT 1
		INTO <<$max>>
	End SQL
	$1->:="err_"+String:C10(Num:C11($max)+1)
	
Else 
	
	
	C_TEXT:C284($keywId)
	$keywId:=Lowercase:C14($3)
	$keywId:=Replace string:C233($keywId; " "; "_")
	$keywId:="cvs_"+$keywId
	
	$1->:=$keywId
	
End if 
