C_LONGINT:C283($lastcolumn; $columntype)
C_POINTER:C301($hdrvar; $RequestString_ptr; $vSearchText_ptr)
C_OBJECT:C1216($item)
C_TEXT:C284($fldname)
C_LONGINT:C283($iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate; $iMarginOffset; $iAllowanceMargin; $iTotalColumnWidth; $iFormWidth)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.mainlist:=ds:C1482[Form:C1466.whichDataStore].all()
		
		If (Form:C1466.initialUserSearchString#Null:C1517)
			$vSearchText_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "vSearchText")
			$vSearchText_ptr->:=Form:C1466.initialUserSearchString
			pickRecordsvSearchTest_OM
		End if 
		If (Form:C1466.preQueryStr#Null:C1517)
			If (Form:C1466.preQueryStr#"")
				Form:C1466.mainlist:=Form:C1466.mainlist.query(Form:C1466.preQueryStr)
			End if 
		End if 
		$iTotalColumnWidth:=0
		For each ($item; Form:C1466.listbox_columns)
			
			C_POINTER:C301($fldptr)
			$fldptr:=$item.field
			
			$fldname:=Field name:C257($item.field)
			$columntype:=Type:C295($fldptr->)
			
			$lastcolumn:=LISTBOX Get number of columns:C831(*; "mainlist")
			// LISTBOX INSERT COLUMN FORMULA(*;"mainlist";$lastcolumn+1;$fldname;"This."+$fldname;Is text;"hdr_"+$fldname;$hdrvar)
			C_TEXT:C284($formula)
			If ($columntype=Is object:K8:27)
				$formula:="This."+$fldname+"."+$item.objProperty
			Else 
				$formula:="This."+$fldname
			End if 
			LISTBOX INSERT COLUMN FORMULA:C970(*; "mainlist"; $lastcolumn+1; $fldname; $formula; $columntype; "hdr_"+$fldname; $hdrvar)
			
			If ($item.columntitle#Null:C1517)
				OBJECT SET TITLE:C194(*; "hdr_"+$fldname; $item.columntitle)
			Else 
				OBJECT SET TITLE:C194(*; "hdr_"+$fldname; $fldname)
			End if 
			
			//If ($item.format#Null)
			//OBJECT SET format(*;$fldname;$item.format)
			//End if 
			
			If ($item.columntitlestyle#Null:C1517)
				OBJECT SET FONT STYLE:C166(*; "hdr_"+$fldname; $item.columntitlestyle)
			End if 
			
			If ($item.columntitlefont#Null:C1517)
				OBJECT SET FONT:C164(*; "hdr_"+$fldname; $item.columntitlefont)
			End if 
			
			If ($item.columntitlefontsize#Null:C1517)
				OBJECT SET FONT SIZE:C165(*; "hdr_"+$fldname; $item.columntitlefontsize)
			End if 
			
			If ($item.columnstyle#Null:C1517)
				OBJECT SET FONT STYLE:C166(*; $fldname; $item.columnstyle)
			End if 
			
			If ($item.columnfont#Null:C1517)
				OBJECT SET FONT:C164(*; $fldname; $item.columnfont)
			End if 
			
			If ($item.columnfontsize#Null:C1517)
				OBJECT SET FONT SIZE:C165(*; $fldname; $item.columnfontsize)
			End if 
			
			If ($item.width=Null:C1517)
				$item.width:=100  //default
			End if 
			LISTBOX SET COLUMN WIDTH:C833(*; $fldname; $item.width)
			$iTotalColumnWidth:=$iTotalColumnWidth+$item.width
		End for each 
		
		OBJECT SET TITLE:C194(*; "PickButton"; "Pick "+Form:C1466.whichDataStore)
		Form:C1466.searchtextlbl:="Search for "+Form:C1466.whichDataStore
		
		If (Form:C1466.tableLabel#Null:C1517)
			If (Form:C1466.tableLabel#"")
				OBJECT SET TITLE:C194(*; "PickButton"; "Pick "+Form:C1466.tableLabel)
				If (Form:C1466.searchtextlbl="")
					Form:C1466.searchtextlbl:="Search for "+Form:C1466.tableLabel
				End if 
			End if 
		End if 
		
		OBJECT SET ENABLED:C1123(*; "PickButton"; False:C215)
		
		If (Form:C1466.listboxBottom=Null:C1517)
			Form:C1466.listboxBottom:=400
		End if 
		// set objects coordinates based on the total width of the columns and listboxBottom value
		$iMarginOffset:=35
		$iAllowanceMargin:=15  // allowance for margins
		$iFormWidth:=$iTotalColumnWidth+$iMarginOffset
		OBJECT GET COORDINATES:C663(*; "PickerFormName"; $iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)  // primary basis
		OBJECT SET COORDINATES:C1248(*; "mainlist"; $iAllowanceMargin; ($iBottomCoordinate+$iAllowanceMargin); $iFormWidth; Form:C1466.listboxBottom)
		OBJECT GET COORDINATES:C663(*; "vSearchText"; $iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)
		OBJECT MOVE:C664(*; "vSearchText"; $iFormWidth-$iRightCoordinate; 0)
		C_LONGINT:C283($searchWidth)
		$searchWidth:=$iRightCoordinate-$iLeftCoordinate
		OBJECT GET COORDINATES:C663(*; "SearchTextLbl"; $iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)
		OBJECT MOVE:C664(*; "SearchTextLbl"; $iFormWidth-$iRightCoordinate-$searchWidth-$iAllowanceMargin; 0)
		OBJECT GET COORDINATES:C663(*; "vSearchText"; $iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)
		OBJECT MOVE:C664(*; "vSearchText"; $iFormWidth-$iRightCoordinate; 0)
		OBJECT GET COORDINATES:C663(*; "PickButton"; $iLeftCoordinateOk; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)
		OBJECT MOVE:C664(*; "PickButton"; $iFormWidth-$iRightCoordinate; Form:C1466.listboxBottom-$iTopCoordinate+$iAllowanceMargin)
		C_LONGINT:C283($pickWidth)
		$pickWidth:=$iRightCoordinate-$iLeftCoordinateOk
		OBJECT GET COORDINATES:C663(*; "closeButton"; $iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)
		OBJECT MOVE:C664(*; "closeButton"; $iFormWidth-$iRightCoordinate-$pickWidth-$iAllowanceMargin; Form:C1466.listboxBottom-$iTopCoordinate+$iAllowanceMargin)
		OBJECT GET COORDINATES:C663(*; "PickButton"; $iLeftCoordinate; $iTopCoordinate; $iRightCoordinate; $iBottomCoordinate)
		FORM SET VERTICAL RESIZING:C893(True:C214; $iBottomCoordinate+$iAllowanceMargin)
		FORM SET HORIZONTAL RESIZING:C892(True:C214; $iFormWidth)
		
End case 
