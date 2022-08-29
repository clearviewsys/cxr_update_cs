//%attributes = {"shared":true}
C_POINTER:C301($1)

QUERY:C277([Wires:8]; [Wires:8]CXR_WireID:1="Cash")
C_LONGINT:C283($winRef)
$winRef:=Open form window:C675([Wires:8]; "ViewCash"; Plain window:K34:13)
READ ONLY:C145([Wires:8])
DIALOG:C40([Wires:8]; "ViewCash")
CLOSE WINDOW:C154

