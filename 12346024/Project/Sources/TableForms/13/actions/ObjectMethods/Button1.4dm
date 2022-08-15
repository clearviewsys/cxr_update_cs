C_TEXT:C284($group)

QUERY SELECTION:C341([eWires:13]; [eWires:13]isSettled:23=True:C214; *)  // filter only those who are paid or cancelled
QUERY SELECTION:C341([eWires:13];  | ; [eWires:13]isCancelled:34=True:C214)
READ WRITE:C146([eWires:13])
APPLY TO SELECTION:C70([eWires:13]; [eWires:13]isUnlisted:35:=True:C214)
READ ONLY:C145([eWires:13])
