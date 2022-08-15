//%attributes = {}
// creates a record in WebeWires table using classic 4D commands
// returns WebEwireID

C_TEXT:C284($0)

CREATE RECORD:C68([WebEWires:149])
[WebEWires:149]WebEwireID:1:=makeWebEwireID
SAVE RECORD:C53([WebEWires:149])
$0:=[WebEWires:149]WebEwireID:1
UNLOAD RECORD:C212([WebEWires:149])
