//%attributes = {}

checkMandatoryField(->reportingEntityID; True:C214; "Entity Id")
//checkMandatoryField (->reportingBranchName;True;"Branch name")
//checkMandatoryField (->contactEntityName;True;"Entity Name")
//checkMandatoryField (->contactEntityAddress;True;"Entity Address")
checkIfDateIsFilled(->initialdate; True:C214; "From Date")
checkIfDateIsInRange(->finaldate; initialdate; Current date:C33(*); True:C214; "To Date")

