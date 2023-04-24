//%attributes = {}
C_TEXT:C284($1; $listboxName)
C_TEXT:C284($dataString; $alignment)
C_COLLECTION:C1488($2; $dataCollection; $columnsCollection; $cTableData)
C_OBJECT:C1216($3; $styles; $defaultStyles; $listboxItem; $currColumn; $rowData)
C_LONGINT:C283($i; $rowCounter)

ASSERT:C1129(Count parameters:C259>=2; "Wrong number of parameters")

$listboxName:=$1
$dataCollection:=$2

ASSERT:C1129($dataCollection.length>0; "Collection is empty")

If (True:C214)
	
	$defaultStyles:=New object:C1471
	$defaultStyles.tableFrame:=New object:C1471
	$defaultStyles.tableFrame.left:=New object:C1471
	$defaultStyles.tableFrame.top:=New object:C1471
	$defaultStyles.tableFrame.right:=New object:C1471
	$defaultStyles.tableFrame.bottom:=New object:C1471
	
	$defaultStyles.tableFrame.backgroundColor:=Background color none:K23:10
	$defaultStyles.tableFrame.left.lineWidth:=kPrint_1PixelLine
	$defaultStyles.tableFrame.left.lineStyle:=Border Plain:K42:28
	$defaultStyles.tableFrame.left.lineColor:=0x0000
	$defaultStyles.tableFrame.left.padding:=0
	$defaultStyles.tableFrame.top.lineWidth:=kPrint_1PixelLine
	$defaultStyles.tableFrame.top.lineStyle:=Border Plain:K42:28
	$defaultStyles.tableFrame.top.lineColor:=0x0000
	$defaultStyles.tableFrame.top.padding:=0
	$defaultStyles.tableFrame.right.lineWidth:=kPrint_1PixelLine
	$defaultStyles.tableFrame.right.lineStyle:=Border Plain:K42:28
	$defaultStyles.tableFrame.right.lineColor:=0x0000
	$defaultStyles.tableFrame.right.padding:=0
	$defaultStyles.tableFrame.bottom.lineWidth:=kPrint_1PixelLine
	$defaultStyles.tableFrame.bottom.lineStyle:=Border Plain:K42:28
	$defaultStyles.tableFrame.bottom.lineColor:=0x0000
	$defaultStyles.tableFrame.bottom.padding:=0
	
	$defaultStyles.headerFrame:=New object:C1471
	$defaultStyles.headerFrame.left:=New object:C1471
	$defaultStyles.headerFrame.top:=New object:C1471
	$defaultStyles.headerFrame.right:=New object:C1471
	$defaultStyles.headerFrame.bottom:=New object:C1471
	
	$defaultStyles.headerFrame.backgroundColor:=0x00DCDCDC
	$defaultStyles.headerFrame.backgroundColor:=0x00DBDBDB
	$defaultStyles.headerFrame.left.lineWidth:=kPrint_1PixelLine
	$defaultStyles.headerFrame.left.lineStyle:=Border Plain:K42:28
	$defaultStyles.headerFrame.left.lineColor:=0x0000
	$defaultStyles.headerFrame.left.padding:=0
	$defaultStyles.headerFrame.top.lineWidth:=kPrint_1PixelLine
	$defaultStyles.headerFrame.top.lineStyle:=Border Plain:K42:28
	$defaultStyles.headerFrame.top.lineColor:=0x0000
	$defaultStyles.headerFrame.top.padding:=0
	$defaultStyles.headerFrame.right.lineWidth:=kPrint_1PixelLine
	$defaultStyles.headerFrame.right.lineStyle:=Border Plain:K42:28
	$defaultStyles.headerFrame.right.lineColor:=0x0000
	$defaultStyles.headerFrame.right.padding:=0
	$defaultStyles.headerFrame.bottom.lineWidth:=kPrint_1PixelLine
	$defaultStyles.headerFrame.bottom.lineStyle:=Border Plain:K42:28
	$defaultStyles.headerFrame.bottom.lineColor:=0x0000
	$defaultStyles.headerFrame.bottom.padding:=0
	
	$defaultStyles.cellFrame:=New object:C1471
	$defaultStyles.cellFrame.left:=New object:C1471
	$defaultStyles.cellFrame.top:=New object:C1471
	$defaultStyles.cellFrame.right:=New object:C1471
	$defaultStyles.cellFrame.bottom:=New object:C1471
	
	$defaultStyles.cellFrame.backgroundColor:=Background color none:K23:10
	$defaultStyles.cellFrame.left.lineWidth:=kPrint_Hairline
	$defaultStyles.cellFrame.left.lineStyle:=Border Plain:K42:28
	$defaultStyles.cellFrame.left.lineColor:=0x0000
	$defaultStyles.cellFrame.left.padding:=3
	$defaultStyles.cellFrame.top.lineWidth:=kPrint_Hairline
	$defaultStyles.cellFrame.top.lineStyle:=Border Plain:K42:28
	$defaultStyles.cellFrame.top.lineColor:=0x0000
	$defaultStyles.cellFrame.top.padding:=3
	$defaultStyles.cellFrame.right.lineWidth:=kPrint_Hairline
	$defaultStyles.cellFrame.right.lineStyle:=Border Plain:K42:28
	$defaultStyles.cellFrame.right.lineColor:=0x0000
	$defaultStyles.cellFrame.right.padding:=3
	$defaultStyles.cellFrame.bottom.lineWidth:=kPrint_Hairline
	$defaultStyles.cellFrame.bottom.lineStyle:=Border Plain:K42:28
	$defaultStyles.cellFrame.bottom.lineColor:=0x0000
	$defaultStyles.cellFrame.bottom.padding:=3
	
	$defaultStyles.footerFrame:=New object:C1471
	$defaultStyles.footerFrame.left:=New object:C1471
	$defaultStyles.footerFrame.top:=New object:C1471
	$defaultStyles.footerFrame.right:=New object:C1471
	$defaultStyles.footerFrame.bottom:=New object:C1471
	
	$defaultStyles.footerFrame.backgroundColor:=0x00DBDBDB
	$defaultStyles.footerFrame.left.lineWidth:=kPrint_2PixelLine
	$defaultStyles.footerFrame.left.lineStyle:=Border Plain:K42:28
	$defaultStyles.footerFrame.left.lineColor:=0x0000
	$defaultStyles.footerFrame.left.padding:=0
	$defaultStyles.footerFrame.top.lineWidth:=kPrint_2PixelLine
	$defaultStyles.footerFrame.top.lineStyle:=Border Plain:K42:28
	$defaultStyles.footerFrame.top.lineColor:=0x0000
	$defaultStyles.footerFrame.top.padding:=0
	$defaultStyles.footerFrame.right.lineWidth:=kPrint_2PixelLine
	$defaultStyles.footerFrame.right.lineStyle:=Border Plain:K42:28
	$defaultStyles.footerFrame.right.lineColor:=0x0000
	$defaultStyles.footerFrame.right.padding:=0
	$defaultStyles.footerFrame.bottom.lineWidth:=kPrint_2PixelLine
	$defaultStyles.footerFrame.bottom.lineStyle:=Border Plain:K42:28
	$defaultStyles.footerFrame.bottom.lineColor:=0x0000
	$defaultStyles.footerFrame.bottom.padding:=0
	
	$defaultStyles.headerContent:=New object:C1471
	$defaultStyles.headerContent.font:="Arial"
	$defaultStyles.headerContent.fontSize:=7
	$defaultStyles.headerContent.fontStyle:=Bold:K14:2
	$defaultStyles.headerContent.fontReduction:=kPrint_NoFontSizeReduction
	$defaultStyles.headerContent.hAlign:=kPrint_HAlignCenter
	$defaultStyles.headerContent.vAlign:=kPrint_VAlignBottom
	$defaultStyles.headerContent.orientation:=Orientation 0°:K42:40
	$defaultStyles.headerContent.mainColor:=0x0000
	$defaultStyles.headerContent.fillColor:=Background color none:K23:10
	$defaultStyles.headerContent.lineWidth:=kPrint_Hairline
	$defaultStyles.headerContent.lineStyle:=Border None:K42:27
	$defaultStyles.headerContent.cornerRadius:=0
	$defaultStyles.headerContent.pictureFormat:=Scaled to fit proportional:K6:5
	
	$defaultStyles.footerContent:=New object:C1471
	$defaultStyles.footerContent.font:="Arial"
	$defaultStyles.footerContent.fontSize:=7
	$defaultStyles.footerContent.fontStyle:=Bold:K14:2
	$defaultStyles.footerContent.fontReduction:=kPrint_NoFontSizeReduction
	$defaultStyles.footerContent.hAlign:=kPrint_HAlignCenter
	$defaultStyles.footerContent.vAlign:=kPrint_VAlignCenter
	$defaultStyles.footerContent.orientation:=Orientation 0°:K42:40
	$defaultStyles.footerContent.mainColor:=0x0000
	$defaultStyles.footerContent.fillColor:=Background color none:K23:10
	$defaultStyles.footerContent.lineWidth:=kPrint_Hairline
	$defaultStyles.footerContent.lineStyle:=Border None:K42:27
	$defaultStyles.footerContent.cornerRadius:=0
	$defaultStyles.footerContent.pictureFormat:=Scaled to fit proportional:K6:5
	
	$defaultStyles.cellNumberContent:=New object:C1471
	$defaultStyles.cellNumberContent.font:="Arial"
	$defaultStyles.cellNumberContent.fontSize:=7
	$defaultStyles.cellNumberContent.fontStyle:=Plain:K14:1
	$defaultStyles.cellNumberContent.fontReduction:=kPrint_NoFontSizeReduction
	$defaultStyles.cellNumberContent.hAlign:=kPrint_HAlignRight
	$defaultStyles.cellNumberContent.vAlign:=kPrint_VAlignBottom
	$defaultStyles.cellNumberContent.orientation:=Orientation 0°:K42:40
	$defaultStyles.cellNumberContent.mainColor:=0x0000
	$defaultStyles.cellNumberContent.fillColor:=Background color none:K23:10
	$defaultStyles.cellNumberContent.lineWidth:=kPrint_Hairline
	$defaultStyles.cellNumberContent.lineStyle:=Border None:K42:27
	$defaultStyles.cellNumberContent.cornerRadius:=0
	$defaultStyles.cellNumberContent.pictureFormat:=Scaled to fit proportional:K6:5
	
	$defaultStyles.cellTextContent:=New object:C1471
	$defaultStyles.cellTextContent.font:="Arial"
	$defaultStyles.cellTextContent.fontSize:=7
	$defaultStyles.cellTextContent.fontStyle:=Plain:K14:1
	$defaultStyles.cellTextContent.fontReduction:=kPrint_NoFontSizeReduction
	$defaultStyles.cellTextContent.hAlign:=kPrint_HAlignLeft
	$defaultStyles.cellTextContent.vAlign:=kPrint_VAlignCenter
	$defaultStyles.cellTextContent.orientation:=Orientation 0°:K42:40
	$defaultStyles.cellTextContent.mainColor:=0x0000
	$defaultStyles.cellTextContent.fillColor:=Background color none:K23:10
	$defaultStyles.cellTextContent.lineWidth:=kPrint_Hairline
	$defaultStyles.cellTextContent.lineStyle:=Border None:K42:27
	$defaultStyles.cellTextContent.cornerRadious:=0
	$defaultStyles.cellTextContent.pictureFormat:=Scaled to fit proportional:K6:5
	
	$defaultStyles.cellDateContent:=New object:C1471
	$defaultStyles.cellDateContent.font:="Arial"
	$defaultStyles.cellDateContent.fontSize:=7
	$defaultStyles.cellDateContent.fontStyle:=Plain:K14:1
	$defaultStyles.cellDateContent.fontReduction:=kPrint_NoFontSizeReduction
	$defaultStyles.cellDateContent.hAlign:=kPrint_HAlignLeft
	$defaultStyles.cellDateContent.vAlign:=kPrint_VAlignCenter
	$defaultStyles.cellDateContent.orientation:=Orientation 0°:K42:40
	$defaultStyles.cellDateContent.mainColor:=0x0000
	$defaultStyles.cellDateContent.fillColor:=Background color none:K23:10
	$defaultStyles.cellDateContent.lineWidth:=kPrint_Hairline
	$defaultStyles.cellDateContent.lineStyle:=Border None:K42:27
	$defaultStyles.cellDateContent.cornerRadius:=0
	$defaultStyles.cellDateContent.pictureFormat:=Scaled to fit proportional:K6:5
	
