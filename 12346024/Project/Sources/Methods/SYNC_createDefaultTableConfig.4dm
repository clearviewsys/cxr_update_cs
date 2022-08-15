//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 08/23/18, 13:18:24
// ----------------------------------------------------
// Method: SYNC_createDefaultTableConfig
// Description
//    idea is to have this method setup the deafult table settings
// master default
// table defaults so that we have a common starting point
//
// Parameters

// state: 0=none, 1=send, 2=receive, 3=send and recieve, 4=send and recieve self, 5=recieve and send origin

// ----------------------------------------------------

//NOTE RUNNING THIS WILL OVERRIDE EXISTING SETTINGS FOR THE TABLE/SITE COMBMINATION


//?? SHOULD WE DELETE ALL PRIOR SETTINGS BEFORE ADDING THESE??? I think we should delete all before adding or check for duplicates


C_POINTER:C301($ptrNil)
myConfirm("This will delete any current table settings. Are you sure you want to continue?")

If (OK=1)
	READ WRITE:C146([Sync_Tables:82])
	ALL RECORDS:C47([Sync_Tables:82])
	DELETE SELECTION:C66([Sync_Tables:82])
	
	myConfirm("Is this a remote or sync server?"; "Remote"; "Sync Server")
	
	If (OK=1)  //-------- SETTINGS FOR A REMOTE SITE -------
		
		//-------- NO SYNCING -----------
		SYNC_addTableSetting($ptrNil; 0)  //master default
		
		SYNC_addTableSetting(->[Currencies:6]; 0)
		SYNC_addTableSetting(->[Accounts:9]; 0)
		SYNC_addTableSetting(->[SubAccounts:112]; 0)
		SYNC_addTableSetting(->[MainAccounts:28]; 0)
		SYNC_addTableSetting(->[SanctionCheckLog:111]; 0)
		
		// ---- 2 WAY SYNCING ----- 
		SYNC_addTableSetting(->[Customers:3]; 3)  // 2 way
		SYNC_addTableSetting(->[LinkedDocs:4]; 3)  // 2 way
		SYNC_addTableSetting(->[Links:17]; 3)  // 2 way
		SYNC_addTableSetting(->[Agents:22]; 3)
		SYNC_addTableSetting(->[Items:39]; 3)
		SYNC_addTableSetting(->[Bookings:50]; 3)
		SYNC_addTableSetting(->[CallLogs:51]; 3)
		SYNC_addTableSetting(->[Denominations:31]; 3)
		SYNC_addTableSetting(->[Users:25]; 3)
		
		// config tables
		SYNC_addTableSetting(->[WireTemplates:42]; 3)
		SYNC_addTableSetting(->[TransferTemplates:54]; 3)
		SYNC_addTableSetting(->[AMLRules:74]; 3)
		SYNC_addTableSetting(->[FeeStructures:38]; 3)
		SYNC_addTableSetting(->[FeeRules:59]; 3)
		SYNC_addTableSetting(->[AMLRules:74]; 3)
		SYNC_addTableSetting(->[Branches:70]; 3)
		SYNC_addTableSetting(->[CalendarEvents:80]; 3)
		SYNC_addTableSetting(->[KeyValues:115]; 3)
		SYNC_addTableSetting(->[CommonLists:84]; 3)
		SYNC_addTableSetting(->[CSMRelations:89]; 3)
		SYNC_addTableSetting(->[PictureIDTypes:92]; 3)
		SYNC_addTableSetting(->[CustomerTypes:94]; 3)
		SYNC_addTableSetting(->[Occupations:2]; 3)
		SYNC_addTableSetting(->[Industries:114]; 3)
		SYNC_addTableSetting(->[FormObjects:120]; 3)
		SYNC_addTableSetting(->[PaymentTypes:116]; 3)
		SYNC_addTableSetting(->[SanctionLists:113]; 3)
		SYNC_addTableSetting(->[Privileges:24]; 3)
		
		// -------- 1 WAY SYNCING -------- transactional tables
		SYNC_addTableSetting(->[Invoices:5]; 1)  // send
		SYNC_addTableSetting(->[Registers:10]; 1)  // send
		SYNC_addTableSetting(->[CashTransactions:36]; 1)  // send
		SYNC_addTableSetting(->[Cheques:1]; 1)  // send
		SYNC_addTableSetting(->[Wires:8]; 1)  // send
		SYNC_addTableSetting(->[ItemInOuts:40]; 1)  // send
		SYNC_addTableSetting(->[eWires:13]; 1)  // send
		SYNC_addTableSetting(->[AccountInOuts:37]; 1)  // send
		SYNC_addTableSetting(->[TellerProofLines:79]; 1)  // send
		SYNC_addTableSetting(->[TellerProof:78]; 1)  // send
		
		SYNC_addTableSetting(->[Orders:95]; 1)  // send
		SYNC_addTableSetting(->[OrderLines:96]; 1)  // send
		SYNC_addTableSetting(->[ThirdParties:101]; 1)  // send
		
	Else   //sync server
		
		
		//-------- NO SYNCING -----------
		SYNC_addTableSetting($ptrNil; 0)  //master default
		
		SYNC_addTableSetting(->[Currencies:6]; 0)
		SYNC_addTableSetting(->[Accounts:9]; 0)
		SYNC_addTableSetting(->[SubAccounts:112]; 0)
		SYNC_addTableSetting(->[MainAccounts:28]; 0)
		SYNC_addTableSetting(->[SanctionCheckLog:111]; 0)
		
		// ---- 2 WAY SYNCING ----- 
		SYNC_addTableSetting(->[Customers:3]; 3)  // 2 way
		SYNC_addTableSetting(->[LinkedDocs:4]; 3)  // 2 way
		SYNC_addTableSetting(->[Links:17]; 3)  // 2 way
		SYNC_addTableSetting(->[Agents:22]; 3)
		SYNC_addTableSetting(->[Items:39]; 3)
		SYNC_addTableSetting(->[Bookings:50]; 3)
		SYNC_addTableSetting(->[CallLogs:51]; 3)
		SYNC_addTableSetting(->[Denominations:31]; 3)
		SYNC_addTableSetting(->[Users:25]; 3)
		
		// config tables
		SYNC_addTableSetting(->[WireTemplates:42]; 3)
		SYNC_addTableSetting(->[TransferTemplates:54]; 3)
		SYNC_addTableSetting(->[AMLRules:74]; 3)
		SYNC_addTableSetting(->[FeeStructures:38]; 3)
		SYNC_addTableSetting(->[FeeRules:59]; 3)
		SYNC_addTableSetting(->[AMLRules:74]; 3)
		SYNC_addTableSetting(->[Branches:70]; 3)
		SYNC_addTableSetting(->[CalendarEvents:80]; 3)
		SYNC_addTableSetting(->[KeyValues:115]; 3)
		SYNC_addTableSetting(->[CommonLists:84]; 3)
		SYNC_addTableSetting(->[CSMRelations:89]; 3)
		SYNC_addTableSetting(->[PictureIDTypes:92]; 3)
		SYNC_addTableSetting(->[CustomerTypes:94]; 3)
		SYNC_addTableSetting(->[Occupations:2]; 3)
		SYNC_addTableSetting(->[Industries:114]; 3)
		SYNC_addTableSetting(->[FormObjects:120]; 3)
		SYNC_addTableSetting(->[PaymentTypes:116]; 3)
		SYNC_addTableSetting(->[SanctionLists:113]; 3)
		SYNC_addTableSetting(->[Privileges:24]; 3)
		
		// -------- 1 WAY SYNCING -------- transactional tables
		SYNC_addTableSetting(->[Invoices:5]; 2)  // RECIEVE
		SYNC_addTableSetting(->[Registers:10]; 2)  // RECIEVE
		SYNC_addTableSetting(->[CashTransactions:36]; 2)  // RECIEVE
		SYNC_addTableSetting(->[Cheques:1]; 2)  // RECIEVE
		SYNC_addTableSetting(->[Wires:8]; 2)  // RECIEVE
		SYNC_addTableSetting(->[ItemInOuts:40]; 2)  // RECIEVE
		SYNC_addTableSetting(->[eWires:13]; 2)  // RECIEVE
		SYNC_addTableSetting(->[AccountInOuts:37]; 2)  // RECIEVE
		SYNC_addTableSetting(->[TellerProofLines:79]; 2)  // RECIEVE
		SYNC_addTableSetting(->[TellerProof:78]; 2)  // RECIEVE
		SYNC_addTableSetting(->[Orders:95]; 2)  // RECIEVE
		SYNC_addTableSetting(->[OrderLines:96]; 2)  // RECIEVE
		SYNC_addTableSetting(->[ThirdParties:101]; 2)  // RECIEVE
		
		
	End if 
End if 

UNLOAD RECORD:C212([Sync_Tables:82])
REDUCE SELECTION:C351([Sync_Tables:82]; 0)

READ ONLY:C145([Sync_Tables:82])