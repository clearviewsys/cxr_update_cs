Case of 
	: (Form event code:C388=On Load:K2:1)
		
		// Set ROWS HEIGHT depending on the text length
		C_LONGINT:C283($n)
		
		$n:=Round:C94(Length:C16([DB_Keywords:105]sourceText:4)/40; 0)+1
		
		If ($n>1)
			LISTBOX SET ROWS HEIGHT:C835(Self:C308->; $n; 1)  // in lines
		End if 
		
End case 