End if 

If (Count parameters:C259>2)
	$styles:=mergeObjects($3; $defaultStyles)
Else 
	$styles:=$defaultStyles
End if 

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

C_OBJECT:C1216($oDoc; $oPage; $oStencil; $oTable; $oData)

$cTableData:=New collection:C1472

SET PRINT PREVIEW:C364(True:C214)

$oDoc:=Print_NewDocument(kPrint_AskForSettings)

If ($oDoc#Null:C1517)
	
	PTable_AddStylesToDocument($oDoc)
	
	// create default styles
	
	//Print_NewStyle_Frame ($oDoc;"TableFrameStyle";kPrint_Left;kPrint_1PixelLine;Border Plain;0x0000;0;Background color none)
	//Print_NewStyle_Frame ($oDoc;"TableFrameStyle";kPrint_Top;kPrint_1PixelLine;Border Plain;0x0000;0)
	//Print_NewStyle_Frame ($oDoc;"TableFrameStyle";kPrint_Right;kPrint_1PixelLine;Border Plain;0x0000;0)
	//Print_NewStyle_Frame ($oDoc;"TableFrameStyle";kPrint_Bottom;kPrint_1PixelLine;Border Plain;0x0000;0)
	
	Print_NewStyle_Frame($oDoc; "TableFrameStyle"; kPrint_Left; $styles.tableFrame.left.lineWidth; $styles.tableFrame.left.lineStyle; $styles.tableFrame.left.lineColor; $styles.tableFrame.left.padding; $styles.tableFrame.backgroundColor)
	Print_NewStyle_Frame($oDoc; "TableFrameStyle"; kPrint_Top; $styles.tableFrame.top.lineWidth; $styles.tableFrame.top.lineStyle; $styles.tableFrame.top.lineColor; $styles.tableFrame.top.padding)
	Print_NewStyle_Frame($oDoc; "TableFrameStyle"; kPrint_Right; $styles.tableFrame.right.lineWidth; $styles.tableFrame.right.lineStyle; $styles.tableFrame.right.lineColor; $styles.tableFrame.right.padding)
	Print_NewStyle_Frame($oDoc; "TableFrameStyle"; kPrint_Bottom; $styles.tableFrame.bottom.lineWidth; $styles.tableFrame.bottom.lineStyle; $styles.tableFrame.bottom.lineColor; $styles.tableFrame.bottom.padding)
	
	//Print_NewStyle_Frame ($oDoc;"HeaderFrameStyle";kPrint_Left;kPrint_1PixelLine;Border Plain;0x0000;0;0x00DCDCDC)
	//Print_NewStyle_Frame ($oDoc;"HeaderFrameStyle";kPrint_Top;kPrint_1PixelLine;Border Plain;0x0000;0)
	//Print_NewStyle_Frame ($oDoc;"HeaderFrameStyle";kPrint_Right;kPrint_1PixelLine;Border Plain;0x0000;0)
	//Print_NewStyle_Frame ($oDoc;"HeaderFrameStyle";kPrint_Bottom;kPrint_1PixelLine;Border Plain;0x0000;0)
	
	Print_NewStyle_Frame($oDoc; "HeaderFrameStyle"; kPrint_Left; $styles.headerFrame.left.lineWidth; $styles.headerFrame.left.lineStyle; $styles.headerFrame.left.lineColor; $styles.headerFrame.left.padding; $styles.headerFrame.backgroundColor)
	Print_NewStyle_Frame($oDoc; "HeaderFrameStyle"; kPrint_Top; $styles.headerFrame.top.lineWidth; $styles.headerFrame.top.lineStyle; $styles.headerFrame.top.lineColor; $styles.headerFrame.top.padding)
	Print_NewStyle_Frame($oDoc; "HeaderFrameStyle"; kPrint_Right; $styles.headerFrame.right.lineWidth; $styles.headerFrame.right.lineStyle; $styles.headerFrame.right.lineColor; $styles.headerFrame.right.padding)
	Print_NewStyle_Frame($oDoc; "HeaderFrameStyle"; kPrint_Bottom; $styles.headerFrame.bottom.lineWidth; $styles.headerFrame.bottom.lineStyle; $styles.headerFrame.bottom.lineColor; $styles.headerFrame.bottom.padding)
	
	//Print_NewStyle_Frame ($oDoc;"CellFrameStyle";kPrint_Left;kPrint_Hairline;Border Plain;0x0000;3;Background color none)
	//Print_NewStyle_Frame ($oDoc;"CellFrameStyle";kPrint_Top;kPrint_Hairline;Border Plain;0x0000;3)
	//Print_NewStyle_Frame ($oDoc;"CellFrameStyle";kPrint_Right;kPrint_Hairline;Border Plain;0x0000;3)
	//Print_NewStyle_Frame ($oDoc;"CellFrameStyle";kPrint_Bottom;kPrint_Hairline;Border Plain;0x0000;3)
	
	Print_NewStyle_Frame($oDoc; "CellFrameStyle"; kPrint_Left; $styles.cellFrame.left.lineWidth; $styles.cellFrame.left.lineStyle; $styles.cellFrame.left.lineColor; $styles.cellFrame.left.padding; $styles.cellFrame.backgroundColor)
	Print_NewStyle_Frame($oDoc; "CellFrameStyle"; kPrint_Top; $styles.cellFrame.top.lineWidth; $styles.cellFrame.top.lineStyle; $styles.cellFrame.top.lineColor; $styles.cellFrame.top.padding)
	Print_NewStyle_Frame($oDoc; "CellFrameStyle"; kPrint_Right; $styles.cellFrame.right.lineWidth; $styles.cellFrame.right.lineStyle; $styles.cellFrame.right.lineColor; $styles.cellFrame.right.padding)
	Print_NewStyle_Frame($oDoc; "CellFrameStyle"; kPrint_Bottom; $styles.cellFrame.bottom.lineWidth; $styles.cellFrame.bottom.lineStyle; $styles.cellFrame.bottom.lineColor; $styles.cellFrame.bottom.padding)
	
	//Print_NewStyle_Frame ($oDoc;"FooterFrameStyle";kPrint_Left;kPrint_2PixelLine;Border Plain;0x0000;0;0x00DCDCDC)
	//Print_NewStyle_Frame ($oDoc;"FooterFrameStyle";kPrint_Top;kPrint_2PixelLine;Border Plain;0x0000;0)
	//Print_NewStyle_Frame ($oDoc;"FooterFrameStyle";kPrint_Right;kPrint_2PixelLine;Border Plain;0x0000;0)
	//Print_NewStyle_Frame ($oDoc;"FooterFrameStyle";kPrint_Bottom;kPrint_2PixelLine;Border Plain;0x0000;0)
	
	Print_NewStyle_Frame($oDoc; "FooterFrameStyle"; kPrint_Left; $styles.footerFrame.left.lineWidth; $styles.footerFrame.left.lineStyle; $styles.footerFrame.left.lineColor; $styles.footerFrame.left.padding; $styles.footerFrame.backgroundColor)
	Print_NewStyle_Frame($oDoc; "FooterFrameStyle"; kPrint_Top; $styles.footerFrame.top.lineWidth; $styles.footerFrame.top.lineStyle; $styles.footerFrame.top.lineColor; $styles.footerFrame.top.padding)
	Print_NewStyle_Frame($oDoc; "FooterFrameStyle"; kPrint_Right; $styles.footerFrame.right.lineWidth; $styles.footerFrame.right.lineStyle; $styles.footerFrame.right.lineColor; $styles.footerFrame.right.padding)
	Print_NewStyle_Frame($oDoc; "FooterFrameStyle"; kPrint_Bottom; $styles.footerFrame.bottom.lineWidth; $styles.footerFrame.bottom.lineStyle; $styles.footerFrame.bottom.lineColor; $styles.footerFrame.bottom.padding)
	
	//Print_NewStyle_Content ($oDoc;"HeaderContentStyle";"Arial";7;Bold;kPrint_NoFontSizeReduction;kPrint_HAlignCenter;kPrint_VAlignBottom;\
		Orientation 0°;0x0000;Background color none;kPrint_Hairline;Border None;0;Scaled to fit proportional)
	
	//Print_NewStyle_Content ($oDoc;"CellStyleNumber";"Arial";7;Plain;kPrint_NoFontSizeReduction;kPrint_HAlignRight;kPrint_VAlignTop;\
		Orientation 0°;0x0000;Background color none;kPrint_Hairline;Border None;0;Scaled to fit proportional)
	
	//Print_NewStyle_Content ($oDoc;"CellStyleText";"Arial";7;Plain;kPrint_NoFontSizeReduction;kPrint_HAlignLeft;kPrint_VAlignTop;\
		Orientation 0°;0x0000;Background color none;kPrint_Hairline;Border None;0;Scaled to fit proportional)
	
	Print_NewStyle_Content($oDoc; "HeaderContentStyle"; $styles.headerContent.font; $styles.headerContent.fontSize; $styles.headerContent.fontStyle; $styles.headerContent.fontReduction; \
		$styles.headerContent.hAlign; $styles.headerContent.vAlign; $styles.headerContent.orientation; $styles.headerContent.mainColor; $styles.headerContent.fillColor; \
		$styles.headerContent.lineWidth; $styles.headerContent.lineStyle; $styles.headerContent.cornerRadius; $styles.headerContent.pictureFormat)
	
	Print_NewStyle_Content($oDoc; "CellStyleNumber"; $styles.cellNumberContent.font; $styles.cellNumberContent.fontSize; $styles.cellNumberContent.fontStyle; $styles.cellNumberContent.fontReduction; \
		$styles.cellNumberContent.hAlign; $styles.cellNumberContent.vAlign; $styles.cellNumberContent.orientation; $styles.cellNumberContent.mainColor; $styles.cellNumberContent.fillColor; \
		$styles.cellNumberContent.lineWidth; $styles.cellNumberContent.lineStyle; $styles.cellNumberContent.cornerRadius; $styles.cellNumberContent.pictureFormat)
	
	Print_NewStyle_Content($oDoc; "CellStyleText"; $styles.cellTextContent.font; $styles.cellTextContent.fontSize; $styles.cellTextContent.fontStyle; $styles.cellTextContent.fontReduction; \
		$styles.cellTextContent.hAlign; $styles.cellTextContent.vAlign; $styles.cellTextContent.orientation; $styles.cellTextContent.mainColor; $styles.cellTextContent.fillColor; \
		$styles.cellTextContent.lineWidth; $styles.cellTextContent.lineStyle; $styles.cellTextContent.cornerRadius; $styles.cellTextContent.pictureFormat)
	
	Print_NewStyle_Content($oDoc; "CellStyleDate"; $styles.cellDateContent.font; $styles.cellDateContent.fontSize; $styles.cellDateContent.fontStyle; $styles.cellDateContent.fontReduction; \
		$styles.cellDateContent.hAlign; $styles.cellDateContent.vAlign; $styles.cellDateContent.orientation; $styles.cellDateContent.mainColor; $styles.cellDateContent.fillColor; \
		$styles.cellDateContent.lineWidth; $styles.cellDateContent.lineStyle; $styles.cellDateContent.cornerRadius; $styles.cellDateContent.pictureFormat)
	
	Print_NewStyle_Content($oDoc; "FooterContentStyle"; $styles.footerContent.font; $styles.footerContent.fontSize; $styles.footerContent.fontStyle; $styles.footerContent.fontReduction; \
		$styles.footerContent.hAlign; $styles.footerContent.vAlign; $styles.footerContent.orientation; $styles.footerContent.mainColor; $styles.footerContent.fillColor; \
		$styles.footerContent.lineWidth; $styles.footerContent.lineStyle; $styles.footerContent.cornerRadius; $styles.footerContent.pictureFormat)
	
	$oPage:=Print_NewPage($oDoc)
	C_OBJECT:C1216($oHeaderStencil; $oBodyStencil)
	$oHeaderStencil:=PTable_CreateRowStencil(kPTable_Content; 0; 0; 0)
	$oBodyStencil:=PTable_CreateRowStencil(kPTable_Content; 0; 0; 0)
	
	For each ($currColumn; $columnsCollection)
		
		If ($currColumn.isVisible)
			
			If ($currColumn.isCalculated=False:C215)
				
				// PTable_CreateStencilCell ($oHeaderStencil;kPrint_TextFrame;60;kPTable_StyleHeaderCenter;kPTable_CellStyleBlack)
				PTable_CreateStencilCell($oHeaderStencil; kPrint_TextFrame; 60; "HeaderContentStyle"; "CellFrameStyle")
				
				Case of 
						
					: ($currColumn.dataType=Is real:K8:4)
						
						$alignment:="CellStyleNumber"
						
					: ($currColumn.dataType=Is text:K8:3)
						
						$alignment:="CellStyleText"
						
					: ($currColumn.dataType=Is boolean:K8:9)
						
						$alignment:="CellStyleText"
						
					: ($currColumn.dataType=Is date:K8:7)
						
						$alignment:="CellStyleDate"
						
					Else 
						
						$alignment:="CellStyleText"
						
				End case 
				
				// PTable_CreateStencilCell ($oBodyStencil;kPrint_TextFrame;60;$alignment;kPTable_CellStyleBlack)
				PTable_CreateStencilCell($oBodyStencil; kPrint_TextFrame; 60; $alignment; "CellFrameStyle")
				
			End if 
		End if 
	End for each 
	
	
	//Create a new table and position it at the top left of the page
	// $oTable:=PTable_NewTable ($oPage;True;2;kPTable_TableRegionStyleBlack;kPTable_HeaderRegionStyleRed;\
		kPTable_HeaderRegionStyleGreen;kPTable_HeaderRegionStyleBlue)
	
	$oTable:=PTable_NewTable($oPage; True:C214; 2; "TableFrameStyle"; "HeaderFrameStyle"; \
		"CellFrameStyle"; "FooterFrameStyle")
	
	Print_SetFramePosition($oTable; Print_MarginLeft($oPage); Print_MarginTop($oPage))
	
	$i:=0
	
	For each ($currColumn; $columnsCollection)
		If ($currColumn.isVisible)
			If ($currColumn.isCalculated=False:C215)
				$i:=$i+1
				PTable_SetStencilCellText($oHeaderStencil; $i; $currColumn.title)
			End if 
		End if 
	End for each 
	
	PTable_AppendRowFromStencil($oDoc; $oTable; $oHeaderStencil; kPTable_Header)
	
	// build data
	$rowCounter:=0
	
	For each ($rowData; $dataCollection)
		
		$i:=0
		
		For each ($currColumn; $columnsCollection)
			
			If ($currColumn.isVisible)
				
				If ($currColumn.isCalculated=False:C215)
					
					$i:=$i+1
					
					Case of 
							
						: ($currColumn.dataType=Is real:K8:4)
							
							If ($currColumn.format#"")
								$dataString:=String:C10($rowData[$currColumn.propertyName]; $currColumn.format)
							Else 
								$dataString:=String:C10($rowData[$currColumn.propertyName])
							End if 
							
							
						: ($currColumn.dataType=Is longint:K8:6)
							
							C_LONGINT:C283($integer)
							$integer:=$rowData[$currColumn.propertyName]
							$dataString:=String:C10($integer; "###,###,##0")
							
							
						: ($currColumn.dataType=Is text:K8:3)
							
							$dataString:=$rowData[$currColumn.propertyName]
							
							
						: ($currColumn.dataType=Is boolean:K8:9)
							
							If ($rowData[$currColumn.propertyName]=True:C214)
								$dataString:="True"
							Else 
								$dataString:="False"
							End if 
							
							
						: ($currColumn.dataType=Is date:K8:7)
							
							C_DATE:C307($date)
							$date:=$rowData[$currColumn.propertyName]
							$dataString:=String:C10($date; System date short:K1:1)
							// $dataString:=String(Year of($date);"####")+"-"+String(Month of($date);"0#")+"-"+String(Day of($date);"0#")
							
						: ($currColumn.dataType=Is time:K8:8)
							
							C_TIME:C306($myTime)
							$myTime:=$rowData[$currColumn.propertyName]
							$dataString:=String:C10($date; System time short:K7:9)
							
						Else 
							
							// nothing, either picture or collection or object
							
					End case 
					
					PTable_SetStencilCellText($oBodyStencil; $i; $dataString)
					
				End if 
				
			End if 
			
		End for each 
		
		PTable_AppendRowFromStencil($oDoc; $oTable; $oBodyStencil; kPTable_Body)
		
		
		$rowCounter:=$rowCounter+1
		
	End for each   // rows
	
	
	//Place the table on the page
	Repeat 
		
		$oTable:=PTable_Finalize($oDoc; $oPage; $oTable; Print_MarginBottom($oPage))
		
		If ($oTable#Null:C1517)
			C_OBJECT:C1216($oPreviousPage)
			$oPreviousPage:=$oPage
			$oPage:=Print_NewPage($oDoc)
			Print_MoveFrameToParent($oTable; $oPreviousPage; $oPage)
			Print_SetFramePosition($oTable; Print_MarginLeft($oPage); Print_MarginTop($oPage))
			
		End if 
		
	Until ($oTable=Null:C1517)
	
	Print_PrintDocument($oDoc)
	
End if 
