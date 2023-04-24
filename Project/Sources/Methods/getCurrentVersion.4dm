//%attributes = {"publishedWeb":true,"publishedSoap":true,"publishedWsdl":true,"shared":true}
#DECLARE->$versionString

var $versionObject : Object

// C_TEXT($0)
// $0:=getMajorVersion+getBuild

$versionObject:=getVersions  // get information from JSON file in Resources folder

If ($versionObject#Null:C1517)
	// $versionString:=$versionObject.version+" build "+String($versionObject.buildNumber)
	$versionString:=$versionObject.version+" b"+String:C10($versionObject.buildNumber)
Else 
	$versionString:=getMajorVersion+getBuild
End if 


// add comments to getBuild from now on UNLESS the major version is changed e.g 4.800 becomes 4.900


// 4.034 B
// added more compression to pict in structure save options
// updated sync component - tracks sync attempts and gives up after 4
// sync component wont' try to sync records over 5 MB
// added more table to ilb browsers accessible with invisible button in sync queue


// 4.033 Beta
// fixed an indexed field that had 256 char instead of 16


// 4.032 Beta
// fixed a bug with email sending from the invoice. 

// 4.031
// Wire Disclaimer in Server Preferences
// Electronic receipt (invoices) can now be sent directly from the system
// emails can be send from an email client directly after clicking the invoice. 

// minor modifications to the TT Wire form


// 4.030
// added thumbnail view to customer enlarge picture ID
// added thumbnail view to attached documents
// fixed bug: view fee structure module
// review page has a proper picker for country
// new method for viewing remote profits for branches (live)
// fixed buy: deleting a privilege won't throw a syntax error


// 4.022 Beta
// transfer template synchronizable


// 4.021 Beta 
// tellerproof discrepancies throw an exception now (EOD and Intraday)
// managers and administrators can verify the tellerproof of users without having access to their passwords
// more indexes activated for accounts for faster searching of bank, cash, and pending accounts
// big fix: fixed a bug where linkedDocs wouldn't save the datestamp
// bug fix: the sync init method used to lock the sync preference dialog
// the password dialog now shows if CAPS-LOCK is on (good for remote access) 
// holding the shift while reducing or enlarging the scanned pictures will acclerate the cropping or scaling
// Accounts have no-sync option
// sync_Id is showing for accounts view
// transfer



// - 4.020 Beta
// added a new module ImportedRows
// tellerproof lines now has a primary key
// added more indexed fields to tellerproof lines for speeding up searching
// search for tellerproof module is improved (can now search based on teller, account, and currency)
// field constraints table can now be synchronized
// fee structures can be synchronized
// fee rules can be synchronized
// transferTemplates module can be synchronized
// teller proof lines and tellerproof can be synchronized



// 4.014 Beta
// extended the 24hrs rule to include more days
// fixed an error when picking an account in the cash denomination entry kept blinking
// 24hrs Rule (and beyond) now creates an exception record
// country picker added to wire form and wire template
// creating cross over rates in the currency module names the alias with / instead of -> e.g. USD/EUR
// serverprefs can now be saved and loaded as an xml file to simplify a consistent setup accross branches
// customer search form now includes creation date, created by, modification date, modified by
// the button 'find large customer IDs' only searches within selection
// the button 'find large customer IDs' only searches within selection


// 4.013 Beta
// fixed some bugs in the display of (reconciliation module)
// tweaked the look of the LinkedDocs entry form
// putting customers on hold will now create an exception record. 
// putting customers off hold will now create an exception record

// 4.012 Beta
// major bug introduced in 4.010 and 011 where the customer entry form method was commented out
// resulting customer id to be blank and
// pages of customer entry changed for better readability and better linkedDocs attachments
// customer entry form is completely revamped. requires futher testing with attaching documents and stuff
// improved the look and feel of the Sync Prefs, updated the form method for Sync Q
// added Users and Privileges to list of synchronizable tables
// 

// 4.010 Beta
// Quick Fix to customer pull down entry - error in entering customer profile. 

// 4.010 Beta
// added apply and browsing buttons to the attached document edit form
// added apply and browsing buttons to country edit
// exception Logs can now be synchronized
// fixed a bug in the customer edit caused by the dropdown menu that populates the company names
//  the bug was introduced in version 4.00x and is now identified and fixed. 
// the edit button remembers the highlighted selection after the edit is complete
// viewing the live cash balances for multi-branch ops has been improved (not admin anymore)
// there is now two buttons for viewing cash balances or a specific account by query

// 4.009 Beta
// fixed a bug in reconciliation module for filtering branch
// customer entry has a new page for company information
// fixed a bug where picking a country would only bring the code

// 4.008 Beta
// The Company Entry page has a new look with a new field for adding the company's nature of business
// fixed a bug with the country picker

// 4.007
// Barclay: The Sync Q shows two more columns for table and error detail

// 4.006 Beta
// compiled and fixed minor issues with the code
// created a picture compression routine for additional tables. 
// added a button in attached documents to search by size. 
// added a feature to Integrity menu to compress all attached documents. 
// added a branchID filter in the reconciliation module


// 4.005 Beta
// bug fix: fixed the bug with batch restrict denominations and improved it
// bug fix: account balances from the dropdown menu was giving a syntax error
// bug fix: displaying the cities form will not crash when showing all records
// module CSMRelations fully functional with search
// can now add relations and connections from the customer's entry form
// have a country picker that will check if the country is put on hold
// the country list can have risk ratings assigned to it. 


// improved the put customers on hold action
// improved the entry form for customer interrelationships
// 
// putting customers on hold (or off hold) in batch will create an exception record
// 

// 4.004 Beta
// changed the buttons look on most tooldbars
// added cities, countries, and states to the sync
// added currency denominations to the sync module
// batch method to put customers on hold
// batch method to restrict denominations

//4.003 Beta 
// CUSTOMERS MODULE:  
// company name gets normalized by taking leading and extra spaces off
// can now have a company created with multiple contacts working for that company
// can now select the name of the company from a dropdown menu instead of entering it manually
// extra apaces between first name and middle name will be automatically stripped off
// start all customer number from 100'000
// added a 'is Company' column to the customer module to be able to identify the companies at a glance
// search for company has been improved to include companies and individual names so when we type

// 4.002 Beta
// bug fix: won't require to do any profile validation (review) on walk-in customers
// bug fix: display of today's audit trail and date ranged ones
// bookings can now be printed - as a quote or confirmed booking
// added a column (on hold) to customer picker and customers list
// added a big ON HOLD stamp on customer pickup page, in case the customer is put on hold
// added a find duplicate register button in registers module(by sync ID, register ID, and reference ID)
// added a find duplicate customers by sync_Id option 
// new module: customers interrelations to each other (AML and KYC)
// customers can be linked based on nature of relationship (joint account, membership, same address) 

// new features for editing a picture ID (picture can now be moved around)
// improved: the secondary picture ID or attached documents has a better interface with unique system ID
// improved: the image editor now can move images in all directions



// 4.001 Beta
// added a web timout in the preferences
// the comment generation for cash transaction is improved for the English language
// the rate and inverse will will not be editable if the user is not allowed to edit rate
// ... allowing the invoice entry to be easier as it requires less tabs to get to the other fields
// picture IDs can now be reduced in size.
// customer pr file can now be reviewed directly in the Entry form. 
// made referenceID and SubAccount searchable for cheque, accountInOuts, Wire...
// improved the search method for all modules to search by referenceNo and sub-AccountID
// created an exception log table
// when saving customer information, if there's anything missing from the customer info, it will be saved in the exception log
// new about splash screen. 
// new interface form for viewing register records
// added an audit trail module for Registers (Registers Audit Trail) allowing
//     users to view deleted and/or modified registers. Old records will be kept in the system
//     register records have a full history of changes attached to them
// added a column to currency list to display the order of display 
// deleted and/or modified registers can now be restored back to their original state
// bug fix: fixed a bug in searching accountInOuts by account name

// 4.00 Beta
// add 'Rate Inv' column to registers listbox
// added index to cheque ref. in the cheques module to improve the speed of reconciliation
// reconciliation module now displays wire, cheque, and account reference for easier identification of transactions
// registers table is now searchable by sub-account and reference No 

// added sub-account and reference columns to the invoice entry page
// added sub-account and reference columns to the journal listbox
// added sub-account to the INCOMING WIRE form (reference ID will be the wire confirmation no)
// added sub-account to the Cheque Pay and Receive form (reference ID will be the cheque no)
// added sub-account column to the Audit Query result form
// added sub-account, Reference No to TRANSFER form in invoice Page
// added sub-account, Reference No, and Rate Inv to Customer's view page (Register tab)

// Items sold will be used as the sub-account and recorded in the journal registry
// fixed a bug where a record could be saved without a user being logged in the system or as LOCKED user
// checking customer's DOB to be within a reasonable age (no minors allowed).


// Wire Reference will be saved in the journal register
// Wire Sub-Account will be automatically picked as the country the wire is sent to, or else filled manually

// eWire Channel Confirmation and Invoice No,  will be saved in the journal registry in the Reference field
// eWire country will be used as sub-account for the journal - allowing us to see how much we are sending to each country

// holding the shift key while clicking 'New' or 'Edit' will reset the original window position and size

// bug fix: the wire receive form pick Template button didn't open the list; would give an error on occasions
// bug fix: the wire send form had a bug in the pck template button

// improved the look of the listbox view for registers, wire, cheques, bookings


// 3.992
// fixed a bug in the sync_validateRecordCount (brackets missing)
// fixed some esthetic issues
// started work on the exception Log
// double clicking the ledger will display accounts and will now have inverse rates
// added 'reference' to accountsInOut


// 3.990
// integrity check at startup is now optional (and must be set in the client prefs (important change)
// emails about backup failure won't be sent to us anymore. 
// filePaths module didn't display any records during open; now displays all filePaths
// customer module has a duplicate finder
// holding the shift key while opening a window will reset the window position to its center again
// new additions to the compliance page of server settings (preferences)for periodic customer reviews
// new module to review customer profiles when they have not been used or reviewed for a while
// new search method to bring customers that are due for review
// added inverse rates to the currency performance summary
// added inverse rates to the invoice page
// added inverse rates to the subledger list page
// prevent transactions with Expired IDs
// prevent transactions with customer profiles that have not been used for a long time
// expired IDs are not acceptable anymore - (warning is changed into an blocking alert)
// improved sync methods - new buttons to save and view XML bags


//3.978
//SYNC_resyncMissingRecs --- added

//3.977
// moved SYNC_validateRecordCounts to dbase method -- On Backup Startup
// modified SYNC_validateRecordCounts to handle both remote/server and 
// send/receive/send-recieve

//3.976
//changed verify record counts to run after backup. That way remote sites will run even if shutdown


//3.975
//soap method to allow remote site to check in with sync server and verify rec counts
//hmReport initial integration


//3.974
//tweak to sync_monitor --- reporting

//3.973
//added Restore Rec button to [Register]Listbox output form
//modified loadCurrentRecordFromFile so if no primary key set in current record it wouldn't try to change


//3.972
//disable quick report on 64 bit server... not compatible
//began to add web services for sync verification report
//SYNC_sendRecordCount_WS
//SYNC_requestRecordCount
//SYNC_Rpt_integritySummary



//3.971
//sync monitor reporting tweaks
//sync startup/shutdown logging
//open advanced sync preference from sync pref tweaks for reloading from server
//fixed bug in sync preferences where sync_enabled was not displaying properly

//3.970
//added read only to SYNC_Monitor
//added read only to SYNC_Queue and modified "delete" button

//3.969
//added branch id to daily summary in SYNC_Monitor

//3.968
//fixed bug in SYNC_Monitor when creating log file name


//3.967
// modified handleApplyButton
//disabled if transaction level > 1 and validates if it is 1
//adding inv/reg summary email to SYNC_Monitor

//3.966
//added to SYNC_Startup -- XB_SetOption ("Alert";False)  // Modified by: Barclay Berry (9/3/13)
//added double click to iLB_Hook_ObjectMethod to open Sync queue records
//added SYNC_Monitor to restart sync process if bad records crash it
//added summary reports for Invoices and Registers to TXT to make is easier to verify sync counts

//3.965
//added code to Register trigger - now will save the [Register] record to disk befor deleting
//    stores in /Logs/DeletedRegisters/
// ****** need to use lastes API Pack Plugin ********
// if delete register from [Invoice] then <>ApplicationUser is sent to server for logging
//     handleDeleteRowInvoice
//update sync code to completely turn off sync services per Jason


//3.964
//fixed "unique" property on _Sync_ID fields --- HAD TO REMOVE THIS b/c what if 
//   sync not turned on. These will be blanks and will get a dup key error
//fixed  "unique" propert on [Register]RegisterID, [Accounts]AccountID field
//[Wires]CXR_WireID, [eWires]eWireID, [CashTransactions]CashTransactionID

// added isApplyButtonClicked to modifyRecordTable - and to handleApplyButton
//the modifyRecordTable will not "re-validate" transactions on Save

//3.963
//added additional tables to be sync'd
//[AttachedDocuments],[WireTemplates],[Wires],[Cheques],[Bookings],
//[CashTransactions],[eWires],[AccountInOuts],[Currencies], [AMLRules]
//changed [Registers].View screen to be resizable

//modified SYNC_Prep_Dbase4Syncing to be generic-- still needs work/testing
//need to change the "validate transaction" in handleApplyButton


//3.962
// fixed dialog bug in Sync_Queue


//3.961
//added sync queue dialog/menu
//added exceptions for records in SYNC_This
//fixed misc compiler errors

//3.960
//tweaked sync preferences based on info from Jason

//3.959
//added more sync preferences
//added SYNC_Restart -- execute on server property -- so we can reload and restart the sync server from client

//3.958
//changed: moved sync setup and preferences into it's own dialog - [Forms]SyncSetup
//changed: added coded to suspend syncing while making modifications to the sync settings
//changed: Sync_Startup and Sync_Exit to be "execute on server"


// 3.957
// fixed: a bug when cropping a picture in the customers entry form
// changed: the default when turning the sync on goes to no-sync
// changed: the login window will always appear in the middle of the page


// 3.955
// fixed: printing thermalLogo form had a bug that printed a large blank space below the invoice 
// fixed: a bug when clicking 'enlarge picture' in the customer view form would throw a syntax errir
// fixed: printing on thermal receipt printer had a bug which is fixed
// improved: the picture editing now allows better editing features
// new: can now test the localhost URL from the Support menu



// 3.950
// new feature: allows checking the balance of remote sites and compare with the sync server (HO)
// new feature: can now check the cash balance of all branches in one page (from view->branch cash positions)
// new feature: can now crop an image attached in the picture ID (when in enlarge mode)
// new feature: can make an attached picture ID in greyscale and can also reduce the file size inside 4D
// fixed: adding branch id to wire templates that were converted from old 4D 2004 had a bug
// improved: can now filter Poor KYC in customer's module by any parameter that we want (using AND or OR logic)
// improved: added a little displaimer in the KYC print form (mentioning checks by OFAC, OSFI, and SEMA)

// 3.945
// fixed: a visual bug on the sub-ledger listbox form where the word 'branch' was not aligned properly
// fixed: the french version of the receipt didn't quite print the invoice# in full
// fixed: the beneficiary bank address in the journal auto-comments field was missing the country, state, zip, etc

// improved: added indexing to sync fields to improve the speed of synching
// improved: added a filter by branch Id to currencies
// improved: added a fail-safe validate transaction for invoice SAVE button to prevent possible loss of transaction (due to nested transactions)
// improved: added a check sanction list button on the invoice to check the customer during invoicing (will be automated in the future)
// improved: improved the Audit Query (View Results) which can now be exported to Excel, especially for pivot tables

// new feature: started a new autoreconciler module (un)
// new feature: added a rename for ledger than will reassign all subledgers
// new feature: added unrealized gain column to the general ledger


// 3.930
// fixed: a bug on the denominations enty page that wouldn't allow editing
// fixed: a major bug where you could modify a selection of invoices using the 'Apply' button and if you just
// fixed: a bug in the subledger view where the date range didn't function properly (needs more testing)
// canceled the last entry, it would disregard all changes you made previously

// improved: added the feature of allowing negative quantity in denominations entry
// improved: the load image function now loads images and converts them into JPG while compressing for less storage 
// improved: the customer listbox now displays the main phone, address, and the occupation
// improved: can now make any customer an insider by clicking self (as a checkbox)
// improved: added branchID as a new search field in the audit query editor
// improved: added currency as a new search field in the audit query editior
// improved: added a new checkbox in the audit query editor to allow or filter inside transactions (based on the self flag)
// improved: the audit query editor can now properly filter self customers based on the checkbox to remove inside transactions
// improved: the system now allows editing the 'self' customer


// 3.915
// fixed: renaming an account Id had a bug introduced in version 3.750 where the rename would not work 
// improved: added a 'rename account' feature in the Admin menu. Can be used to merge accounts
// improved: added a disclaimer on the KYC report mentioning that the checks are done by CurrencyXchanger
// improved: export to globalware is revamped
// improved: merge customers is improved with a customer picker dialog 

// 3.912
// fixed: a bug introduced in 3.910 when picking an account as a menthod of selection in the invoice module

// 3.911
// fixed: a bug when deleting teller proof lines

// 3.910
// improved: added AccountNo as a search field for the customer search form
// improved: printing reports from the report menu is asynchronous, more than 1 report can now printed at any time. 

// fixed: a bug in the customers VIEW page- when the date range was checked the customer record would select the wrong record
// fixed: a bug where the report 'account positions' would give the wrong total positions (at the end of the report
// fixed: when sending a TT wire form: the account number was replaced with swift code
// fixed: when picked the account method of in invoice it was not always working properly
// fixed: when we receive or pay by wire there was a empty account selection window popping up
// fixed: on the invoice entry the date for AML reporting could not be entered
// fixed: on the sub ledger, we were not able to double click on the invoices to open them
// fixed: the picker form (for customers and accounts) had a bug when using the Pick button instead of double-clicking
// fixed: printing the denominations in & out report would throw a runtime error


// 3.900 
// new feature: added a new checkbox in all listbox forms to continue searching withing last result
//              having the effect of the 'AND' logic when searching consecutively
// improved: audit query editor now filters accounts and @ can be used as a wildcard
// improved: account reconcilation has many new features 
// improved: the speed of reconciliation has been improved (especially for large accounts)
// improved: added three buttons in reconciliation
// improved: can hide already reconciled rows
// improved: can hide unreconciled rows
// improved: added sum of unrealized gain for each account in the subledger listbox 
// improved: revamped the subledger view and added unrealized gains column
// improved: added printable notes to the invoice listbox
// improved: the denominations Log module is improved by adding filters for date range
// bug fixed: the client prefs window resize problem (buttons didn't move correctly)
// bug fixed: a minor issue where the date range window would hide behind the front window (now is brought to the font)
// bug fixed: an issue when printing using thermal_receipt print formal (bug introduced in version 3.800)
// bug fixed: subledger view Export button didn't work; replaced with a EXPORT to HTML button
// bug fixed: fixed a bug in the Audit query editor where it didn't filter account IDs properly (major)


// 3.850 - 
// improved the customer view by adding a new tab (registers transactions)
// streamlined the customer view form by cleaning the fields
// added new buttons to customer view tabs to Create, Edit, Print, Export to HTML
// fixed a bug introduced a couple of version ago when clicking on the customer's account tab would give an error
// fixed double clicking on invoices, registers, and cheques, and bookings, emessages, links,  in the customer view form
// revamped the customer listbox: separated first and last name, company name, and added unicode so that customer can be sorted by last  name
// major: eWire module upgraded to listbox
// major: links module upgraded ot listbox
// major: updated the wire template module to listbox
// major: updated the callogs to listbox
// major: update the eMessage to listbox
// fixed search inside calllogs (didn't work)
// fixed the branch ID for calllogs
// added a new toolbar form
// now customer related listboxes (inside the view form) can be printed and also exported to HTML

// 3.800 - modules now open one window only even if you click multiple times on them (just like in the early versions)
// accounts now has a new checkbox for omitting in the positions report (not implemented at the report level)
// unrealized gain field added to registers to see how much unrealized profit is there, also in the invoice
// the edit buttons are now handled via transactions (with support for multi-level transactions)
// currencies update should update the date and time stamp
// if warn for negative inventory is clicked, the system won't allow short-selling
// the wire forms have been updated to include wire reference and reason for transaction
// the wire template is now properly mapping reason for transactions 
// added city, state, zip, country to wire forms to be consistent with FINTRAC requirements (but need to add the fields to forms)
// cash transactions now can be edited without entering denominations entry
// created a new report for printing KYC page on a customer
// support password and designer password changed
// windows now remember their last positions and size
// export of accounts (subledger) can now properly display the name of accounts (bug introduced when the subled-ger became hierarchical)
// can now display the subledger accounts in hierarchical or non-hierarchical 
// a new checkbox in the currencies preventing shortselling
// Main Ledger accounts listbox implemented 
// export for globalware accounting software added - 
// each branch will print their own address on the receipt instead of the main address and phone
// wire beneficiary name now gets cross checked with sanction watchlist (OFAC or OSFI)
// bug fix: risk rating in customer's profile remembers the settings
// updated the wire template to include separate beneficiary address, city, state, zip
// update the pay wire form full address
// added a new position report with a query by example search
// added a new position report button in the compliance query editor
// spot rate can now be correctly adjusted by percentage or by offset
// fixed a bug where the edit was unloading the record. 
// added a universal search area to all new listbox forms (customers, ledger, subledger, currencies, bookings, etc)

// 3.774 - fixed the reconciliation number bug introduced in the previous version, added a value date to bookings (but not active yet)
// 3.773 - the system allows editing of quick cash transactions without entering the denominations now (discrepency)
// 3.772 - fixed the export html bug where related records were not loaded during expport

// 3.771 - removed old transaction code. Added transaction to modifyRecord
// 3.770 - client prefs revamped with bew listbox style
// 3.766 - show relevant invoices (user-centric) 
// 3.765 - can now update the system remotely; touchtable methods for accounts; customers; invoices, and registers
// 
// can now purge the sync data

// 3.762 - can now run methods at runtime from the support menu (designers only)

// 3761 - cheques can now be cleared in the future. If a cheque has a future due date, we can deposit it in the bank 
// today and it will appear in the balance at the correct date. 
// a bug was fixed for wire template picker
// initializing the sync was conditional to activating the sync component but the XML bag would give an error. 
// SYNC_RESET . Sync disabled for accoutns; SYNC: 
// open CXR_SupportFiles directly from the structure file
// no more setting up the root folder
// the FilePaths module is fully working and tested
// Barclay improved the SYNC_This_Table and added a new one for debugging SYNC_get_TableConfig
// writing the RATEX doesn't require 

// 3.751 - the branchID was not being saved in the customers table (multi-user) bug

// 3.750 - can access the administrator and check panels from all 4D system (integration of 4D tools)
// there is a new report for prining account positions that has a selector and filter 
// the default module panel has been slightly changed and is lighter and has a fresh look. 
// the invoice has the inverse rate as an extra column
// the currencies module is listboxised
// the currencies view has been improved with registers listboxes
// the customers view has been improved with listboxes for chques, wire, and bookings
// fixed a bug in the currency holdings report that gave an error when there was no currencies in that date range
// added a new module for keeping the file paths in the system
// added a new module for the RATEX system at lotus 
// the toolbar is now inheriting the toolbar_Simple form for consistency
// Control-down arrow will open a selected record


// 3.718 - restart client and restart server now work. The open data file also works as it should 
// 3.715 - most listboxes can be selected All, can use the arrow keys on them as well, and menubar is accessible
// 3.712 - the save of customer didn't work 
// 3.711 - the close button was buggy
// 3.710 - the users provilege listbox; there was a bug in the transaction handling of users creation
// users would be saved and then disappeared. 

// 3.701 the customers did not open
// 3.700 - Accounts In out have been listboxified. The transaction bug seems to be resolved. 
// nested transactions checkbox in the database setting was activated.
// 

// 3.666
// wires and cheques list forms have been upgraded to listboxes
// transaction management is buggy (nested transactions from invoice)
// user privileges has a new tolerance for dealing with wholesellers. 
// some module icons have changed
// noticed that wires don't have a branch ID
// 

// The tellerproof form is now listbox
// password sign-in is synchronous for user to enter the password before anything else happens
// html printing works on most new listbox forms
// option-click on the report will print the form
// the sub-ldger is now hierarchical
// 

// 3.650 - Customers and bookings are now managed are listbox ready
// 3.645 - transaction management has been changed in the invoice. 
// 3.640 - Registers can now be viewed in a true listbox form; a new order by button was added
//          AML Sanction list now is performed even if first name or last name are blank (but not both)
//

// 3.635
// Compliance: better checks, last validation date; compliance history in customers; due diligence field
// new report for daily till with date range support, old report is also available

// 3.630 - Sync module is added
// 3.620 - the 4D login page has been replaced by ours
// 3.617 - added a print report for tellerproof- changed the name of the bankaccounts to wire templates. ; 
// 3.615 - added new focus object to invoice; added new buttons fur buying/selling in invoice; 
// 3.612 - allows editing a customer from the invoice without locking the customer
// 3.611 - added a pull down menu to search records created by a user
// 3.610 - added a full function AML Rule definition module - change the cashinout list to listbox for denomination counting
// 3.605 - added a conditional field to field constraints
// 3.604 - the account rename will now also affect the AMLRules, FeeRules and Transfer template tables
// 3.603 - Added the AMLRules table and form
// 3.602 - fixed a bug that was in currency view date ranges
// 3.601 - when entering customer names, the system discards the extra spaces
// 3.600 - added more room to picture id field (full info page); changed designer password

// 3.599 - created a method to call for display forms with listboxes: display_listboxform
// 3.598 - ported to v12, some bugs fixed, changed the cities list view to listbox. 
// 3.595 - Shared Tills now work and doesn't require for users to have their own till. if user changes the cash account in the invoice and uses an account with a wrong currency the system would not allow it; changed the method for date entry to allow dates like 1/1/1920
// 3.594 - Added a new data integrity test to check for orphan registers (that lost their parent invoices)
// 3.593 - added an LCT button in the Audit Query; also fixed the bug that locked a record in the journal register during startup. 
// 3.592 - Improved the transfer feature allowing two different dates to be entered for the transfer feature. (e.g: transfer date and deposit date can be different)
// 3.591 - Added a scanned cheque view and enlarge in Cheque view mode
// 3.590 - Added MSB registration # and Expiry date to customers. 
//changed the Addtional Picture IDs in the customers profile to Additional Documents; 
//added comments to customers view balance dues as per one of our feedback; 
//changed the additional pictures IDs to additional Documents (and added a desc field)
//added a filter to registers to filter by till #
//added a calendar picker to AccountsInOut, Cheques, Wires

// 3.589 - improved the calendarEvents module, still unfinished. 
// 3.588 - fixed a major bug with lack of room for invoiceID in many tables; tellerproof took too long to load the currencies (fixed);denominations improved with flags; isFlagged indexed in invoices, customers, registers
// 3.586 - a new fullpage format is added to the list of invoice templates. There's a new disclaimer field added to fullinfo 
// 3.585 - the chque format is changed to include a signature line, some customer information, etc...
// 3.584 - added two buttons in the journal for filtering banks/wholesalers and MSB accounts; changed the colours on the currency list to be more opaque
// 3.582 - fixed a bug that allowed closing a till into an empty string which caused all kinds of problem. 
// 3.581 - minor visual fixes for the checkmark (not moving up and down); due to customer and due from customer changed to 'due payable' and 'due receivable'
// 3.580 - Teller proof is improved, 
// login panel improved, 
// changepassword for admin is improved, 
// invoice preview displays the inverse rates,
// manual currency rate edit includes inverse rates entry

// 3.575- Added cash control (teller proof) and fixed the bug in eWire where modifications recreate a new eWire evertime. 
// 3.570B - worked on the denomination module; added a tellerproof table, added 
// 3.565 - added a 'missing info' query for customers to display missing IDs, dob, etc... 
// 3.564 - added a "account filtering" to the audit query (compliance query) - fixed a few bugs in the compliance query 
// 3.562 - fixed a bug that constantly asked for the invoice to be 'must report'. naming of the global variables 
// 3.561 - update of OFAC is accessible from the menu (support)
// 3.560 - added a checkbox to compliance query editor to exclude base currency; check to see if journal is balanced during startup
// 3.559 - added a computer alias to client preferences. sorting of invoices was fixed. visual changes in the 
// 3.558 - fixed a major bug in the customers save button, where the transaction would be saved during invoicing even the invoice was cancelled
// 3.557 - fixed a bug with the transfer feature coming up with a spell checker. Fix Registers didn't accept the Cancel button now fixed
// 3.556 - added new features to the Audit Query Editor (exclude MSBs, Banks, etc...)
// 3.555 - took the 'edit customer' button off and replaced it with view customer
// 3.554 - fixed a but in the fee calculations in register trigger (when % is used)
// 3.553 - allow the rates for currencies to be changed 
// 3.552 - changed 'handlesavebutton' to accept 8 parameters to save branch, etc... - all forms must be updated
// saving the sets and selection will be remembered by the system even if the window is closed and reopened

// 3.551 - Fixed a bug from 3.550 related to adding a line in the invoice that ommited the currency 

// 3.550 - changes the way registered are saved
// can now pick and agent accout once we select eWire method
// automatic tabbing in the invoice when picking R and P, Account, eWire, etc...
// fixed a bug in control box entry where some fields were mandatory - removed unnessary fields from the dialog box
// now the rule based system would also works with eWire  sub-ledger account selection (e.g Send eWire Fiji)
// added a Currency Alias field to sub-ledger accounts so that when picking an account from the invoice it can automatically pick the correct rate (e.g. USD-TT)
// added a duplicate record for currencies


// 3.544 - can edit the cdustomer from the invoice - it is buggy when the customer is new
// 3.543 -  the pending accounts work like 'receivables' and 'payables' accounts. added KYC button to invoice view, added some NZ phone formats, 
// working on eWire
// 3.541 - Added isMSB and isWholesaler to currencies; fixed a few minor visual bugs, changed the server prefs look slightly
// 3.540 - Systems emails can now be sent from within 4D without the Java component (client/server savvy)
// 3.540 - Added the X and Z report to the report menu; taken off the eWire by Country (report)
// 3.537 - CHANGED the way the writeToBBoxOnServer  is handled; intermachine process communication is now done through the controlBoxLog table instead of GET PROCESS VAR which didn't work; needs testing
// 3.536 - Added the Z report maybe unfinished. 
// 3.535 - Added a whole bunch of fields on the invoice KYC (static fields); pay off for cash receive is debugged to accept decimal entries
// 3.532 - the automatic receive cash brings a dialog box (with change amount)
// 3.531 - flags will show in the right order in the invoice; the non-tabable invoice had tab issues which is now solved
// 3.530 - if the customer had transactions in the past 2 days, it will pop up a window during invoicing
// 3.529 - Updated the look of the non-tabable invoice to look more consistant like the tabable invoice
// 3.528 - Added a new minitill report (for thermal printers); allow to pick cash registers with "requestCashTillNo"
// 3.527 - Added the WriteToBBoxOnServer method for client/server - SWEDEN VERSION
// 3.526 - Receive pay off will confirm the amount received for any amount
// 3.525 - Receive pay off will confirm the amount received (only for non-integer) from the customer to prevent errors
// 3.523 - Added an agent button in the Accounts list; 
// receive ewire button now checks to see if eWire is locked by another process
// eWire settlement account don't have to be bank accounts anymore (as long as they are settlement accounts)

// 3.522B - fixed a bug that appeared in 3.515 (when printing invoices the transfer amount didn't show anymore)
// 3.521B - Added item description when selling an item to the invoice
// 3.520B - the look of most listboxes and their toolbar button is changed. The sort button is taken out as it was not used
// 3.517B - added a button for requesting support from a live person (in the Support menu)
// 3.516B - added search form for accounts, cheques, bookings
// 3.515B- added a override password and a new server preferences
// added a table for creating exception logs
// added a system to limit users when required (checkifpasswordis)
// added a new Local Currency boolean in the Rule Based system (buggy)

// 3.510 - The  background colour for fees received changes when there is a value in them
// 3.509 - invoice colour changes when Buying and Selling
// 3.508 - wish customer a happy birhtday if birthday is near during invoicing
// 3.507 - esthetical changes in the invoice; minor adjustments; label changes when due to customer, due from customer
// 3.506 - The  fix registers command now accepts a date range
// 3.505 - Links, Bank Accounts, and Items can now be loaded and saved as an XML file
// 3.504 - website URL shows on Thermal Receipt. receipts now say "Sold" and "Bought" instead of "received and paid"
// 3.503 - writing the XML files now orders by the users preffered order
// 3.502 - currency rates panel displays larger fonts and in order that we need
// 3.501 - added an "displayorder" field for currencies
// 3.500 - new report for very large USD transactions (>100K)
// 3.497 - invoice keeps track of customer info (compliance record keeping)
// 3.496 - added a new table for complianceRules (Rule-based system for compliance monitoring)
// 3.495 - added a new report for eWires sent by country (accessible from the report menu)
// 3.494- adding invoice printing for AlAnsari - invoice customization is now done using a pull down menu
// 3.493 - added a listbox in the compliance query to see the results in a listbox
// 3.492 - added a lower limit and upper limit for compliance ; print of customers now prints more info about the customer
// 3.491 - fixed a bug with the compliance query (query was on the debit and credit instead of debitlocal and creditlocal)
// 3.490 - Created a compliance query editor in the journal registers
// 3.487 - Added many fields into the invoice module for risk assessment and compliance in Canada/US
// 3.486 - fixed a bug in search by example in invoices (fromAmount and toAmount were hidden)
// 3.485 - automatic reconciliation
// 3.484 - enable to view remote servers Account Balances
// 3.483 - changed the search forms and view forms for Invoices and registers to include the Branch ID 
// 3.482 - added a subtotal to accounts position
// 3.481 - fixed a bug with ewire link creation in the invoice wouldn't show the new link (problem in 3.480)
// 3.480 - added the AgentPO listbox accessible from the report menu. 
// 3.477 - Changed the face of accounts entry (simplified it)
// 3.476 - Added a closing balance and opening balance system. 
// 3.475 - Added date and PO number for PO orders, and added a filter in eWire ListBox
// 3.473 - Added a new compliance check for KYC (can be turned off by Kuwait or others who don't need it)
// 3.472 - can now duplicate users with their privileges without any bugs
// 3.471 - print agent order form (in eWire)
// 3.470 - Added Branches for multi branch setup
// 3.466 - Added a field constraints table to make fields mandatory or optional on any table. 
// 3.465 - fixed for Sweden -- all changes done in test center
// 3.463 - minor bug for exporting accounts (view) fixed
// 3.462 - fixed a bug for date range in accounts; also a bug for Invoice (with serial number causing non-unique data to be saved)
// ... more advanced search by example for eWire

// 3.460 - swedish compliance changes, ControlBox , ControlBoxLog, 
// 3.458 - till 0 automatically creates cash accounts now, 

// 3.456 - added a recent picks (table) and implemented for pickCityStateCountry 

// 3.455 - added an EDIT Row button to most editable tables; improved the Open Till (added an editable transfer column)
// the customer records can be saved and loaded (using the API plugins); The Large Cash button in registers table is improved and debugged
// 

// 3.453 - set broadcast message; changed the method , added myAlert to replace alert 

// 3.352 - the cities, countries, provinces module (entry form is revamped)
// 

// 3.351 - added more banks to the list of issuer banks
// designer password is changed; and so is cxrsupport password


// 3.450 - the ability to print a booking, saving a booking doesn't complain about walkin customer anymore
// added a new report icon for accounts
// added live check of OFAC and OSFI
// 

// 3.440 - fixed the bug of losing the customer when in the invoice (automatic relation in journal); added prefix for multi branch; added client code and client key;
// added integration to registrationserver for rates, added additional digits to registerID, invoiceID, etc..., 
// added a new account view (with profits per account)
// added a new currency button in the currency picker


// 3.430 - added the new quick cash button in the invoice. customer database has a lot new number of indexes
// 3.429 - made changes in the journal table (now showing customer name instead of ID); may make it SLOW ******

// 3.428 - solved the bug of slow saving of customers with large databases. (some unique fields were not indexed such as email)
// 3.427 - Send wire picks from non-cash accounts instead of bank only; fixed a bug were managers couldn't see the balance of managerial accounts
// 3.426 - Fixed a syntax error when displaying the account holdings, Transfer and Close till became very buggy. I suspect at some point I must have unlicked an invoice Form event

// 3.425 - BUGGY,  deleting an account in "Accounts" should not trigger an error. Currency Holdings should be cancellable now, saving customers checks compliance, added a new integrity check for invalid account IDs
// 3.423 - booking entry display separator for amounts, added a new checkbox to serverprefs to ask for singin up with till or not, adding a new invoice from customer module should not keep the customer id for the next invoice
// 
// 3.421 - added a server prefs to limit the queries in the filters (will improve speed)
// 3.420 - added checkboxes in Accounts to warn on debit/credit. Transfers can now be done for any customer; added buttons in journal to filter buy/sell 
// 3.418 - added exporting of account dues (running balance) and accounts list under customers tab
// 3.417 - fixed a bug when creating a ledger account from withing sub-ledger accounts, added a bank info stamp for accountin/Out memo, made it printable as well, 
// ... made the invoice entry slightly more consistent, disabled the tabbable on the Local Amounts after fee in invoice, 
// 3.415 - new redesigned invoice entry; customer in invoice cannot be left blank anymore; added Buy/Sell; lock some fields when change the radio button
//3.413 - faster customer search (on full name only); 
// 3.412 - check uniqueness of email, pictureID in Customer.  fixed the city into state for customer driver license
// 3.411 = the ewire listbox has new buttons for filtering
// 3.410 - fixed the bug for printing accounts report sum, added a new report for positions, fixed a bug where the sub-ledger accounts would hide the menu bar, 
// fixed a bug where the module panel hid the menu bar,  delete all transactions works from the support menu, doesn't check compliancy for self
// 3.405 - added a warning for short selling, 
// 3.404 - added a new report for printing accounts positions, cheque payable/receivable will not be created automatically, nor does bank accounts, etc. , denomination entry is  optional but when entered should match the amount
// 3.403 - default rate tolerance is 35%, rate panel will not display if refresh is not automatic, 
// 3.402 - made the update of accounts faster, changed the phone entry for company 20 char, 
// 3.401 - fixed the problem of the city picker, fixed the double calculation of the accounts, 
// 3.400 - fixed a bug on users not being able to print reports, fixed printing accounts from the AccountsList, added table for countries, cities, and zip codes
// 3.394 - fixed a few bugs on accounts listing, reformatted a few forms to make them fit the screen, update panel can be closed, 
// 3.390 - replaced the accounts list form with the new listbox; added transfers to accounts list box; till selection in accounts; agents icon showing
// 3.390 - cont: invoice fromAmout and toAmount now are sensitive to on getting focus for radio buttons

//.3.382 - International phone number entry; company info can be changed by admin; 
// 3.380 - Allow bank account with no customer ID to be used for all, server preference for cheque, wire
// 3.375 - added active customer button in customers
// 3.373 - removed the flags from the invoice and replaced with the favorite flags
// 3.372 - user definable flags on the invoice
// 3.371 - bookings and register comments can be copied to clipboard
// 3.370 - added a accounts tab in customers, accounts can now be linked to customers, 
// 3.369 - Fixed a bug in the invoice 
// 3.368 - Added a fee editing in user privilege
// 3.365 - Tested the feeRules table
// 3.360 - added the feeRules table for adding rules 
// 3.353 - fixed a bug that didn't update the accounts table sum vars when searching, added a new field for preferred language to customers
// 3.352 - the customer rate panel has changed
// 3.351 - the update of the xml rate has the country, and datestamp
// 3.350 - journal print is fixed. Made a delete record for listboxes that display records 
// 3.348 - added a registers list table
// 3.345 - The date range in the positions table has been fixed, but not thoroughly tested
// 3.340 - the Positions listbox has been added, but it's not date sensitive yet 
// 3.339 - customers can now change their online password. users can not view customers password
// 3.338 - agent can now change its password online, the webfolder has changed
// 3.337 - added FINTRAC tab in customers view, added search by risk popup, look for people with close birthdays. 
// 3.335 - eWire fixes; customer id get linked when eWire is sent; visible/private remarks for eWire; cancellation of eWire can be done; 
// 3.330 - the links can be edited by the agent or the customer. Only the first name and last name cannot change. 
// 3.329 - Improved the accounts summary report (has transfer Ins and transfer Outs) value
// 3.328 - added a new field for preffered customer contact method
// 3.327 - merge of customer now merges (bank accounts, call logs, messages, bookings)
// 3.326 - changin a vip rate will not reset it to the ISO code. 
// 3.325 - Added an eWireListBox with export feature, so that all ewires are exportable
// 3.320 - Added More advanced User Privileges
// 3.319 - the FINTRAC check for walkin customer was unnecessary
// 3.318 - fixed minor esthetic bugs, the print using dialog remembers the last setting now
// 3.317 - changes in wire, invoice, fintrac customers, eWire rate range checking (not tested),  
// 3.313 - don't close the module browser when the enter key is pressed
// 3.212 - added a grouping in the currency entry but not fully functional yet. 
// 3.310 - checks and balances in invoice line registration, ewire, wire, etc cannot be done for walkin customer, currency has two new booleans (weBuyCoins, weSellCoins)

// 3.306 - fixed some minor estethic problems including a bug in opening the main account
// 3.305 - fixed a problem with buy rate/sell rate that would allow the system to buy at the sell rate and vice versa
// 3.303 - CURRENCY module, and agent module added extra fields
// 3.302 - some problems fixed reported by Hamed
// 3.301 - some changes in invoice form
// 3.300 - eWire commenting, wire commenting, cheque commenting can be done in linear form in invoice, link address, etc...
// 3.299 - the Accounts Table is completely revamped
// 3.298 - cheque receive / pay forms revamped

// 3.297 - fixed a bug in transfer template (currencies stamp), fixed a bug with picking customers in invoice
// 3.295 - exportable rate sheet, accounts table has many more features,  
// 3.290 - overhauled invoice, new serversettings, new accounts page, 
// 3.285 - FINTRAC TAB, customer rating, 
// 3.280 - new icons, cheque report
// 3.279 - calculateHoldingSumVars had a commented line
// 3.278 - Added two French invoices in prefs panel
// 3.275 - fixed problem with currency profit table calculations; not tested thoroughly ; added the leverage calculation
// 3.272 - fixed the style of numbers and dates in xml export
// 3.271 - added styling to headings and added alternating rows
// 3.270 - adding styles in the xml export (not complete yet)
// 3.26 - tables are exportable to xml (excel) format, no styling at this time
// 3.25 - syntax checked, all tables are exportable to CSV format

// 3.23 - changed the menu ordering
// 3.22 - Fixed the main accounts date range, added a new report for detailed accounts print 
// 3.18 - Added some of Ashak's changes, currency holding sums work again, printing of cheques changed ( verification), some forms can be modified
// 3.15  - added an integrity check for cheques, 
// 3.14 - revamped the main accounts view 
// 3.13 - fixed the double clicking of accounts view, and some minor errors
// 3.12 - fixed the stack overflow error when creating new account (with tradeable checkbox); fixed an error caused when creating main accounts from withing the pickmainsaccounts
// 3.10- items listbox bugs were fixed, but not thooroughly tested, some new additions in subledger creation inline
// 3.07- incomplete addition of items listbox, accounts in outs can be edited properly, eWire sending clear invoice vars, large invoice prints the full address
// 3.05 - fixed the thermal receipt print (added address on top)
// 3.04- fixed a major bug in user privileges - all clients may need update
// 3.030 - Bug fixed for currencies reporting problem; added an interface for unlocking modules; 
// 3.032 - fixed a bug in bookings where confirmation by user was not held
// 3.020 - Mailbox
// 3.010- French translation added
// 3.005 - change to invoice full page
// 3.002 - changes to invoice full page
// 3.000 - adding the tableLimitations
