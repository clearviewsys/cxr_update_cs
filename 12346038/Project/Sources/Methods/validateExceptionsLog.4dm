//%attributes = {}
checkUniqueKey(->[ExceptionsLog:75]; ->[ExceptionsLog:75]ExceptionLogID:1; "ExceptionLogID")
If ([ExceptionsLog:75]isReviewed:10)
	checkIfNullString(->[ExceptionsLog:75]Remarks:11; "Reviewer's Remarks")
End if 

