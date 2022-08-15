//%attributes = {}
// returns XML to open in Excel from the values in collection
// calculated columns not supported in inital release
// exports only visible columns
// to export entity selection listbox, call this method using Form.listbox.toCollection()

C_TEXT:C284($0; $1; $listboxName; $root; $workSheet; $styles; $style; $styleDefault; $styleHeading; $styleComma; $styleCurrency; \
$numberFormat; $style2; $styleProperty; $row; $cell; $data; $dataString; $dataType)
C_COLLECTION:C1488($2; $dataCollection; $columnsCollection)
C_OBJECT:C1216($listboxItem; $currColumn; $rowData)
C_LONGINT:C283($i)

ASSERT:C1129(Count parameters:C259=2; "Wrong number of parameters")

$listboxName:=$1
$dataCollection:=$2

ASSERT:C1129($dataCollection.length>0; "Collection is empty")

ARRAY TEXT:C222($colNames; 0)
ARRAY TEXT:C222($hdrNames; 0)
ARRAY POINTER:C280($colVars; 0)
ARRAY POINTER:C280($hdrVars; 0)
ARRAY POINTER:C280($colStyles; 0)
ARRAY BOOLEAN:C223($colVisible; 0)

LISTBOX GET ARRAYS:C832(*; $listboxName; $colNames; $hdrNames; $colVars; $hdrVars; $colVisible; $colStyles)

$columnsCollection:=New collection:C1472

For ($i; 1; Size of array:C274($colNames))
	$currColumn:=New object:C1471
	$currColumn.formObjectName:=$colNames{$i}
	$currColumn.title:=OBJECT Get title:C1068(*; $hdrNames{$i})
	$currColumn.format:=OBJECT Get format:C894(*; $colNames{$i})
	$currColumn.formula:=LISTBOX Get column formula:C1202(*; $colNames{$i})
	$currColumn.propertyName:=Replace string:C233($currColumn.formula; "This."; "")
	$currColumn.dataType:=OB Get type:C1230($dataCollection[0]; $currColumn.propertyName)
	$currColumn.isVisible:=$colVisible{$i}
	$currColumn.hdrName:=$hdrNames{$i}
	$currColumn.isCalculated:=listboxIsCalculatedColumn($currColumn.formula)
	$columnsCollection.push($currColumn)
End for 

// Build XML now

$root:=DOM Create XML Ref:C861("Workbook"; ""; "xmlns"; "urn:schemas-microsoft-com:office:spreadsheet"; "xmlns:o"; "urn:schemas-microsoft-com:office:office"; "xmlns:x"; "urn:schemas-microsoft-com:office:excel"; "xmlns:html"; "http://www.w3.org/TR/REC-html40"; "xmlns:ss"; "urn:schemas-microsoft-com:office:spreadsheet")
DOM SET XML DECLARATION:C859($root; "UTF-16"; True:C214; True:C214)

$styles:=DOM Create XML element:C865($root; "Workbook/Styles")

$styleDefault:=DOM Create XML element:C865($styles; "Style"; "ss:ID"; "Default"; "ss:Name"; "Normal")  // define the default style

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

$worksheet:=DOM Create XML element:C865($root; "/Workbook/Worksheet"; "ss:Name"; "Sheet1")  // name of sheet

// build headers
$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
For each ($currColumn; $columnsCollection)
	If ($currColumn.isVisible)
		If ($currColumn.isCalculated=False:C215)
			$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; "sHdr")
			$data:=DOM Create XML element:C865($cell; "Data")
			DOM SET XML ELEMENT VALUE:C868($data; $currColumn.title)
			DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; "String")
		End if 
	End if 
End for each 

// build data

$i:=0

For each ($rowData; $dataCollection)
	
	$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
	
	For each ($listboxItem; $columnsCollection)
		
		If ($listboxItem.isVisible)
			
			If ($listboxItem.isCalculated=False:C215)
				
				
				Case of 
						
					: ($listboxItem.dataType=Is real:K8:4)
						
						$dataString:=String:C10($rowData[$listboxItem.propertyName])
						$dataType:="Number"
						
						
					: ($listboxItem.dataType=Is text:K8:3)
						
						$dataString:=$rowData[$listboxItem.propertyName]
						$dataType:="String"
						
						
					: ($listboxItem.dataType=Is boolean:K8:9)
						
						If ($rowData[$listboxItem.propertyName]=True:C214)
							$dataString:="True"
						Else 
							$dataString:="False"
						End if 
						$dataType:="String"
						
						
					: ($listboxItem.dataType=Is date:K8:7)
						
						C_DATE:C307($date)
						$date:=$rowData[$listboxItem.propertyName]
						$dataString:=String:C10(Year of:C25($date); "####")+"-"+String:C10(Month of:C24($date); "0#")+"-"+String:C10(Day of:C23($date); "0#")
						$dataString:=$dataString+"T00:00:00.000"
						$dataType:="DateTime"
						
						
					Else 
						
						// nothing, either picture or collection or object
						
				End case 
				
				C_TEXT:C284($stylePrefix)
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
			
		End if 
		
	End for each 
	
	$i:=$i+1
	
End for each 

DOM EXPORT TO VAR:C863($root; $0)

DOM CLOSE XML:C722($root)

