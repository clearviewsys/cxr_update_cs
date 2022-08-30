//%attributes = {}
C_LONGINT:C283(vUrgenteWires; vReceivedeWires; vSenteWires; vInbox; vOutbox; vUrgent)

MESSAGES OFF:C175
READ ONLY:C145(*)
ChangeNumberAndNotify(->vUrgenteWires; countUrgenteWires; "Urgent eWire Received")
ChangeNumberAndNotify(->vReceivedeWires; countReceivedeWires; "New eWires Received")
vSenteWires:=countSenteWires
ChangeNumberAndNotify(->vInbox; countReceivedMessages; "")
vOutbox:=countSentMessages
ChangeNumberAndNotify(->vUrgent; countUrgentMessages; "Urgent Message Received")
MESSAGES ON:C181