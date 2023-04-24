C_TEXT:C284($printerName)

If (Form event code:C388=On Clicked:K2:4)
	
	If (Self:C308->>0)
		$printerName:=Self:C308->{Self:C308->}
		SET CURRENT PRINTER:C787(Self:C308->{Self:C308->})
		If (OK=1)
			ARRAY TEXT:C222(arrPageOptions; 0)
			ARRAY LONGINT:C221(arrPageWidth; 0)
			ARRAY LONGINT:C221(arrPageHeight; 0)
			
			PRINT OPTION VALUES:C785(Paper option:K47:1; arrPageOptions; arrPageWidth; arrPageHeight)
		End if 
	End if 
End if 