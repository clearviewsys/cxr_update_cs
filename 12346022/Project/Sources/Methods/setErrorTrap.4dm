//%attributes = {}
// setErrorTrap ( CallerMethodName ;{CallerErrorMessage})

// to end the error trap use : endErrorTrap


C_TEXT:C284(CallerMethod; CallerErrorMessage)
CallerMethod:=$1

Case of 
	: (Count parameters:C259=2)
		CallerErrorMessage:=$2
End case 

ON ERR CALL:C155("ErrorTrap")
