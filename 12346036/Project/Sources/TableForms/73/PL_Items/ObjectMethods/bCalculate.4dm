//C_LONGINT($tc1;$tc2;$ellapsed)
//C_DATE(vFromDate;vToDate)
//C_TEXT(vBranchID)
//
//$tc1:=Tickcount
//PLItems_fillSummaryRows (vFromDate;vToDate;vBranchID)
//$tc2:=Tickcount
//$ellapsed:=$tc2-$tc1
//
//If ($ellapsed>120)
//ALERT("Ellapsed time: "+String($ellapsed/60;"#####.###"))
//End if 
POST OUTSIDE CALL:C329(Current process:C322)
