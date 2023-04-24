//%attributes = {}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 01/29/19, 15:22:13
// ----------------------------------------------------
// Method: EXPORT_thisView
// Description
//
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptrLbox)
C_TEXT:C284($tPath; $2)
C_TEXT:C284($0)
C_LONGINT:C283($iTable)
C_LONGINT:C283($i; $j; $n; $m)
C_LONGINT:C283($i; $j; $iRows; $iCols; $iBackColor; $iAltColor; $iForeColor)
C_LONGINT:C283($iTable; $iType; $iView; $iWidth; $iRef; $iRecs)
C_TEXT:C284($sAltColor)  // Replaced #v15 5/13/22 was STRING(80)
C_TEXT:C284($tFormula; $tRef; $tableRef)
C_TEXT:C284($headerName)
C_TEXT:C284($stylePrefix; $table)
C_DATE:C307($date)



$ptrLbox:=$1

If (Count parameters:C259>=2)
	$tPath:=$2
Else 
	$tPath:=""
End if 
$table:=$ptrLbox->getDataClass().getInfo().name
Case of 
	: ($tPath="")  //not set
		$tPath:=Temporary folder:C486
		$tPath:=$tPath+$table+"_"+String:C10($ptrLbox->length)+"_recs.xls"
	: (Test path name:C476($tPath)=Is a folder:K24:2)
		$tPath:=$tPath+$table+"_"+String:C10($ptrLbox->length)+"_recs.xls"
	: (Test path name:C476($tPath)=Is a document:K24:1)  // all good
	Else   //assume a complete file path
		//bad path
