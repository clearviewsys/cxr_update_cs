//%attributes = {}

checkMandatoryField(->reportingEntityID; True:C214; "Entity Id")
checkMandatoryField(->reportingBranchName; True:C214; "Branch name")
checkMandatoryField(->contactEntityName; True:C214; "Entity Name")
checkMandatoryField(->contactEntityAddress; True:C214; "Entity Address")
checkIfDateIsFilled(->initialdate; True:C214; "From Date")
checkIfDateIsInRange(->finaldate; initialdate; Current date:C33(*); True:C214; "To Date")

