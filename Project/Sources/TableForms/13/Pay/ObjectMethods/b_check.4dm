//C_OBJECT($data)

sl_handleEWiresScreening(sl_eWirePerson+sl_ForSLButton)
//handleCheckeWireBeneficiary("full_sl")
//Case of
//: (Form event code=On Clicked)
//CheckSanctionCheckListSetIcon (True;[eWires]BeneficiaryFullName;False;Table(->[eWires]);[eWires]eWireID;->latestListCheckBeneficiary4)
//handleCustomerNameCompliance (True;[eWires]BeneficiaryFullName;->[eWires]eWireID;->latestListCheckBeneficiary4)

//$data:=New object
//$data.pointers:=New object
//$data.pointers.resultIconPtr:=->latestListCheckBeneficiary4
//sl_handlePersonNameCompliance(True; [eWires]BeneficiaryFullName; ->[eWires]eWireID; $data)
//End case