End case 
If (Test path name:C476($tPath)=Is a document:K24:1)
	OBJECT GET RGB COLORS:C1074($ptrLbox->; $iForeColor; $iBackColor; $iAltColor)
	$sAltColor:=SVG_Color_RGB_from_long($iAltColor; 3)
	$iRows:=LISTBOX Get number of rows:C915($ptrLbox->)
	$iCols:=LISTBOX Get number of columns:C831($ptrLbox->)
	If ($iRows>0)
		// initialize the arrays
		ARRAY TEXT:C222($arrHeaderNames; 0)
		ARRAY TEXT:C222($arrColNames; 0)
		ARRAY POINTER:C280($arrColVars; 0)
		ARRAY POINTER:C280($arrHeaderVars; 0)
		ARRAY BOOLEAN:C223($arrVisible; 0)
		ARRAY POINTER:C280($arrStyles; 0)
		C_TEXT:C284($root)  // Replaced #v15 5/13/22 was STRING(16)
		C_TEXT:C284($workSheet)  // Replaced #v15 5/13/22 was STRING(16)
		C_TEXT:C284($styles; $style; $styleDefault; $styleHeading; $styleComma; $styleCurrency; $numberFormat; $style2)  // Replaced #v15 5/13/22 was STRING(16)
		C_TEXT:C284($styleProperty)  // Replaced #v15 5/13/22 was STRING(16)
		C_TEXT:C284($row)  // Replaced #v15 5/13/22 was STRING(16)
		C_TEXT:C284($cell)  // Replaced #v15 5/13/22 was STRING(16)
		C_TEXT:C284($data)  // Replaced #v15 5/13/22 was STRING(16)
		C_LONGINT:C283($i; $j)
		$root:=DOM Create XML Ref:C861("Workbook"; ""; "xmlns"; "urn:schemas-microsoft-com:office:spreadsheet"; "xmlns:o"; "urn:schemas-microsoft-com:office:office"; "xmlns:x"; "urn:schemas-microsoft-com:office:excel"; "xmlns:html"; "http://www.w3.org/TR/REC-html40"; "xmlns:ss"; "urn:schemas-microsoft-com:office:spreadsheet")
		DOM SET XML DECLARATION:C859($root; "UTF-8"; True:C214)
		$styles:=DOM Create XML element:C865($root; "Workbook/Styles")
		$styleDefault:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "Default"; "ss:Name"; "Normal")  // define the default style
		//$styleComma:=DOM Create XML element($styles;"Style";"ss:ID";"s16";"ss:Name";"Comma") ` define the comma style
		//$numberFormat:=DOM Create XML element($styleComma;"NumberFormat";"ss:Format";"_(* #,##0.00_);_(* \\(#,##0.00);_(* &quot;-&quot;??_);_(@_)")
		//$styleCurrency:=DOM Create XML element($styles;"Style";"ss:ID";"s18";"ss:Name";"Currency") ` define the currency style
		//$numberFormat:=DOM Create XML element($styleCurrency;"NumberFormat";"ss:Format";"_(&quot;$&quot;* #,##0.00_);"+"_(&quot;$&quot;* \\(#,##0.00\\);"+"_(&quot;$&quot;* &quot;-&quot;??_);_(@_)")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "sHdr")  // define the header style
		$style:=DOM Create XML element:C865($styleHeading; "Alignment"; "ss:Horizontal"; "Center"; "ss:Vertical"; "Center")  // make the font bold
		$style:=DOM Create XML element:C865($styleHeading; "Font"; "ss:Bold"; "1")  // make the font bold
		$style:=DOM Create XML element:C865($styleHeading; "Borders")
		$style2:=DOM Create XML element:C865($style; "Border"; "ss:Position"; "Bottom"; "ss:LineStyle"; "Continuous"; "ss:Weight"; "2")  // add a border
		$style2:=DOM Create XML element:C865($style; "Border"; "ss:Position"; "Top"; "ss:LineStyle"; "Continuous"; "ss:Weight"; "2")  // add a border
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddRow")  // define the highlighted of odd rows
		$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; $sAltColor; "ss:Pattern"; "Solid")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenRow")  // define the highlighted even rows
		$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#FFFFFF"; "ss:Pattern"; "Solid")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddStandardNum")  // define the highlighted numbers (for odd rows)
		$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "Standard")
		$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; $sAltColor; "ss:Pattern"; "Solid")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenStandardNum")  // define the numbers style for even rows
		$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "Standard")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddGeneralNum")  // define the highlighted numbers (for odd rows)
		$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "General")
		$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; $sAltColor; "ss:Pattern"; "Solid")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenGeneralNum")  // define the numbers style for even rows
		$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "General")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddDate")  // define the highlighted date (for odd rows)
		$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "mm/dd/yyyy")
		$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; $sAltColor; "ss:Pattern"; "Solid")
		$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenDate")  // define the date even rows
		$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "mm/dd/yyyy")
		//<Style ss:ID="s24">
		//<Interior ss:Color="#CCFFCC"ss:Pattern="Solid"/>
		//<NumberFormat ss:Format="mmmm\\ d\\,\\ yyyy"/>
		//</Style>
		$worksheet:=DOM Create XML element:C865($root; "/Workbook/Worksheet"; "ss:Name"; "Sheet1")  // name of sheet
		LISTBOX GET ARRAYS:C832($ptrLbox->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrVisible; $arrStyles)
		//insert column widths here
		$tableRef:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table")
		For ($i; 1; $iCols)
			$iWidth:=LISTBOX Get column width:C834(*; $arrColNames{$i})
			$tRef:=DOM Create XML element:C865($tableRef; "Column"; "ss:Width"; String:C10($iWidth))
		End for 
		$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
		For ($i; 1; Size of array:C274($arrHeaderNames))
			$headerName:=OBJECT Get title:C1068(*; $arrHeaderNames{$i})
			If (Substring:C12($headerName; 4; 1)="_")
				$headerName:=Substring:C12($headerName; 5)
			End if 
			$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; "sHdr")
			$data:=DOM Create XML element:C865($cell; "Data")
			DOM SET XML ELEMENT VALUE:C868($data; $headerName)
			DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; "String")
		End for 
		
		C_OBJECT:C1216($rec)
		
		For each ($rec; $ptrLbox->)
			$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
			//$styleProperty:=DOM Create XML element($styles;"/Workbook/Styles/Style")
			For ($j; 1; $iCols)
				C_POINTER:C301($ptrCol)
				C_TEXT:C284($dataString; $dataType)
				C_REAL:C285($numCell)
				C_BOOLEAN:C305($isNum)
				C_TEXT:C284($prefix)  // Replaced #v15 5/13/22 was STRING(4)
				C_LONGINT:C283($iType)
				If (Is nil pointer:C315($arrColVars{$j}))  //this is a formula
					$tFormula:=Replace string:C233(LISTBOX Get column formula:C1202(*; $arrColNames{$j}); "This."; "")
					$iType:=Value type:C1509($rec[$tFormula])
					If ($iType=Is text:K8:3) | ($iType=Is alpha field:K8:1) | ($iType=Is string var:K8:2)
						$dataString:=$rec[$tFormula]
						$dataType:="String"
					Else 
						Case of 
							: ($iType=Is longint:K8:6) | ($iType=Is integer:K8:5)
								$dataType:="Number"
								$dataString:=String:C10($rec[$tFormula])
							: ($iType=Is real:K8:4)
								$dataType:="Number"
								$dataString:=String:C10($rec[$tFormula])
							: ($iType=Is time:K8:8)
								$dataType:="String"
								$dataString:=String:C10($rec[$tFormula])
							: ($iType=Is boolean:K8:9)
								$dataType:="String"
								$dataString:=String:C10($rec[$tFormula])
							: ($iType=Is date:K8:7)
								$date:=$rec[$tFormula]
								If ($date=!00-00-00!)
									$dataString:=""
									$dataType:="String"
								Else 
									$dataString:=String:C10(Year of:C25($date); "####")+"-"+String:C10(Month of:C24($date); "0#")+"-"+String:C10(Day of:C23($date); "0#")
									$dataString:=$dataString+"T00:00:00.000"
									$dataType:="DateTime"
								End if 
							Else 
								$dataString:=String:C10($rec[$tFormula])
								$dataType:="String"
						End case 
					End if 
				End if 
				If ($i%2=0)  // add the alternating row style
					$stylePrefix:="odd"
				Else 
					$stylePrefix:="even"
				End if 
				Case of 
					: ($iType=Is integer:K8:5) | ($iType=Is longint:K8:6)
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"GeneralNum")
					: ($iType=Is real:K8:4)
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"StandardNum")
					: ($iType=Is date:K8:7)
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"Date")
					Else 
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"Row")
				End case 
				$data:=DOM Create XML element:C865($cell; "Data")
				DOM SET XML ELEMENT VALUE:C868($data; $dataString)
				DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; $dataType)
			End for 
			$i:=$i+1
		End for each 
		DOM EXPORT TO FILE:C862($root; $tPath)
		DOM CLOSE XML:C722($root)
		If ($tPath="")
			$tPath:=document
		End if 
		If ($tPath="@.xls")
		Else 
			MOVE DOCUMENT:C540($tPath; Replace string:C233($tPath; ".xml"; ".xls"))  //rename doc to have xls extension
		End if 
	Else 
		ALERT:C41("There are no rows to export")
	End if 
Else 
	$tPath:=""
End if 
$0:=$tPath
REDUCE SELECTION:C351(Table:C252($ptrLbox->getDataClass().getInfo().tableNumber)->; 0)