//%attributes = {}
// FJ_IsCashOver ($threshold)

// Cash Transactions Report(CTR)i.e.any transaction with a cash component of
// Fiji $10,000 and above or its equivalent in foreign currency (FTR Act Part 3: Section 13.1 
// and FTR Regulations Part 1 & Part 3). For the purposes of reporting requirements under the FTR Act, 
// "cash" includes bank drafts, bank cheques, bearer bonds, traveler’s cheques, postal notes and money orders.



C_REAL:C285($1; $threshold)

C_REAL:C285($tot)
C_BOOLEAN:C305($0; $isCash)

Case of 
	: (Count parameters:C259=1)
		$threshold:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$tot:=0
$isCash:=False:C215

READ ONLY:C145([Accounts:9])
QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)

If ([Accounts:9]isCashAccount:3)
	$isCash:=True:C214
	
	If ([Registers:10]RegisterType:4="Buy")
		$tot:=$tot+[Registers:10]DebitLocal:23
	Else 
		$tot:=$tot+[Registers:10]CreditLocal:24
	End if 
	
End if 


$0:=$isCash & ($tot>$threshold)



