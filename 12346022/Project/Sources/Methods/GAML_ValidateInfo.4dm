//%attributes = {}

checkMandatoryField(->reportingEntityID; True:C214; "Entity Id")
checkMandatoryField(->reportingBranchName; True:C214; "Branch name")
checkMandatoryField(->contactSurname; True:C214; "Surname")
checkMandatoryField(->contactGivenName; True:C214; "Given Name")
checkIfDateIsFilled(->initialdate; True:C214; "From Date")
checkIfDateIsInRange(->finaldate; initialdate; Current date:C33(*); True:C214; "To Date")


