
C_TEXT:C284($error)
setErrorTrap("Force Send eWire"; "eWire cannot be sent to Site 'EWIR'")
$error:=Sync_Push_Record(->[eWires:13]; getKeyValue("Settings.eWireSiteID"; "EWIR"))
myAlert($error)
endErrorTrap
