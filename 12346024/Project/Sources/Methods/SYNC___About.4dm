//%attributes = {}

// Modified by: Barclay Berry (1/27/13)


//Overview
//There are 2 levels of syncing settings
//  1-SYNC component which sets sends/recieves on a site by site basis (SYNC Settings) all table with sync_trigger set
//  2-CurrenyXchanger settings - uses [SYNC_Tables] to track on a dbase by dbase level
//    if a table should sync change
//    Sync States: 0=No Syncing, 1=Send Sync Records, 2=Receive Sync Record, 3=Send/Receive Records

//    set the Control Method in the Sync_Settings dialog (component) to "SYNC_This

//    SYNC_This evaluates each table (SYNC_Tables] to determine if the table/record should be send/recieved
//      this is called by SYNC_Trigger and in the webservice

//SENDING is controled by the trigger -- Sync_Trigger which is a part of the component

//RECIEVING is controlled by Sync Settings (component) --- does the site recieve
//    ultimately the [Sync_Table] settings do not have an affect on this


//current Triggers set
//   Customers/Accounts/Invoices/Registers/

//Unique IDs are critical that they are unique across all dbases unless they share the same _SyncID


//SAMPLE setup #1
//
// Server Dbase (just receiving data)
//  SYNC_Settings -- set sync sites to rec'v and NOT to send
//  [Sync_table] set all tables to Sync State = 2

//Remote Dbase (just sending data)
//  Sync_settings -- set sync sites to Send and NOT rec'v
//  [Sync_table] set all tables to Sync State=1


//SAMPLE setup #2
//
// Server Dbase (receive ALL send Customers)
//  SYNC_Settings -- set sync sites to rec'v and to send
//    [Sync_Tables]Sync_State=2 for [Sync_Tables]Table_No=Table(->[Accounts])
//    [Sync_Tables]Sync_State=2 for [Sync_Tables]Table_No=Table(->[Invoices])
//    [Sync_Tables]Sync_State=2 for [Sync_Tables]Table_No=Table(->[Registers])
//    [Sync_Tables]Sync_State=3 for [Sync_Tables]Table_No=Table(->[Customers])


//Remote Dbase (send ALL receive Customers)
//  Sync_settings -- set sync sites to Send and Rec'v
//    [Sync_Tables]Sync_State=1 for [Sync_Tables]Table_No=Table(->[Accounts])
//    [Sync_Tables]Sync_State=1 for [Sync_Tables]Table_No=Table(->[Invoices])
//    [Sync_Tables]Sync_State=1 for [Sync_Tables]Table_No=Table(->[Registers])
//    [Sync_Tables]Sync_State=3 for [Sync_Tables]Table_No=Table(->[Customers])
