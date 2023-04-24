//%attributes = {"publishedWeb":true}


C_LONGINT:C283($i)
For ($i; 1; Get last table number:C254)
	generateHTMLforTable(Table:C252($i))
End for 

//generateHTMLforTable (->[Links])