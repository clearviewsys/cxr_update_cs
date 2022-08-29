//%attributes = {}
C_TEXT:C284($root)
C_TEXT:C284($workSheet)
C_TEXT:C284($row)
C_TEXT:C284($cell)
C_TEXT:C284($data)


C_LONGINT:C283($i; $j)
//$root:=DOM Create XML Ref("Workbook")
$root:=DOM Create XML Ref:C861("Workbook"; ""; "xmlns"; "urn:schemas-microsoft-com:office:spreadsheet"; "xmlns:o"; "urn:schemas-microsoft-com:office:office"; "xmlns:x"; "urn:schemas-microsoft-com:office:excel"; "xmlns:html"; "http://www.w3.org/TR/REC-html40"; "xmlns:ss"; "urn:schemas-microsoft-com:office:spreadsheet")
DOM SET XML DECLARATION:C859($root; "UTF-8"; True:C214; True:C214)
$worksheet:=DOM Create XML element:C865($root; "/Workbook/Worksheet"; "ss:Name"; "Sheet1")  // name of sheet

For ($i; 1; 4)  // iterate through rows
	
	$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")
	
	For ($j; 1; 3)  // iterate through columns
		$cell:=DOM Create XML element:C865($row; "Cell")
		$data:=DOM Create XML element:C865($cell; "Data")
		DOM SET XML ELEMENT VALUE:C868($data; "Row:"+String:C10($i)+" Col:"+String:C10($j))
		DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; "String")
	End for 
	
End for 

DOM EXPORT TO FILE:C862($root; "")
DOM CLOSE XML:C722($root)

