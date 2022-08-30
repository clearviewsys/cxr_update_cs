//%attributes = {}
C_POINTER:C301($1; $ptrTable)
C_LONGINT:C283($0; $iPadding)

$ptrTable:=$1

$iPadding:=0

If (True:C214)
	Case of 
			
		: ($ptrTable=(->[Invoices:5]))
			//$iSeqNo:=$iSeqNo-<>STARTINVOICENUMBER
			$iPadding:=<>STARTINVOICENUMBER
		: ($ptrTable=(->[eWires:13]))
			//$iSeqNo:=$iSeqNo-<>STARTEWIRENUMBER
			$iPadding:=<>STARTEWIRENUMBER
		: ($ptrTable=(->[Registers:10]))
			//$iSeqNo:=$iSeqNo-<>STARTREGISTERNUMBER
			$iPadding:=<>STARTREGISTERNUMBER
			
		: ($ptrTable=(->[Users:25]))
			$iPadding:=100
			
		: ($ptrTable=(->[AML_AggrRules:150])) | ($ptrTable=(->[Agents:22])) | ($ptrTable=(->[MainAccounts:28]))\
			 | ($ptrTable=(->[MESSAGES:11]))
			$iPadding:=1000
			
		: ($ptrTable=(->[AML_Reports:119])) | ($ptrTable=(->[CalendarEvents:80])) | ($ptrTable=(->[Relations:154]))\
			 | ($ptrTable=(->[WebEWires:149]))
			$iPadding:=10000
			
		: ($ptrTable=(->[CashInOuts:32])) | ($ptrTable=(->[Branches:70])) | ($ptrTable=(->[Bookings:50]))\
			 | ($ptrTable=(->[ReconciledRows:85])) | ($ptrTable=(->[Branches:70])) | ($ptrTable=(->[AgentAccounts:126]))\
			 | ($ptrTable=(->[AccountInOuts:37])) | ($ptrTable=(->[CallLogs:51])) | ($ptrTable=(->[CashInOuts:32]))\
			 | ($ptrTable=(->[CashTransactions:36])) | ($ptrTable=(->[Cheques:1])) | ($ptrTable=(->[Cities:60]))\
			 | ($ptrTable=(->[Confirmations:153])) | ($ptrTable=(->[ControlBox:66])) | ($ptrTable=(->[Countries:62]))\
			 | ($ptrTable=(->[CSMRelations:89])) | ($ptrTable=(->[Reports:73])) | ($ptrTable=(->[CashTransactions:36]))\
			 | ($ptrTable=(->[IntegrityChecks:48])) | ($ptrTable=(->[ItemCategories:45])) | ($ptrTable=(->[Items:39]))\
			 | ($ptrTable=(->[Letters:52])) | ($ptrTable=(->[LinkedDocs:4])) | ($ptrTable=(->[CommonLists:84]))\
			 | ($ptrTable=(->[Mailboxes:56])) | ($ptrTable=(->[Notifications:158])) | ($ptrTable=(->[Orders:95]))\
			 | ($ptrTable=(->[Shipments:97])) | ($ptrTable=(->[ShipmentLines:98])) | ($ptrTable=(->[FieldConstraints:69]))\
			 | ($ptrTable=(->[TellerProof:78])) | ($ptrTable=(->[LetterTemplates:53])) | ($ptrTable=(->[TransferTemplates:54]))\
			 | ($ptrTable=(->[IM_TransferLog:133])) | ($ptrTable=(->[ZipCodes:63]))
			$iPadding:=100000
			
		: ($ptrTable=(->[ThirdParties:101]))
			$iPadding:=200000
			
		: ($ptrTable=(->[Customers:3])) | ($ptrTable=(->[AML_Alerts:137])) | ($ptrTable=(->[ExceptionsLog:75]))\
			 | ($ptrTable=(->[ImportedRows:91])) | ($ptrTable=(->[ItemInOuts:40])) | ($ptrTable=(->[OrderLines:96]))
			$iPadding:=1000000
			
		: ($ptrTable=(->[RegistersAuditTrail:88])) | ($ptrTable=(->[ReconciledRows:85])) | ($ptrTable=(->[TellerProofLines:79]))
			$iPadding:=10000000
			
		: ($ptrTable=(->[WireTemplates:42]))
			$iPadding:=30000
		Else 
			$iPadding:=0  //assume 
	End case 
End if 

$0:=$iPadding