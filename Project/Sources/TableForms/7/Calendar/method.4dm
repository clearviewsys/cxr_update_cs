C_LONGINT:C283(cal_vMonth; cal_vYear)
ARRAY TEXT:C222(cal_popupMonths; 12)

//If (Form event=On Load )
//cal_setCalendarDate 
//End if 


If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	
	
	
	handleFillMonthlyCalendarArrays(cal_vMonth; cal_vYear)
	cal_monthlyCalendar{cal_monthlyCalendar}:=False:C215  // deselect object
End if 

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Resize:K2:27) | (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))
	C_TEXT:C284($objCalendar)
	C_LONGINT:C283($daysinMonth; $leadingBlocks; $trailingBlocks; $offset; $row5Blocks; $row6Blocks; $row1Blocks)
	$daysInMonth:=cal_getNumberOfDaysInMonth(cal_vMonth; cal_vYear)
	$offset:=cal_getFirstWeekDayNumberOf(cal_vMonth; cal_vYear)
	$row1Blocks:=$offset-1
	$row5Blocks:=7-(35-($offset-1+$daysInMonth))
	$row6Blocks:=7-(42-($offset-1+$daysInMonth))
	If ($row5Blocks>7)
		$row5Blocks:=7
	End if 
	If ($row6Blocks<0)
		$row6Blocks:=0
	End if 
	//$row6Blocks:=$daysInMonth-(7-$leadingBlocks)-28
	
	
	
	C_LONGINT:C283($left; $right; $top; $bottom; $colWidth; $rowHeight)
	$objCalendar:="cal_MonthlyCalendar"
	OBJECT GET COORDINATES:C663(*; $objCalendar; $left; $top; $right; $bottom)
	
	$colWidth:=($right-$left)/7
	$rowHeight:=($bottom-$top)/6
	
	LISTBOX SET COLUMN WIDTH:C833(*; $objCalendar; $colWidth)  // adjust the caldendar column widths
	LISTBOX SET COLUMN WIDTH:C833(*; "cal_Headings"; $colWidth)  // adjust the caldendar column widths
	
	LISTBOX SET ROWS HEIGHT:C835(*; $objCalendar; $rowHeight)  // adjust the row heights
	//MOVE OBJECT(*;"cal_ButtonGrid";$left-1;$top-1;$right+1;$bottom+1;*)  ` reposition the button grid
	
	OBJECT MOVE:C664(*; "cal_Row1Cover"; $left+1; $top+1; ($row1Blocks*$colWidth)+$left-2; ($rowHeight+$top-1); *)
	OBJECT MOVE:C664(*; "cal_Row5Cover"; ($colWidth*$row5Blocks)+$left+1; $top+($rowHeight*4)+1; (7*$colWidth)+$left-1; ($rowHeight*6+$top-1); *)
	OBJECT MOVE:C664(*; "cal_Row6Cover"; ($colWidth*$row6Blocks)+$left+1; $top+($rowHeight*5)+1; (7*$colWidth)+$left-1; ($rowHeight*6+$top-1); *)
	
	
End if 