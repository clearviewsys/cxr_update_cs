//%attributes = {}
// saveToTextFile (->listbox;path)
// this method exports the table to be opened in Excel
// WARNING: all numeric columns should have an object name with the prefix num_, or cur_ (for currency)

C_POINTER:C301($listBoxPtr; $1)
C_TEXT:C284($fileName; $2)
C_LONGINT:C283($i; $j; $m; $n)

$listBoxPtr:=$1
$fileName:=$2

C_LONGINT:C283($i; $j; $n; $m)
$m:=LISTBOX Get number of rows:C915($listBoxPtr->)
$n:=LISTBOX Get number of columns:C831($listBoxPtr->)

C_TEXT:C284($stylePrefix)

If ($m>0)
	// initialize the arrays
	ARRAY TEXT:C222($arrHeaderNames; 0)
	ARRAY TEXT:C222($arrColNames; 0)
	ARRAY POINTER:C280($arrColVars; 0)
	ARRAY POINTER:C280($arrHeaderVars; 0)
	ARRAY BOOLEAN:C223($arrVisible; 0)
	ARRAY POINTER:C280($arrStyles; 0)
	
	C_TEXT:C284($root)
	C_TEXT:C284($workSheet)
	C_TEXT:C284($styles; $style; $styleDefault; $styleHeading; $styleComma; $styleCurrency; $numberFormat; $style2)
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
	//$numberFormat:=DOM Create XML element($styleComma;"NumberFormat";"ss:Format";"_(* #,##0.00_);_(* \\(#,##0.00);_(* &quot;-&quot;??_);_(@_)")
	
	//$styleCurrency:=DOM Create XML element($styles;"Style";"ss:ID";"s18";"ss:Name";"Currency")  ` define the currency style
	//$numberFormat:=DOM Create XML element($styleCurrency;"NumberFormat";"ss:Format";"_(&quot;$&quot;* #,##0.00_);"+"_(&quot;$&quot;* \\(#,##0.00\\);"+"_(&quot;$&quot;* &quot;-&quot;??_);_(@_)")
	
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
	
	
	LISTBOX GET ARRAYS:C832($listBoxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrVisible; $arrStyles)
	
	For ($i; 0; $m)
		
		$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
		//$styleProperty:=DOM Create XML element($styles;"/Workbook/Styles/Style")
		
		For ($j; 1; $n)
			
			If ($i=0)
				$headerName:=$arrHeaderNames{$j}
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
				C_REAL:C285($numCell)
				C_BOOLEAN:C305($isNum)
				C_TEXT:C284($prefix)
				C_LONGINT:C283($type)
				$prefix:=Substring:C12($arrHeaderNames{$j}; 1; 4)
				$jPtr:=$arrColVars{$j}
				
				Case of 
					: ($prefix="pic_")
						$dataString:="_"
						$dataType:="String"
						
					: ($prefix="num_")
						$dataString:=String:C10($jPtr->{$i})
						$dataType:="Number"
						
					: ($prefix="cur_")
						$dataString:=String:C10($jPtr->{$i})
						$dataType:="Number"
						
					: ($prefix="rat_")
						$dataString:=String:C10($jPtr->{$i}; "|rate")
						$dataType:="String"
						
					: (($prefix="bool") | ($prefix="bln_") | ($prefix="bol_"))
						$dataString:=booleanToTrueFalse($jPtr->{$i})
						$dataType:="String"
						
					: (($prefix="dat_") | ($prefix="date"))
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
