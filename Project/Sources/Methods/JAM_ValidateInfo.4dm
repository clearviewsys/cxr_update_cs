//%attributes = {}

checkIfDateIsFilled(->fromDate; True:C214; "From Date")
checkIfDateIsFilled(->toDate; True:C214; "To Date")
checkIfDateIsInRange(->toDate; fromDate; Current date:C33(*); True:C214; "To Date")
checkMandatoryField(->reportDescription; True:C214; "Report Description")

