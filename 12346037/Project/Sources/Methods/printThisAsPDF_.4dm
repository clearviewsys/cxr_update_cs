//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 03/17/20, 17:31:27
// ----------------------------------------------------
// Method: printThisAsPDF
// Description
//      if using pdfcreator: https://azure.download.pdfforge.org/pdfcreator/1.7.3/PDFCreator-1_7_3_setup.exe
//   https://kb.4d.com/assetid=76541


// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptrTable)
C_TEXT:C284($2; $tPath)

C_TEXT:C284($0)

C_BOOLEAN:C305($bAbort)
C_TEXT:C284($tPrinter)


$ptrTable:=$1
$bAbort:=False:C215

If (Count parameters:C259>=2)
	$tPath:=$2  //should really test the path to make sure it will work
Else 
	$tPath:=Temporary folder:C486+Replace string:C233(String:C10(Current time:C178); ":"; "")+".pdf"
End if 

If (Test path name:C476($tPath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($tPath)
End if 



$tPrinter:=Get current printer:C788

If (Is Windows:C1573)
	ARRAY TEXT:C222($atPrinters; 0)
	PRINTERS LIST:C789($atPrinters)
	
	
	Case of 
		: (Find in array:C230($atPrinters; "Microsoft Print to PDF")>0)
			SET CURRENT PRINTER:C787(Generic PDF driver:K47:15)
			SET PRINT OPTION:C733(Destination option:K47:7; 3; $tPath)
			
		: (Find in array:C230($atPrinters; "PDFCreator@")>0)
			SET CURRENT PRINTER:C787(PDFCreator Printer name:K47:13)
			SET PRINT OPTION:C733(Destination option:K47:7; 3; $tPath)
			
		Else 
			$bAbort:=True:C214
	End case 
	
	
Else 
	SET PRINT OPTION:C733(Destination option:K47:7; 3; $tPath)  //mac
End if 

If ($bAbort)  //no valide PDF option
	myAlert("No PDF print option is available. Please install PDFCreator or Microsoft Print to PDF")
Else 
	//SET PRINT OPTION(_o_Hide printing progress option; 1)  //only affects mac
	PRINT SELECTION:C60($ptrTable->; *)
	
	If (Is Windows:C1573)
		If (Find in array:C230($atPrinters; "PDFCreator@")>0)
			SET PRINT OPTION:C733("PDFInfo:Reset standard options"; 0)
		Else 
			SET PRINT OPTION:C733(Destination option:K47:7; 1)
		End if 
	End if 
	
	SET CURRENT PRINTER:C787($tPrinter)
End if 

If (Test path name:C476($tPath)=Is a document:K24:1)
	$0:=$tPath
Else 
	$0:=""
End if 