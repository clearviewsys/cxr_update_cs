//%attributes = {}
// showRelevant(->[table])

C_POINTER:C301($1)
setErrorTrap("showRelevant")
EXECUTE METHOD:C1007("showRelevant"+Table name:C256($1))
endErrorTrap