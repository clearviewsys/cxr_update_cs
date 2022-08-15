//%attributes = {}
C_TEXT:C284($0; $str)

//appendLabelString (->$str;"Tr.#";[Registers]RegisterID;True)
makeCommentsCheques
If ([Registers:10]isReceived:13)
	appendLabelString(->$str; "We Received"; String:C10([Registers:10]Debit:8; "|Currency")+" "+[Registers:10]Currency:19; True:C214)
	//appendLabelString (->$str;"We Received";String([Registers]Debit)+" "+[Registers]Currency;True)
	//appendLabelString (->$str;"";[Registers]AccountID)
	
Else 
	appendLabelString(->$str; "We Paid"; String:C10([Registers:10]Credit:7; "|Currency")+" "+[Registers:10]Currency:19; True:C214)
	//appendLabelString (->$str;"";[Registers]AccountID)
	
End if 

If ([Registers:10]OurRate:25#1)
	appendLabelString(->$str; "Rate"; String:C10([Registers:10]OurRate:25); True:C214)
	appendLabelString(->$str; "Inv Rate"; String:C10(1/[Registers:10]OurRate:25); True:C214)
End if 
If ([Registers:10]InternalTableNumber:17#Table:C252(->[CashTransactions:36]))
	appendLabelString(->$str; "-"; [Registers:10]Comments:9; True:C214)
End if 

$0:=$str