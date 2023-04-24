//%attributes = {}



C_TEXT:C284($contents; $response; $toTest; $method; $encoded)
C_LONGINT:C283($stat)

ARRAY TEXT:C222($aHeaders; 0)
ARRAY TEXT:C222($aValues; 0)

APPEND TO ARRAY:C911($aHeaders; "content type")
APPEND TO ARRAY:C911($aValues; "application/json")
APPEND TO ARRAY:C911($aHeaders; "cxr-version")
APPEND TO ARRAY:C911($aValues; "2022-12-01")
APPEND TO ARRAY:C911($aHeaders; "authorization")

BASE64 ENCODE:C895("cab:123456789"; $encoded)
APPEND TO ARRAY:C911($aValues; "Basic "+$encoded)

SET TEXT TO PASTEBOARD:C523($encoded)


C_OBJECT:C1216($transaction)
C_COLLECTION:C1488($col)


$toTest:="checkSanctions"

Case of 
	: ($toTest="pushTransaction")
		$method:="pushTransaction"
		
		$col:=New collection:C1472
		$transaction:=New object:C1471("currency"; "EUR"; \
			"dr_br_ind"; "D"; "record_id"; "212123121"; "value_date"; "2022-01-01"; "branch_code"; "B1"; \
			"flex_module"; "CashAccount"; "flex_user_id"; "joe"; "exchange_rate"; "100"; "cxr_customer_id"; "CUS10000"; \
			"transaction_id"; "9876543"; "flex_account_id"; "10000-100"; "flex_customer_id"; "120000"; \
			"instruction_code"; "N/A"; "transaction_code"; "N/A"; "transaction_type"; "Cash"; \
			"creation_date_stamp"; "2022-11-15T10:00"; "local_currency_amount"; "1200"; "transaction_date_stamp"; \
			"2022-11-15T10:00"; "foriegn_currency_amount"; "1000")
		
		$col.push($transaction)
		
		$transaction:=New object:C1471("currency"; "EUR"; \
			"dr_br_ind"; "D"; "record_id"; "212123122"; "value_date"; "2022-01-01"; "branch_code"; "B1"; \
			"flex_module"; "CashAccount"; "flex_user_id"; "joe"; "exchange_rate"; "100"; "cxr_customer_id"; "CUS10000"; \
			"transaction_id"; "9876543"; "flex_account_id"; "10000-100"; "flex_customer_id"; "120000"; \
			"instruction_code"; "N/A"; "transaction_code"; "N/A"; "transaction_type"; "Cash"; \
			"creation_date_stamp"; "2022-11-15T10:00"; "local_currency_amount"; "1400"; "transaction_date_stamp"; \
			"2022-11-15T10:00"; "foriegn_currency_amount"; "1200")
		
		$col.push($transaction)
		
		$contents:=JSON Stringify:C1217($col)  //need a sample json file to test with
		
	: ($toTest="checkSanctions")
		$method:="checkSanction"
		$contents:=JSON Stringify:C1217(New object:C1471("properties"; \
			New object:C1471("name"; "ahmed ahmed"; "birthCountry"; "af"); \
			"record"; New object:C1471("id"; "cus12345")))  //
		
		
		$contents:=JSON Stringify:C1217(New object:C1471("properties"; \
			New object:C1471("name"; "Barclay Berry"; "birthCountry"; "us"); \
			"record"; New object:C1471("id"; "")))  //
		
		$contents:=JSON Stringify:C1217(New object:C1471("properties"; \
			New object:C1471("name"; "John Smith"; "birthCountry"; "us"); \
			"record"; New object:C1471("id"; "")))
End case 



$stat:=HTTP Request:C1158(HTTP POST method:K71:2; "http://127.0.0.1:8080/cxr/post/v1/"+$method; $contents; $response; $aHeaders; $aValues)

Case of 
	: ($stat=200)
		
	: ($stat=400)
		
		
	Else 
		
		
End case 