//%attributes = {}

C_BOOLEAN:C305($1; $isRemote)

C_POINTER:C301($ptrNil)
C_LONGINT:C283($send; $receive; $sendReceive; $none; $sendSelf; $receiveOrigin)

If (Count parameters:C259>=1)
	$isRemote:=$1
Else 
	$isRemote:=True:C214
End if 

If ($isRemote)
	$none:=0
	$send:=1
	$receive:=2
	$sendReceive:=3
	$sendSelf:=4
	$receiveOrigin:=5
Else   //is Server
	$none:=0
	$send:=2
	$receive:=1
	$sendReceive:=3
	$sendSelf:=5
	$receiveOrigin:=4
End if 


SYNC_addTableSetting($ptrNil; $none)  //master default - NZ/AU/NZ - RECIEVE -- DIFFERS FROM DEFAULT OF NO SYNCING

SYNC_addTableSetting(->[AccountInOuts:37]; $send)
SYNC_addTableSetting(->[Accounts:9]; $none)
SYNC_addTableSetting(->[Agents:22]; $sendReceive)
SYNC_addTableSetting(->[AML_Reports:119]; $send)
SYNC_addTableSetting(->[AMLRules:74]; $sendReceive)
SYNC_addTableSetting(->[Bookings:50]; $sendReceive)
SYNC_addTableSetting(->[Branches:70]; $sendReceive)
SYNC_addTableSetting(->[CalendarEvents:80]; $sendReceive)
SYNC_addTableSetting(->[CallLogs:51]; $sendReceive)
SYNC_addTableSetting(->[CashTransactions:36]; $send)
SYNC_addTableSetting(->[Cheques:1]; $send)
SYNC_addTableSetting(->[Cities:60]; $none)  //???????
SYNC_addTableSetting(->[CommonLists:84]; $sendReceive)
SYNC_addTableSetting(->[Countries:62]; $none)  //??????
SYNC_addTableSetting(->[CSMRelations:89]; $sendReceive)
SYNC_addTableSetting(->[Currencies:6]; $none)
SYNC_addTableSetting(->[Customers:3]; $sendReceive)
SYNC_addTableSetting(->[CustomerTypes:94]; $sendReceive)
SYNC_addTableSetting(->[Denominations:31]; $none)  //????????
SYNC_addTableSetting(->[eWires:13]; $send)
SYNC_addTableSetting(->[ExceptionsLog:75]; $send)
SYNC_addTableSetting(->[FeeRules:59]; $sendReceive)
SYNC_addTableSetting(->[FeeStructures:38]; $sendReceive)
SYNC_addTableSetting(->[FieldConstraints:69]; $sendReceive)
SYNC_addTableSetting(->[FormObjects:120]; $sendReceive)
SYNC_addTableSetting(->[Industries:114]; $sendReceive)
SYNC_addTableSetting(->[Invoices:5]; $send)
SYNC_addTableSetting(->[ItemInOuts:40]; $send)
SYNC_addTableSetting(->[Items:39]; $sendReceive)
SYNC_addTableSetting(->[KeyValues:115]; $sendReceive)
SYNC_addTableSetting(->[LinkedDocs:4]; $sendReceive)
SYNC_addTableSetting(->[Links:17]; $sendReceive)
SYNC_addTableSetting(->[MainAccounts:28]; $none)
SYNC_addTableSetting(->[Occupations:2]; $sendReceive)
SYNC_addTableSetting(->[OrderLines:96]; $send)
SYNC_addTableSetting(->[Orders:95]; $send)
SYNC_addTableSetting(->[PaymentTypes:116]; $sendReceive)
SYNC_addTableSetting(->[PictureIDTypes:92]; $sendReceive)
SYNC_addTableSetting(->[Privileges:24]; $sendReceive)
SYNC_addTableSetting(->[Registers:10]; $sendSelf)
SYNC_addTableSetting(->[Reports:73]; $sendReceive)
SYNC_addTableSetting(->[SanctionCheckLog:111]; $sendReceive)
SYNC_addTableSetting(->[SanctionLists:113]; $sendReceive)
SYNC_addTableSetting(->[ShipmentLines:98]; $send)
SYNC_addTableSetting(->[Shipments:97]; $send)
SYNC_addTableSetting(->[States:61]; $none)  //???????
SYNC_addTableSetting(->[SubAccounts:112]; $none)
SYNC_addTableSetting(->[TellerProof:78]; $send)
SYNC_addTableSetting(->[TellerProofLines:79]; $send)
SYNC_addTableSetting(->[ThirdParties:101]; $sendReceive)
SYNC_addTableSetting(->[TransactionTypes:93]; $sendReceive)
SYNC_addTableSetting(->[TransferTemplates:54]; $sendReceive)
SYNC_addTableSetting(->[Users:25]; $sendReceive)
SYNC_addTableSetting(->[Wires:8]; $send)
SYNC_addTableSetting(->[WireTemplates:42]; $sendReceive)