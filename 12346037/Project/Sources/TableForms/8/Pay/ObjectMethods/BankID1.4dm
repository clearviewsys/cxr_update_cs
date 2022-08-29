//C_TEXT($sanctionCheckResult)
//C_LONGINT($match)
//C_POINTER($fieldPtr)
//$fieldPtr:=Self

//If (Form event code=On Data Change)

//$fieldPtr->:=removeEnclosingSpaces(toTitleCase($fieldPtr))
//clearPictureField (->latestListCheckBeneficiary2)
//If (stringHasMinimumLength($fieldPtr->; 4))
//CheckSanctionCheckListSetIcon (False;$fieldPtr->;True;Table(->[Wires]);[Wires]CXR_WireID;->latestListCheckBeneficiary2)
//handleCustomerEntityCompliance(False;$fieldPtr->;->[Wires]CXR_WireID;->latestListCheckBeneficiary2)
//sl_handleCompanyNameCompliance(False; $fieldPtr->; ->[Wires]CXR_WireID; \
New object("pointers"; New object("resultIconPtr"; ->latestListCheckBeneficiary2))\
)
//End if

//End if


// TOTEST: Disabled for a test
//sl_handleWiresScreening(sl_WiresCompany+sl_ForInputBox)
