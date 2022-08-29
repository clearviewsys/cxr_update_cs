//%attributes = {}
C_LONGINT:C283(cbValidate)

checkInit
checkAddWarningOnTrue((cbValidate=0); "This tellerproof will be saved as an intraday (as it is not EOD).")
//checkAddWarningOnTrue ((cbValidate=1);"Once you confirm, you won't be able to edit the record. . ")

checkIfEODTellerproofDone
