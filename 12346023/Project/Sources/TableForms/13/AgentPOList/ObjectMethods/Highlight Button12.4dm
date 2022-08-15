//printAgentPOOutgoing 

C_LONGINT:C283(vShowPrintedeWires)

//$accountID:=vAgentAccountID
//
//selecteWiresSentPendingByAccID (vAgentID;vAgentAccountID)
//
//If (vShowPrintedeWires=1)
//QUERY SELECTION([eWires];[eWires]includedInAgentPO=True)  ` select only the ones that have not been printed already
//End if 


// this next part can be made into a generic module.... mapping a boolean array to a selection just like the way sets work in 4D

//_________________________________________________________________________
// now only add the ones that have been selected here
// go through them and if they are checked add them to the set

C_TEXT:C284($setName; $eWireID)
READ ONLY:C145([eWires:13])
$setName:="$agentPOSet"
CREATE EMPTY SET:C140([eWires:13]; $setName)

C_LONGINT:C283($i; $n)
$n:=LISTBOX Get number of rows:C915(ewr_POListBox)
For ($i; 1; $n)
	$eWireID:=ewr_arreWireID{$i}
	If (ewr_arrIsSelected{$i}=True:C214)  // if there is a checkbox then select the ewire and add it to the set
		QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$eWireID)  // find the matching eWire from eWires
		LOAD RECORD:C52([eWires:13])
		ADD TO SET:C119([eWires:13]; $setName)
	End if 
End for 
USE SET:C118($setName)
// this is where we need to stamp them

CLEAR SET:C117($setName)
//_________________________________________________________________________

rep_printAgentPO_out

