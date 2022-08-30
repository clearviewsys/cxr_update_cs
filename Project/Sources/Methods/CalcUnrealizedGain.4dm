//%attributes = {}
C_REAL:C285($0)

If ([Registers:10]Debit:8>0)  // buy
	$0:=Round:C94([Registers:10]Debit:8*([Registers:10]SpotRate:26-[Registers:10]OurRate:25); 3)
Else   //sell
	$0:=Round:C94([Registers:10]Credit:7*([Registers:10]OurRate:25-[Registers:10]SpotRate:26); 3)
End if 