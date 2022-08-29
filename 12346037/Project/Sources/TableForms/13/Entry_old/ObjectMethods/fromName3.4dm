//If (Form event=On Load )
//RELATE ONE([eWires]LinkID)
//Else 
pickLink(Self:C308)
RELATE ONE:C42([eWires:13]LinkID:8)
[eWires:13]CustomerID:15:=[Links:17]CustomerID:14  // these lines have been moved to the triggers
[eWires:13]SenderName:7:=[Links:17]CustomerName:15


//End if 