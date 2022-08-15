handleNameEntryField(Self:C308)
makeThirdPartyName
sl_handleThirdPartiesScreening(sl_ThirdPartiesPerson+sl_ForInputBox)
//C_TEXT($name)
//C_OBJECT($data)
//$name:=makeFullName([ThirdParties]FirstName; [ThirdParties]LastName)
//$data:=New object
//$data.pointers:=New object
//$data.options:=New object
//$data.pointers.resultIconPtr:=->latestCheckStatus1
//$data.options.namePartsFilled:=([ThirdParties]FirstName#"") & ([ThirdParties]LastName#"")
//If ([ThirdParties]ThirdPartiesID="")
//[ThirdParties]ThirdPartiesID:=makeThirdPartiesID
//End if
//sl_handlePersonNameCompliance(False; $name; ->[ThirdParties]ThirdPartiesID; $data)