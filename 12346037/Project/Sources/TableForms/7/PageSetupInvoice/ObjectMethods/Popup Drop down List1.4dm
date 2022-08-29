C_LONGINT:C283($i; $j)
C_TEXT:C284(<>lastPrinterName; <>lastPageOption; <>lastInvoiceFormat)

If (Undefined:C82(arrPrinterNames))  // for compiler declaration purpose 
	ARRAY TEXT:C222(arrPageOptions; 0)
	ARRAY TEXT:C222(arrPrinterNames; 0)
	ARRAY LONGINT:C221(arrPageWidth; 0)
	ARRAY LONGINT:C221(arrPageHeight; 0)
	
	arrPageOptions:=0
	arrPrinterNames:=0
	C_TEXT:C284(vPrinterName)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (arrPrinterNames=0)  // if no selection is made
			ARRAY TEXT:C222(arrPageOptions; 0)
			ARRAY TEXT:C222(arrPrinterNames; 0)
			ARRAY LONGINT:C221(arrPageWidth; 0)
			ARRAY LONGINT:C221(arrPageHeight; 0)
			
		End if 
		PRINTERS LIST:C789(arrPrinterNames)
		If (<>lastPrinterName="")
			$i:=Find in array:C230(arrPrinterNames; getClientReceiptPrinterName)
		Else 
			$i:=Find in array:C230(arrPrinterNames; <>lastPrinterName)
		End if 
		
		If ($i>0)
			arrPrinterNames:=$i
			vPrinterName:=arrPrinterNames{$i}
			SET CURRENT PRINTER:C787(vPrinterName)
			If (OK=1)
				PRINT OPTION VALUES:C785(Paper option:K47:1; arrPageOptions; arrPageWidth; arrPageHeight)
			End if 
		End if 
		If (<>lastPageOption="")
			$j:=Find in array:C230(arrPageOptions; getClientReceiptPageFormat)
		Else 
			$j:=Find in array:C230(arrPageOptions; <>lastPageOption)
		End if 
		If ($j>0)
			arrPageOptions:=$j
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Self:C308->>0)
			C_TEXT:C284(vPrinterName)
			vPrinterName:=Self:C308->{Self:C308->}
			<>lastPrinterName:=vPrinterName
			
			SET CURRENT PRINTER:C787(vPrinterName)
			If (OK=1)
				ARRAY TEXT:C222(arrPageOptions; 0)
				ARRAY LONGINT:C221(arrPageWidth; 0)
				ARRAY LONGINT:C221(arrPageHeight; 0)
				
				PRINT OPTION VALUES:C785(Paper option:K47:1; arrPageOptions; arrPageWidth; arrPageHeight)
			End if 
		End if 
End case 