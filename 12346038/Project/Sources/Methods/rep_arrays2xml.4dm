//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/28/17, 14:47:52
// Copyright 2015 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: rep_arrays2xml
// Description
// 
//https://msdn.microsoft.com/en-us/library/aa140066(office.10).aspx#odc_xmlss_ss:style
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $filename)
C_POINTER:C301($2; $ptrHeaderArray)
C_POINTER:C301(${3})  //pointer to any number of data arrays

//for v15 convert parameters to an OBJECT

//C_POINTER($listBoxPtr;$1)
//C_TEXT($fileName;$2)
C_LONGINT:C283($i; $j; $iRowCount; $iColumnCount; $iType)

$filename:=$1
$ptrHeaderArray:=$2

$iRowCount:=Size of array:C274($3->)  //LISTBOX Get number of rows($listBoxPtr->)
$iColumnCount:=Count parameters:C259-2  //LISTBOX Get number of columns($listBoxPtr->)

C_TEXT:C284($stylePrefix)

If ($iRowCount>0)
	// initialize the arrays
	//ARRAY TEXT($arrHeaderNames;0)
	//ARRAY TEXT($arrColNames;0)
	//ARRAY POINTER($arrColVars;0)
	//ARRAY POINTER($arrHeaderVars;0)
	//ARRAY BOOLEAN($arrVisible;0)
	//ARRAY POINTER($arrStyles;0)
	
	C_TEXT:C284($root)
	C_TEXT:C284($workSheet)
	C_TEXT:C284($styles; $style; $styleDefault; $styleHeading; $styleComma; $styleCurrency; $iColumnCount umberFormat; $style2)
	C_TEXT:C284($styleProperty)
	C_TEXT:C284($row)
	C_TEXT:C284($cell)
	C_TEXT:C284($data)
	
	
	C_LONGINT:C283($i; $j)
	//$root:=DOM Create XML Ref("Workbook")
	$root:=DOM Create XML Ref:C861("Workbook"; ""; "xmlns"; "urn:schemas-microsoft-com:office:spreadsheet"; "xmlns:o"; "urn:schemas-microsoft-com:office:office"; "xmlns:x"; "urn:schemas-microsoft-com:office:excel"; "xmlns:html"; "http://www.w3.org/TR/REC-html40"; "xmlns:ss"; "urn:schemas-microsoft-com:office:spreadsheet")
	DOM SET XML DECLARATION:C859($root; "UTF-16"; True:C214; True:C214)
	
	$styles:=DOM Create XML element:C865($root; "Workbook/Styles")
	
	$styleDefault:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "Default"; "ss:Name"; "Normal")  // define the default style
	
	//$styleComma:=DOM Create XML element($styles;"Style";"ss:ID";"s16";"ss:Name";"Comma")  ` define the comma style
	//$iColumnCount umberFormat:=DOM Create XML element($styleComma;"NumberFormat";"ss:Format";"_(* #,##0.00_);_(* \\(#,##0.00);_(* &quot;-&quot;??_);_(@_)")
	
	//$styleCurrency:=DOM Create XML element($styles;"Style";"ss:ID";"s18";"ss:Name";"Currency")  ` define the currency style
	//$iColumnCount umberFormat:=DOM Create XML element($styleCurrency;"NumberFormat";"ss:Format";"_(&quot;$&quot;* #,##0.00_);"+"_(&quot;$&quot;* \\(#,##0.00\\);"+"_(&quot;$&quot;* &quot;-&quot;??_);_(@_)")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "sHdr")  // define the header style
	$style:=DOM Create XML element:C865($styleHeading; "Alignment"; "ss:Horizontal"; "Center"; "ss:Vertical"; "Center")  // make the font bold
	$style:=DOM Create XML element:C865($styleHeading; "Font"; "ss:Bold"; "1")  // make the font bold
	$style:=DOM Create XML element:C865($styleHeading; "Borders")
	$style2:=DOM Create XML element:C865($style; "Border"; "ss:Position"; "Bottom"; "ss:LineStyle"; "Continuous"; "ss:Weight"; "2")  // add a border
	$style2:=DOM Create XML element:C865($style; "Border"; "ss:Position"; "Top"; "ss:LineStyle"; "Continuous"; "ss:Weight"; "2")  // add a border
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddRow")  // define the highlighted of odd rows
	$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#DDFFDD"; "ss:Pattern"; "Solid")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenRow")  // define the highlighted even rows
	$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#FFFFFF"; "ss:Pattern"; "Solid")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddNum")  // define the highlighted numbers (for odd rows)
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "Standard")
	$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#DDFFDD"; "ss:Pattern"; "Solid")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenNum")  // define the numbers style for even rows
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "Standard")
	
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddGeneralNum")  // define the highlighted numbers (for odd rows)
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "General Number")
	$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#DDFFDD"; "ss:Pattern"; "Solid")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenGeneralNum")  // define the numbers style for even rows
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "General Number")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddRealNum")  // define the highlighted numbers (for odd rows)
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "Fixed")
	$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#DDFFDD"; "ss:Pattern"; "Solid")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenRealNum")  // define the numbers style for even rows
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "Fixed")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "oddDate")  // define the highlighted date (for odd rows)
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "mmmm\\ d\\,\\ yyyy")
	$style:=DOM Create XML element:C865($styleHeading; "Interior"; "ss:Color"; "#DDFFDD"; "ss:Pattern"; "Solid")
	
	$styleHeading:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "evenDate")  // define the date even rows
	$style:=DOM Create XML element:C865($styleHeading; "NumberFormat"; "ss:Format"; "mmmm\\ d\\,\\ yyyy")
	
	//<Style ss:ID="s24">
	//<Interior ss:Color="#CCFFCC"ss:Pattern="Solid"/>
	//<NumberFormat ss:Format="mmmm\\ d\\,\\ yyyy"/>
	//</Style>
	
	$worksheet:=DOM Create XML element:C865($root; "/Workbook/Worksheet"; "ss:Name"; "Sheet1")  // name of sheet
	
	C_TEXT:C284($headerName)
	
	
	//LISTBOX GET ARRAYS($listBoxPtr->;$arrColNames;$arrHeaderNames;$arrColVars;$arrHeaderVars;$arrVisible;$arrStyles)
	
	For ($i; 0; $iRowCount)
		
		$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
		
		
		For ($j; 1; $iColumnCount)
			
			If ($i=0)
				$headerName:=$ptrHeaderArray->{$j}
				If (Substring:C12($headerName; 4; 1)="_")
					$headerName:=Substring:C12($headerName; 5)
				End if 
				$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; "sHdr")
				$data:=DOM Create XML element:C865($cell; "Data")
				
				DOM SET XML ELEMENT VALUE:C868($data; $headerName)
				DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; "String")
				
			Else 
				C_POINTER:C301($jPtr)
				C_TEXT:C284($dataString; $dataType)
				C_REAL:C285($iColumnCount umCell)
				C_BOOLEAN:C305($isNum)
				C_TEXT:C284($prefix)
				C_LONGINT:C283($type)
				
				//$prefix:=Substring($ptrHeaderArray->{$j};1;4)
				$jPtr:=${$j+2}
				$iType:=Type:C295($jPtr->)
				
				Case of 
					: ($iType=Picture array:K8:22)
						$dataString:="X"
						$dataType:="String"
						
					: ($iType=LongInt array:K8:19)
						$dataString:=String:C10($jPtr->{$i})
						$dataType:="General Number"
						
					: ($iType=Real array:K8:17)
						$dataString:=String:C10($jPtr->{$i})
						$dataType:="Number"
						
					: ($iType=Text array:K8:16)
						$dataString:=String:C10($jPtr->{$i}; "|rate")
						$dataType:="String"
						
					: ($iType=Boolean array:K8:21)
						$dataString:=booleanToTrueFalse($jPtr->{$i})
						$dataType:="String"
						
					: ($iType=Date array:K8:20)
						C_DATE:C307($date)
						$date:=$jPtr->{$i}
						$dataString:=String:C10(Year of:C25($date); "####")+"-"+String:C10(Month of:C24($date); "0#")+"-"+String:C10(Day of:C23($date); "0#")
						$dataString:=$dataString+"T00:00:00.000"
						$dataType:="DateTime"
						
					Else 
						
						$dataString:=($jPtr->{$i})
						$dataType:="String"
						
				End case 
				
				If ($i%2=0)  // add the alternating row style
					$stylePrefix:="odd"
					//$cell:=DOM Create XML element($row;"Cell";"ss:StyleID";"Default")
				Else 
					$stylePrefix:="even"
					//$cell:=DOM Create XML element($row;"Cell";"ss:StyleID";"sRow")
				End if 
				
				Case of 
					: ($dataType="Number")
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"Num")
						
					: ($dataType="General Number")
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"GeneralNum")
						$dataType:="Number"
						
					: ($dataType="DateTime")
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"Date")
					Else 
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"Row")
				End case 
				
				$data:=DOM Create XML element:C865($cell; "Data")
				DOM SET XML ELEMENT VALUE:C868($data; $dataString)
				DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; $dataType)
				
			End if 
		End for 
	End for 
	DOM EXPORT TO FILE:C862($root; $filename)
	DOM CLOSE XML:C722($root)
	
Else 
	myAlert("There are no rows to export")
End if 
