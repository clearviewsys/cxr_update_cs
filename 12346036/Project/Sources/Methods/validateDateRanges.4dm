//%attributes = {}
checkUniqueKey(->[DateRanges:57]; ->[DateRanges:57]DateRangeID:1; "dateRangeID")
checkIfValidDate(->[DateRanges:57]fromDate:2; "From Date")
checkIfValidDate(->[DateRanges:57]toDate:3; "To Date")
checkIfDateIsAfter(->[DateRanges:57]toDate:3; True:C214; [DateRanges:57]fromDate:2; "To Date")

