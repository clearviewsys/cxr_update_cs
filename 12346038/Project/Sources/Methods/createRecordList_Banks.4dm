//%attributes = {}
// createRecordListBanks (short; bank name; url; picture)

C_TEXT:C284($1; $2; $3; $short; $bankName; $url)
C_PICTURE:C286($4; $picture)

Case of 
	: (Count parameters:C259=2)
		$short:=$1
		$bankName:=$2
		
	: (Count parameters:C259=3)
		$short:=$1
		$bankName:=$2
		$url:=$3
		
	: (Count parameters:C259=4)
		$short:=$1
		$bankName:=$2
		$url:=$3
		$picture:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// fir=st make sure the short code doesn't exist

// if it doesn't exist then create it

READ ONLY:C145([List_Banks:134])
QUERY:C277([List_Banks:134]; [List_Banks:134]ShortName:2=$short)

If (Records in selection:C76([List_Banks:134])=0)
	CREATE RECORD:C68([List_Banks:134])
	[List_Banks:134]ShortName:2:=$short
	[List_Banks:134]BankName:3:=$bankName
	[List_Banks:134]URL:5:=$url
	[List_Banks:134]Logo:4:=$picture
	SAVE RECORD:C53([List_Banks:134])
End if 
READ ONLY:C145([List_Banks:134])
