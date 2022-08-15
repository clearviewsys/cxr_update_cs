sl_handleThirdPartiesScreening(sl_ThirdPartiesPerson+sl_ForPEPButton)
//If (Form event code=On Clicked)

//C_TEXT($name)
//C_OBJECT($data)
//$name:=makeFullName([ThirdParties]FirstName; [ThirdParties]LastName)
//$data:=New object
//$data.pointers:=New object
//$data.options:=New object
//$data.pointers.resultIconPtr:=->latestCheckStatus1
//$data.options.list:="PEP"
//$data.options.namePartsFilled:=([ThirdParties]FirstName#"") & ([ThirdParties]LastName#"")
//If ([ThirdParties]ThirdPartiesID="")
//[ThirdParties]ThirdPartiesID:=makeThirdPartiesID
//End if
//sl_handlePersonNameCompliance(True; $name; ->[ThirdParties]ThirdPartiesID; $data)
//End if