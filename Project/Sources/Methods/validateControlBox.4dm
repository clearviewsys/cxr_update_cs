//%attributes = {}
checkIfNullString(->[ControlBox:66]portName:2; "Port Name")
checkIfNullString(->[ControlBox:66]baudRate:3; "Baud Rate"; "WARN")
checkIfNullString(->[ControlBox:66]controlFlow:4; "Control Flow"; "WARN")
//checkIfNullString (->[ControlBox]cashier;"Cashier ID")
//checkIfNullString (->[ControlBox]posID;"Pos ID")
checkIfNullString(->[ControlBox:66]commandPath:7; "Command Path")
checkUniqueKey(->[ControlBox:66]; ->[ControlBox:66]ControlBoxID:1; "Control Box ID")

