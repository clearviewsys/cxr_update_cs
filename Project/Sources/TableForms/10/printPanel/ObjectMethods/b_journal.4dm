ACCUMULATE:C303([Registers:10]Debit:8; [Registers:10]Credit:7)
BREAK LEVEL:C302(1)
ACCUMULATE:C303([Registers:10]DebitLocal:23; [Registers:10]CreditLocal:24; [Registers:10]totalFees:30; [Registers:10]tax1_Received:31; [Registers:10]tax2_Received:32; [Registers:10]tax2_Received:32; [Registers:10]tax2_Paid:34)

printTable(->[Registers:10]; "print"; ->[Registers:10]RegisterDate:2; ->[Registers:10]RegisterID:1)
