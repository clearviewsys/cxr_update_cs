//%attributes = {}

C_LONGINT:C283($i; $n)
C_LONGINT:C283($tableNum)

C_TEXT:C284($ratexStr; $0)
$ratexStr:=""
READ ONLY:C145([Ratex:58])
READ ONLY:C145([Currencies:6])
$tableNum:=Table:C252(->[Currencies:6])

ALL RECORDS:C47([Ratex:58])
ORDER BY:C49([Ratex:58]; [Ratex:58]LineNo:1)
FIRST RECORD:C50([Ratex:58])

CREATE SET:C116([Currencies:6]; "$selection")

For ($i; 1; Records in selection:C76([Ratex:58]))
	// load the currency code
	RELATE ONE:C42([Ratex:58]CurrencyCode:2)
	
	If ([Ratex:58]FieldNo1:3>0)  // if there's a value then add that field to the ratex field
		$ratexStr:=$ratexStr+RatexifyNum(Field:C253($tableNum; [Ratex:58]FieldNo1:3)->)+CRLF
	Else 
		If ([Ratex:58]FieldNo1:3=0)
			$ratexStr:=$ratexStr+RatexifyNum(0)+CRLF
		End if 
	End if 
	
	If ([Ratex:58]FieldNo2:4>0)  // if there's a value then add that field to the ratex field
		$ratexStr:=$ratexStr+RatexifyNum(Field:C253($tableNum; [Ratex:58]FieldNo2:4)->)+CRLF
	Else 
		If ([Ratex:58]FieldNo2:4=0)
			$ratexStr:=$ratexStr+RatexifyNum(0)+CRLF
		End if 
	End if 
	
	If ([Ratex:58]FieldNo3:5>0)  // if there's a value then add that field to the ratex field
		$ratexStr:=$ratexStr+RatexifyNum(Field:C253($tableNum; [Ratex:58]FieldNo3:5)->)+CRLF
	Else 
		If ([Ratex:58]FieldNo3:5=0)
			$ratexStr:=$ratexStr+RatexifyNum(0)+CRLF
		End if 
	End if 
	
	NEXT RECORD:C51([Ratex:58])
End for 
$0:=$ratexStr
USE SET:C118("$selection")
CLEAR SET:C117("$selection")

