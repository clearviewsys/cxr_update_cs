//%attributes = {}
// printListBox (->listbox; QRconstant ; title; outputPath) -> filePath


// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/06/12, 22:21:50
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: iLB_Generate_Report2
// Description
//  take a listbox and create a quick report of it
//
// Parameters
// $1 - pointer - to listbox
// $2 - longint- optional - destination - QR Constants
// $2 - text - optional - title for header of the report
// $3 - text - optional - filepath to location to save if output to HTML or Text
// $0 - text - filepath to location saved
// ----------------------------------------------------

C_POINTER:C301($1; $ptrListBox)
C_LONGINT:C283($2; $iDestination)  // use one of the QR constants: qr printer; qr HTML file; qr text file
C_TEXT:C284($3; $tTitle)
C_TEXT:C284($4; $tFilePath)

C_TEXT:C284($0)  //send back the file path
C_TIME:C306($hRef)


//LOCAL DECLARATIONS
C_BOOLEAN:C305($bHorGrid; $bVertGrid)
C_LONGINT:C283($i; $iAlign; $iAltColor; $iArea; $iBackColor; $iCalcType; $iColCount; $iDestination; $iForeColor; $iOver; $iSize; $iStyle; $iTable; $iTotalWidth; $iWidth)
C_TEXT:C284($sDisplayFormat; $sFont)
C_TEXT:C284($tFilePath; $tFormula; $tHeader; $tTitle)

$ptrListBox:=$1
$tFilePath:=""

If (Count parameters:C259>1)
	$iDestination:=$2
Else 
	$iDestination:=qr printer:K14903:1  //default to printer
End if 

OK:=1  //init

If ($iDestination=qr printer:K14903:1)
	If (Count parameters:C259>2)
		$tTitle:=$3
	Else 
		$tTitle:=Request:C163("Enter a title for this report.")
	End if 
Else   //for html and disk file
	$tTitle:=""  //not used
	If (Count parameters:C259>3)
		$tFilePath:=$4
	End if 
	If ($tFilePath="")
		$hRef:=Create document:C266(""; "HTML")
		If (OK=1)
			$tFilePath:=document
			CLOSE DOCUMENT:C267($hRef)
		End if 
		
	End if 
End if 

SET AUTOMATIC RELATIONS:C310(True:C214)  // Modified by: Tiran Behrouz (3/15/13)


