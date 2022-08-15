//%attributes = {}
// ilb_generate_xls (->listbox;path)
// this method exports the table to be opened in Excel

C_POINTER:C301($listBoxPtr; $1)
C_TEXT:C284($tPath; $2)

C_TEXT:C284($0)


C_LONGINT:C283($i; $j; $n; $m)
C_LONGINT:C283($i; $j; $iRows; $iCols; $iBackColor; $iAltColor; $iForeColor)
C_LONGINT:C283($iTable; $iType; $iView; $iWidth; $iRef; $iRecs)
C_TEXT:C284($sAltColor)
C_TEXT:C284($tFormula; $tRef; $tableRef)

C_TEXT:C284($headerName)

C_TEXT:C284(iLB_dataString)

$listBoxPtr:=$1

If (Count parameters:C259>=2)
	$tPath:=$2
Else 
	$tPath:=""
End if 


//LISTBOX GET TABLE SOURCE($listBoxPtr->;$iTable)
//$iView:=iLB_Current_View ($listBoxPtr)

//CREATE SET(Table($iTable)->;"$TempSet")

//$iRecs:=Records in set("UserSet")

$iRows:=LISTBOX Get number of rows:C915($listBoxPtr->)
$iCols:=LISTBOX Get number of columns:C831($listBoxPtr->)


Case of 
	: ($tPath="")  //not set
		$tPath:=Temporary folder:C486
		$tPath:=$tPath+"Listbox"+"_"+String:C10($iCols)+"_recs.xls"
	: (Test path name:C476($tPath)=Is a folder:K24:2)
		$tPath:=$tPath+"Listbox"+"_"+String:C10($iCols)+"_recs.xls"
	Else   //assume a complete file path
		
End case 

//USE SET("UserSet")



OBJECT GET RGB COLORS:C1074($listBoxPtr->; $iForeColor; $iBackColor; $iAltColor)
$sAltColor:=UTIL_Num2HexString($iAltColor)

C_TEXT:C284($stylePrefix)

If ($iRows>0)
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
	$root:=DOM Create XML Ref:C861("Workbook"; ""; "xmlns"; "urn:schemas-microsoft-com:office:spreadsheet"; "xmlns:o"; "urn:schemas-microsoft-com:office:office"; "xmlns:x"; "urn:schemas-microsoft-com:office:excel"; "xmlns:html"; "http://www.w3.org/TR/REC-html40"; "xmlns:ss"; "urn:schemas-microsoft-com:office:spreadsheet")
	DOM SET XML DECLARATION:C859($root; "UTF-8"; True:C214)
	
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
	
	
	
	LISTBOX GET ARRAYS:C832($listBoxPtr->; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrVisible; $arrStyles)
	
	//INSERT COLUMN WIDTHS HERE
	$tableRef:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table")
	
	For ($i; 1; $iCols)
		$iWidth:=LISTBOX Get column width:C834(*; $arrColNames{$i})
		$tRef:=DOM Create XML element:C865($tableRef; "Column"; "ss:Width"; String:C10($iWidth))
	End for 
	
	//FIRST RECORD(Table($iTable)->)
	
	For ($i; 0; $iRows)
		//RELATE ONE(Table($iTable)->)
		
		$row:=DOM Create XML element:C865($root; "/Workbook/Worksheet/Table/Row")  // create a row Tag in xml
		//$styleProperty:=DOM Create XML element($styles;"/Workbook/Styles/Style")
		
		For ($j; 1; $iCols)
			
			If ($i=0)
				$headerName:=OBJECT Get title:C1068(*; $arrHeaderNames{$j})
				If (Substring:C12($headerName; 4; 1)="_")
					$headerName:=Substring:C12($headerName; 5)
				End if 
				$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; "sHdr")
				$data:=DOM Create XML element:C865($cell; "Data")
				
				DOM SET XML ELEMENT VALUE:C868($data; $headerName)
				DOM SET XML ATTRIBUTE:C866($data; "ss:Type"; "String")
				
			Else 
				C_POINTER:C301($ptrCol)
				C_TEXT:C284($dataString; $dataType)
				C_REAL:C285($numCell)
				C_BOOLEAN:C305($isNum)
				C_TEXT:C284($prefix)
				C_LONGINT:C283($iType)
				//$prefix:=Substring($arrHeaderNames{$j};1;4)
				
				
				$ptrCol:=$arrColVars{$j}
				
				$iType:=Type:C295($ptrCol->)  //what type of array is this
				
				Case of 
					: ($iType=Picture array:K8:22)
						$dataString:="_"
						$dataType:="String"
						
					: ($iType=LongInt array:K8:19) | ($iType=Integer array:K8:18)  //($prefix="num_")
						$dataString:=String:C10($ptrCol->{$i})
						$dataType:="Number"
						
					: ($iType=Real array:K8:17)
						$dataString:=String:C10($ptrCol->{$i})
						$dataType:="Number"
						
					: ($iType=Time array:K8:29)
						$dataString:=String:C10($ptrCol->{$i})
						$dataType:="String"
						
					: ($iType=Boolean array:K8:21)
						$dataString:=Choose:C955($ptrCol->{$i}; "True"; "False")  //booleanToTrueFalse($ptrCol->{$i})
						$dataType:="String"
						
					: ($iType=Date array:K8:20)
						C_DATE:C307($date)
						$date:=$ptrCol->{$i}
						
						If ($date=!00-00-00!)
							$dataString:=""
							$dataType:="String"
						Else 
							$dataString:=String:C10(Year of:C25($date); "####")+"-"+String:C10(Month of:C24($date); "0#")+"-"+String:C10(Day of:C23($date); "0#")
							$dataString:=$dataString+"T00:00:00.000"
							$dataType:="DateTime"
						End if 
						
					Else 
						$dataString:=($ptrCol->{$i})
						$dataType:="String"
				End case 
				
				
				
				//*********
				
				If ($i%2=0)  // add the alternating row style
					$stylePrefix:="odd"
					//$cell:=DOM Create XML element($row;"Cell";"ss:StyleID";"Default")
				Else 
					$stylePrefix:="even"
					//$cell:=DOM Create XML element($row;"Cell";"ss:StyleID";"sRow")
				End if 
				
				Case of 
					: ($iType=Integer array:K8:18) | ($iType=LongInt array:K8:19)
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"GeneralNum")
					: ($iType=Real array:K8:17)
						$cell:=DOM Create XML element:C865($row; "Cell"; "ss:StyleID"; $stylePrefix+"StandardNum")
					: ($iType=Date array:K8:20)
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
	
	DOM EXPORT TO FILE:C862($root; $tPath)
	DOM CLOSE XML:C722($root)
	
	If ($tPath="")
		$tPath:=document
	End if 
	
	MOVE DOCUMENT:C540($tPath; Replace string:C233($tPath; ".xml"; ".xls"))  //rename doc to have xls extension
	
	If (Current user:C182="designer")
		SHOW ON DISK:C922(Replace string:C233($tPath; ".xml"; ".xls"))
	End if 
	
Else 
	myAlert("There are no rows to export")
End if 



$0:=$tPath