C_TEXT:C284(vSearchText; VQUERYCOMMAND)
C_LONGINT:C283(vCount)

handlePICKSearchVariable(Self:C308; Current form table:C627; ->[eWires:13]eWireID:1; ->[eWires:13]eWireID:1; ->[eWires:13]eWireID:1; ->[eWires:13]securityChallengeCode:75; ->[eWires:13]BeneficiaryFullName:5; ->[eWires:13]SenderName:7; ->[eWires:13]Currency:12; VQUERYCOMMAND)
QUERY SELECTION:C341([eWires:13]; [eWires:13]isCancelled:34=False:C215)
QUERY SELECTION:C341([eWires:13]; [eWires:13]isSettled:23=False:C215)
vCount:=Records in selection:C76([eWires:13])