If (OK=1)
	
	ARRAY TEXT:C222($arrColNames; 0)
	ARRAY TEXT:C222($arrHeaderNames; 0)
	ARRAY TEXT:C222($arrFooterNames; 0)
	
	ARRAY POINTER:C280($arrColVars; 0)
	ARRAY POINTER:C280($arrHeaderVars; 0)
	ARRAY POINTER:C280($arrFooterVars; 0)
	ARRAY BOOLEAN:C223($arrColsVisible; 0)
	ARRAY POINTER:C280($arrStyles; 0)
	
	$iColCount:=LISTBOX Get number of columns:C831($ptrListBox->)
	LISTBOX GET TABLE SOURCE:C1014($ptrListBox->; $iTable)
	If ($iTable>0)  //all good
	Else 
		$iTable:=Table:C252(Current form table:C627)  //3/9/19 IBB
	End if 
	LISTBOX GET ARRAYS:C832($ptrListBox->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)
	LISTBOX GET GRID:C1199($ptrListBox->; $bHorGrid; $bVertGrid)
	
	$iArea:=QR New offscreen area:C735
	QR SET REPORT TABLE:C757($iArea; $iTable)
	
	$iTotalWidth:=0
	
	For ($i; 1; $iColCount)
		$tFormula:=LISTBOX Get column formula:C1202(*; $arrColNames{$i})
		If ($tFormula="")
			$tFormula:="Num(True)*\"\""
		End if 
		
		$tHeader:=OBJECT Get title:C1068(*; $arrHeaderNames{$i})
		$iWidth:=LISTBOX Get column width:C834(*; $arrColNames{$i})
		
		$iTotalWidth:=$iTotalWidth+$iWidth  //use scaling at print time if available
		//If ($i=$iColCount) & ($iTotalWidth>=700)  //last column - landscape
		//$iOver:=$iTotalWidth-700
		//Case of 
		//: ($iOver<$iWidth)
		//$iWidth:=$iWidth-$iOver
		//: ($iOver>$iWidth)
		//  //nothing to do
		//End case 
		//End if 
		
		$sDisplayFormat:=OBJECT Get format:C894(*; $arrColNames{$i})
		QR INSERT COLUMN:C748($iArea; $i; $tFormula)
		QR SET INFO COLUMN:C765($iArea; $i; $tHeader; $tFormula; 0; $iWidth; 0; $sDisplayFormat)
		
		
		//******** SET COLUMN HEADER TEXT PROPERTIES *********
		
		$sFont:=OBJECT Get font:C1069(*; $arrHeaderNames{$i})
		$iSize:=OBJECT Get font size:C1070(*; $arrHeaderNames{$i})
		$iStyle:=OBJECT Get font style:C1071(*; $arrHeaderNames{$i})
		$iAlign:=OBJECT Get horizontal alignment:C707(*; $arrHeaderNames{$i})
		
		//QR SET TEXT PROPERTY($iArea;$i;qr title;qr font name;$sFont) // NEEDS TO BE THIS FOR v18 @viktor
		//QR SET TEXT PROPERTY($iArea;$i;qr title;_O_qr font;_O_Font number($sFont))
		QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr font name:K14904:10; "Arial")  // added @tiran for v18
		
		//assigning the font size 10 points:
		QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr font size:K14904:2; Num:C11($iSize))
		//assigning the font style attributes:
		If ($iStyle=1) | ($iStyle=3) | ($iStyle=5)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr bold:K14904:3; 1)
		End if 
		If ($iStyle=2) | ($iStyle=3) | ($iStyle=6)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr italic:K14904:4; 1)
		End if 
		If ($iStyle=4) | ($iStyle=5) | ($iStyle=6)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr underline:K14904:5; 1)
		End if 
		//assign alignment
		QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr justification:K14904:7; Abs:C99($iAlign-1))
		
		QR SET TEXT PROPERTY:C759($iArea; $i; qr title:K14906:1; qr background color:K14904:8; 0x00E5E5E5)
		QR SET BORDERS:C797($iArea; $i; qr title:K14906:1; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5; 1)
		
		
		// ******** SET COLUMN FOOTER TEXT PROPERTIES - USE THE SAME AS HEADER ********
		
		//QR SET TEXT PROPERTY($iArea;$i;qr grand total;_O_qr font;_O_Font number($sFont))
		QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr font name:K14904:10; "Arial")  // added by @tiran for v18
		
		//assigning the font size 10 points:
		QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr font size:K14904:2; $iSize)
		//assigning the font style attributes:
		If ($iStyle=1) | ($iStyle=3) | ($iStyle=5)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr bold:K14904:3; 1)
		End if 
		If ($iStyle=2) | ($iStyle=3) | ($iStyle=6)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr italic:K14904:4; 1)
		End if 
		If ($iStyle=4) | ($iStyle=5) | ($iStyle=6)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr underline:K14904:5; 1)
		End if 
		//assign alignment
		QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; Abs:C99($iAlign-1))
		
		$iCalcType:=LISTBOX Get footer calculation:C1150(*; $arrColNames{$i})
		
		Case of 
			: ($iCalcType=lk footer count:K70:5)
				QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr count:K14901:5)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
			: ($iCalcType=lk footer sum:K70:4)
				QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr sum:K14901:1)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
			: ($iCalcType=lk footer average:K70:6)
				QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr average:K14901:2)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
			: ($iCalcType=lk footer max:K70:3)
				QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr max:K14901:4)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
			: ($iCalcType=lk footer min:K70:2)
				QR SET TOTALS DATA:C767($iArea; $i; qr grand total:K14906:3; qr min:K14901:3)
				QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr justification:K14904:7; $iAlign-1)  //assign alignment
		End case 
		
		QR SET TEXT PROPERTY:C759($iArea; $i; qr grand total:K14906:3; qr background color:K14904:8; 0x00E5E5E5)  //light grey background for column headers
		QR SET BORDERS:C797($iArea; $i; qr grand total:K14906:3; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5; 1)
		
		
		
		//****** SET DETAIL ROWS *********
		
		//set detail text properties
		$sFont:=OBJECT Get font:C1069(*; $arrColNames{$i})
		$iSize:=OBJECT Get font size:C1070(*; $arrColNames{$i})
		$iStyle:=OBJECT Get font style:C1071(*; $arrColNames{$i})
		$iAlign:=OBJECT Get horizontal alignment:C707(*; $arrColNames{$i})
		OBJECT GET RGB COLORS:C1074(*; $arrColNames{$i}; $iForeColor; $iBackColor; $iAltColor)
		
		//QR SET TEXT PROPERTY($iArea;$i;qr detail;_O_qr font;_O_Font number($sFont))
		QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr font name:K14904:10; "Arial")  // added @tiran for v18
		
		//assigning the font size 10 points:
		QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr font size:K14904:2; $iSize)
		//assigning the font style attributes:
		If ($iStyle=1) | ($iStyle=3) | ($iStyle=5)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr bold:K14904:3; 1)
		End if 
		If ($iStyle=2) | ($iStyle=3) | ($iStyle=6)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr italic:K14904:4; 1)
		End if 
		If ($iStyle=4) | ($iStyle=5) | ($iStyle=6)
			QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr underline:K14904:5; 1)
		End if 
		
		//assign alignment
		QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr justification:K14904:7; Abs:C99($iAlign-1))
		
		Case of 
			: ($bHorGrid) & ($bVertGrid)
				QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3; 1)
			: ($bHorGrid)
				QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2; 1)
				QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr left border:K14908:1+qr right border:K14908:3; 0)
			: ($bVertGrid)
				QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr left border:K14908:1+qr right border:K14908:3; 1)
				QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2; 0)
			Else 
				QR SET BORDERS:C797($iArea; $i; qr detail:K14906:2; qr bottom border:K14908:4+qr top border:K14908:2+qr left border:K14908:1+qr right border:K14908:3+qr inside horizontal border:K14908:6+qr inside vertical border:K14908:5; 0)
		End case 
		
		QR SET TEXT PROPERTY:C759($iArea; $i; qr detail:K14906:2; qr alternate background color:K14904:9; $iAltColor)
		
	End for 
	
	//********* SET PAGE HEADER TEXT PROPERTIES ********
	
	QR SET TEXT PROPERTY:C759($iArea; 1; qr header:K14906:4; qr font name:K14904:10; "Arial")  // added by @tiran v18
	QR SET TEXT PROPERTY:C759($iArea; 1; qr header:K14906:4; qr font size:K14904:2; 12)  //assigning the font size 12 points:
	QR SET TEXT PROPERTY:C759($iArea; 1; qr header:K14906:4; qr bold:K14904:3; 1)  //assigning the font attribute Bold:
	QR SET HEADER AND FOOTER:C774($iArea; 1; ""; $tTitle; ""; 50)
	
	//********* SET  PAGE FOOTER TEXT PROPERTIES **********
	
	QR SET TEXT PROPERTY:C759($iArea; 1; qr footer:K14906:5; qr font name:K14904:10; "Arial")
	QR SET TEXT PROPERTY:C759($iArea; 1; qr footer:K14906:5; qr font size:K14904:2; 10)  //assigning the font size 10 points:
	QR SET HEADER AND FOOTER:C774($iArea; 2; "Printed: #D"; ""; "Page: #P"; 12)
	
	
	If ($iDestination=qr printer:K14903:1)
		QR SET DESTINATION:C745($iArea; $iDestination)
		
		If ($iTotalWidth>520)
			SET PRINT OPTION:C733(Orientation option:K47:2; 2)  //landscape
			If ($iTotalWidth>710)
				SET PRINT OPTION:C733(Scale option:K47:3; ((710/$iTotalWidth)*100))  //assume a .5 inch margin plus a little bit to fit right border
			End if 
		Else 
			SET PRINT OPTION:C733(Orientation option:K47:2; 1)  //portrait
		End if 
		
	Else 
		
		QR SET DESTINATION:C745($iArea; $iDestination; $tFilePath)
		
		// workaround for 4D bug
		// QuickReport is adding a lot of unnesecary <br> HTML tags in output. If we replace all \n characters
		// from default QuickReport HTML template, we get correct result
		
		// Bug number is ACI0100567 and it is fixed in version v18 build 250253 and later
		// but it is not integrated into v17 branch
		// This will fix 4D of being hung while generating HTML file with lot of rows in table
		// It will fix most issues, however some client sites will ignore this change for unknown reason
		// so we will replace <br> characters on our own in generated HTML file later
		
		C_TEXT:C284($template)
		$template:=QR Get HTML template:C751($iArea)
		$template:=Replace string:C233($template; "\n"; "")
		QR SET HTML TEMPLATE:C750($iArea; $template)
		
		// end workaround
		
	End if 
	
	QR RUN:C746($iArea)
	
	QR DELETE OFFSCREEN AREA:C754($iArea)
	
	// we will delete all the <br> tags in HTML document generated by QuickReport
	
	If ($iDestination=qr HTML file:K14903:5)
		If (Test path name:C476($tFilePath)=Is a document:K24:1)
			C_TEXT:C284($htmlDoc)
			$htmlDoc:=Document to text:C1236($tFilePath; "UTF-8")
			$htmlDoc:=Replace string:C233($htmlDoc; "<br>"; "")
			TEXT TO DOCUMENT:C1237($tFilePath; $htmlDoc; "UTF-8")
		End if 
	End if 
	
End if 

$0:=$tFilePath

SET AUTOMATIC RELATIONS:C310(False:C215)  // Modified by: Tiran Behrouz (3/15/13)
