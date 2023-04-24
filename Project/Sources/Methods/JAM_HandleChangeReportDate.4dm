//%attributes = {}


If (fromDate>Current date:C33(*))
	fromDate:=Current date:C33(*)
End if 

If (fromDate>toDate)
	toDate:=fromDate
End if 


If (toDate>Current date:C33(*))
	toDate:=Current date:C33(*)
End if 


reportDescription:="GL Report from "+String:C10(fromDate)+" to "+String:C10(toDate)
