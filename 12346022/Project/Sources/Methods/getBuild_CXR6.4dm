//%attributes = {}

// 6.565
// Branches.listbox now has a counter @marko
// Minor changes to FINTRAC 24 hours indicator LCT IFTO IFTI

// 6.562
// New Fields on Agents Table :  @jaime
// Changes To Part B and F on FINTRAC ETFO and EFTI Report : @jaime
// Fixing bug when selecting country and picture template in links 

// 6.561
// New fields Postal Code on Links  Agents (province and postal code) Tables. (FINTRAC requirement)



// 6.560
//updated Sync compoenent
// new method -- remoteValidateRegistersForced("LFSS") -- can be called in calendarEvents - for TSB Lotus
// when saving a new record, the fields that are mandatory get a light red shade : @tiran
// Customers: when adding duplicate email, fullname, SIN, or Picture ID, we get a new window suggesting possible duplication : @tiran
// added abilty to send in a parameter with method in calendarEvents format similar to 4DSCRIPT
//  methodName/parameter <--- parameter is assumed to be text
// changed $0 from text to object (status.success and status.statusText) for remote execute from Sync
// changed $0 from long int to object (status.success and status.statusText) for calendar events methods --
//  methods called by a calendar event should return a status object


// 6.555
// pushed to lotus cloud server - 11/22/20 IBB
//updated webfolder
// added phone number to webusers and allow log in with email address
// added internal notification when new webuser indicates they are existing customer
//updated sync component
// tweak to get webewire from ewire in invoice so you can change in the middle of trans
// deactivated sending booking notifications in the email ; @tiran
// Cannot change a 'walk-in' customer. this validation checks the 'isWakin' field only regardless of the Customer ID having 000. @tiran
// New: Added a new field in Customers 'do not report' for ignoring all reporting related to these customers ; @tiran
// The 'insider' checkbox can only be set by compliance managers 

// 6.550 - Pubished on Nov 16/ 2020 @tiran 
// updated web notifications to use new sendNotificationObjectByEmail
// updated wapi component and webfolder
// added 
// sendNotificationObjectByEmail as alternate to sendNoficationByEmail - can pass in complete object
//       sourceTable, sourceId, sourceType --- so we can query to see if an email has been send (message object)
// added logging in BOJ_importRates if filepath is not found
// bugfix: The Aggr-Rule was throwing an error if the customer for an invoice was deleted. Now it throws a notification on screen; @tiran
// new: Added NIC field to Customers as per SA Central Bank customization request ; can search on it too @tiran
// new: Can now search for MSB and Inc Number right from the search box in Customers listbox  ; @tiran
// Temporary BugFix: sendNotificationBySMS now looks if country is NZ and makes sure there is a '0' after areacode and before phone number @viktor
// updated wapi component/webfolder
// Customers module: can now search by MSB Registration No, Incorporation No, and Work Tel 
// new: made a change to generic searchTable method to accept unlimited number of fields to search for (instead of a maximum of 15) ; @tiran
// new: an invoice can only be cancelled if it's cash only @tiran
// new: an invoice can only be cancelled by managers @tiran
// new: an invoice can only be cancelled if it doesn't contain any validated rows @tiran
// The Invoice.view form : can now copy the InvoiceID by selecting it and contextual menu works as well ; @tiran
// The Birthday drop down in customer module now takes into account ISO dates so month and day do not get switched @viktor
// Added method: pickWebEWireForInvoice for teller to pick which webewire @viktor
// updated wapi component/webfolder
// fixed issue with "use webewire" in  invoice/ewire process - isSent
// fixed "inverse" rate in invoice/ewire process
// We have keyvalues for Wire Receive Value Date (offset) and Estimated Receive Date (offset)  ; @tiran
// By default Wire Receive Value Date and Estimated Receive Date are defaulted to Current Date; @tiran

// 6.536
// deployed to lotus sync server - 11/4/20
// wapi component/webfolder/emailtemplates updated
// Minor Fixes to EFT/LCTR FINTRAC Reports
// Minor Fixes to NZ PTR Reports
// Minor Fixes to FIJI FIU Reports


// 6.535
// updated wapi component/webfolder - 10/30/20
// updated webOnChange_WebEwires - changed order of to/from ccy passed to getTieredRates
// added regex validation option to wapi
// New method getCustomersWithUpcomingBday to get customers with bdays coming up for the customers module bday dropdown @viktor
// Wire Receive will not add an offset to the value Date based on the keyValues ; feature request by Canam @tiranbe



// 6.530 - Published Oct 29/ 2020 - 
// updated wapi component/webfolder
// fixed bug in copyDocuments - recursive not honoring the delete parameter
// upded initCustomFolders
// added fields to databaseConstraint for web by default
//bugfix: Bday email no longer send the same customer name to every email
// sendNotificationBySMS method now takes another parameter (country code). It prepends the country area code to the phone number before sending. 3 Places have been adjusted and not pass [Customers]CountryCode(new booking, booking confirmation, mass test customers) @viktor
// major feature: AML_Alerts has a new button to allow applying AML Rules to Invoices during a certain date range
// bugfix: the third party addition in invoice module was throwing a duplicate key error; started the number from 200K instead of 30K @tiran
// bugfix: third party serial number was not being properly assigned in the trigger
// third party names are stripped from additional spaces @tiran
// can now add a third party without having to enter an invoice; not sure if this is a good idea but it's now possible @tiran

// 5.521
// deployed to lotus sync server - 10/25/20
// updated wapi component/webfolder/ - 10/25/20
// updated sync component - 10/25/20

// 5.520
// deployed to lotus sync server 10/21/20
// updated wapi component/webfolder/email templates - 10/20/20
// udpated createEwireFromWebeWire - form method for PAY ewires
// updated creatOnChangeNotificaton
// Created new KeyValue "email.greetings.birthday.from" which added it sendBirthdayCard so it can be customized or otherwise uses default <>smtpFromEmail @viktor
// sendNotificationByEmail now explicitly sets $from to be <>smtpFromEmail instead of $from:="" (same result, more explicit) @viktor
// updated WAPI component - 10/18/20
// updated createOnChangeNotification for web - and related methods
// updated /resources/email-templates/
// updated /webfolder/
// Added a new KeyValue to VM2. The key *NEEDS* to be set to "false" on BM2 Key: "email.greetings.birthday.production.mode". This key Disables VM2 to send mass bday emails @viktor
// Added a condition for method printInvoiceUsingForm_v17 to check for large comments not just CashInsOuts to use larger row @viktor
// Added new row for larger comments in cash-transaction for printing Large, Medium, and Thermal. @viktor
// Added link to company website for email header in Resources>email-templates>header @viktor
// Customer KYC Application form updated a little based on Murray's request @tiranbe

// 6.515 - deployed to lotus sync server 10/15/20
// updated web email notification code
// Added a KeyValue "email.greetings.birthday.subject" to make Customizable subject for Bday cards. Changed $subject in sendBirthdayCard and sendBirthdayCardTest to read from the the KeyValue @viktor

// 6.510 : pubished for iCenter on Oct 14/2020 by @tiran
// pushed to Lotus sync server - web app updates version 6.505
// updated wapi component
// updated getEmailTemplateBody
// added new web email notification - records added/changed
// new utility methods for getting changes - UTIL_recordChangeToText
// bugfix: the riskBar on Client Risk profile was scaling both horizontally and vertically blocking some interface elements
// AML_Alert View and Entry form have a  properly functioning splitter line ; Stamp is consistently working for both view and edit form: @tiran 
// Added a new column to display Customer Names in AML_Alerts ; new checkbox to display the customer names on demand: @tiran
// bugfix: sanction check will now log in invoice with CustomerID @waikin
// bugfix: made a change in AggregateRule Engine : rules based on multiple days were not working properly ; more testing needed @tiran
// bugfix: added error checking - copyDocuments : @barclay

// 6.501 - Published for Lotus on Oct 10/2020 - Bug found : error happens on web Servers due to lack of error checking related to 'WebDecoy' folder

// 6.500 - Publish date: 
// web email nofication changes
// Customers.view and entry form have a new Risk Bar showing the risk level using colours
// bugfix: Customers.entry form was not showing proper risk rating (when a record was first loaded) in the KYC tab 
// Added AML_Alert tab to Customer Risk Review page
// AML_Alert now has Customer ID and matching Rule ID
// AML_Alert view page can now click on Customer ID and Rule ID to open the associated records
// AML_Alerts don't get created multiple times for the same invoice and same Rule
// Added CustomerID and Rule ID to AML_Alert listbox form

// 6.499 - Publish Date: 
// updated copyDocuments method fixed bk bug
// added initCustomFolders so clients can keep customized email templates/css/... separate from webFolder and Resources
// updated web related email mehtods


// 6.498 - Publish Date: 
// updated WAPI component and webfolder - new keyvalues
// added a Table No Colums to Sync_Queue ListBox - easier to find which table has a lot of records that are stuck in the Q
// added on err call to UTIL_Logger
// bugfix: #security accounts that are restricted to managers cannot be viewed from the subledger by non-managers (even double-click is fixed)
// Currency.Entry form is changed. Added a new link line . added a new tab for web / wikipedia etc
// Big Fix: Import BOJ Rates for Counter Rates / Book Rates Updated ;  FilePaths for BOJ are now prefixes with BOJ_
// Minor Changes to NZ PTR Reports: adding 2 decimals form amounts, getting rid dot in Salutation, Dashes in account numbers. @jaime
// Minor Changes to FIJI Reports: Fixing Order of Tags, Country Name break in addresses, spaces after names. @jaime

// 6.497 - Publish Date: 
// Added printer page orientation and page size in to printThiseWire method to match printThisWire @viktor
// modified "Test FTP / SFTP Settings" object method to check the existance of panelratesInput.txt before uploading it to FTP server. This is due to the bug in curl_FTP_Send plugin command
// added the key values email.greetings.birthday.first.paragraph and email.greetings.birthday.last.paragraph for added custom message in email greeting @jonna
// updated the email-happy-birthday.html template @jonna

// 6.496
// web app updates
// bugfix: SWIFT code field was disabled in the eWire pay  form @tiran
// added a new picker button for  Relationships in Wire Pay form

// 6.495
// add test birthday email in the Admin menu @jonna
// updated Web onSave code for notifictions - keyValue web.configuration.notification.email
// added sendNotificationEmail4WebEwire
// updated webLoginCustomer - not update approval status once staff approved


// 6.490
// modify the UTIL_web4DScript for Greetings webParameter because of the pointer runtime error in calling replaceXYZTags @jonna
// created sendBirthdayCardTest method for user to test email greetings @jonna
// ticket CXR6-635: added key value caching using storage shared object.


// 6.485
// Mass SMS now uses the notifications method ; all messages are logged in the notifications module ; @viktor
// New method printInvoiceUsingForm_v17 to print new forms [Invoices]print_Large, [Invoices]print_Medium, [Invoices]print_Thermal @viktor
// bugfix: Customers cannot be put on hold during a review; added only a warning
// WebEWires Listbox form now displays the status using emojis; 
// WebEWires Listbox has 3 new buttons for filtering pending, confirmed, and cancelled webEwires
// BugFix: Customers that are on hold were not able to do be saved in the Customers module (In Canada)

// 6.480
// added find duplicate UUID to Customers and Registers listbox (the button 'Find Duplicates' has been updated)
// Sanction Check will not be log if checking for the same customer with the same name on the same day
// bugfix: Customer.view.eWires now correctly displays sender and beneficiary of the eWires instead of the 'counter party' which was repeated
// email failure alert are now non-blocking and will disappear after 5 seconds. 
// [SanctionCheckLog]ResponseJSON will display using a list box
// Bugfix: Sanction list check without calling the server will now save the sanction list name into the [SanctionCheckLog]
// Bugfix: The Customers.view.Relations tab buttons were links to the CallLogs (notes) table; bug reported by hash; @tiran
// There are 4 new ways to print invoices using 'print Form' command
// Invoices.view has a new dropdown list for printing different sizes ; this new way fixes the bugs related to info not printing on the second page of the invoice
// Added two new KeyValues for Wire.Pay value date and estimated delivery date to increase them by default @tiran
// Added a new KeyValue for invoice emailing (Invoice.email = {PDF, alert}) By default the PDF is not attached anymore. @tiran
// SanctionList Check will not call server if a same full name with the same sanction list has been check eariler in the day
// changed [bookinsg] trigger to check for "" blank [bookings]bookingid before setting - causes issues with sync
// createEmailBookingOnStatusChng - will not execute in soap/sync process
// moved email templates for web to /resources/email-templates/
// updated web portal/wapi componetn - autoNumeric.js and Pickadate.js support
// added email to AML_Aggr Rule KYC Requirements
// added addition info in log ws_remote_record_load
// added filter for webOnlyConstraint in checkFieldConstraintsForTable
//             - QUERY([FieldConstraints]; & ;[FieldConstraints]isWebConstraint#1)  //not a web only contraint
// updated wapi component/web app methods and webfolder
// bugfix: calc Stats button in the Customers.view.misc page date range is fixed / test more
// Bugfix: local fee calculations in the detail page of PL Report was incorrect (was using local fee instead of totalfees) : reported by Giannis @tiran
// Customer change information email emplate `customerCheckChange` and `createEmailForCustomer` 
// updated customer web portal coded based n Lotus feedback - wapi componente/web folder/misc methods
// bugfix: the company are not automatically checked against sanction list 
// created [Customer]Customer_KYC_Lotus form
// updated sync component  -- pull enhancements
// add a new field call isPEP in the SanctionList check
// Added implenmentation for KYC2020, the new method is K20_handleCustomerCompliance
// updated [webewires].view form - added approve/deny for starters need to add workflow
// added createLinkedDoc - draft for adding files to [linkedDocs] table
// added UTIL_getCustomerIDPtr returns a pointer to the CustomerID field if the given table
// added test for table pointer - [linkedDocs] attached to [Invoices] record
// fix: CalendarEvents.entry removed the targetWorkstation fields from the entry form ; @tiran
// bugfix: signature pad (Topaz) was not working as reported by BOJ ; @tiran
// ticket CXR6-605: in Customers entry form, when user enters address and presses tab, it will automatically split to unit number
// bugfix: passwords chages will alert properly if the record is locked and not saved
// added button in server preferences to update internal twilio text balance
// added customer relation check (in customer entry form) for following cases: (same last name, close location or same location), (diff lastname, same location )


// 6.450 published on August 1st. Lotus
// Booking printing (both narrow and large) will print a stamp with description of the booking detail
// added isCancelled to Booking entry and listbox
// Booking entry and view form  has a new stamp for displaying the status of the booking
// fix: Booking print will print the checkbox for 'buy/sell' correctly
// added automatic sanction list check to Agents.Entry
//updated wapi componentt/methods/webfolder - new receipt/confirmation/fix for rate for same currency
// added a new experimental sub-ledger grid from the 'view' menu (beta)
// fix: when we click a row on the listbox Customers.view.tabInvoices.listbox, it doesn't lose the highlighted row
// fixed: Alert in IdentityMind_init will use myAlert instead 
// updated change password forms to include changing reminder
// Major fixes to FIJI/NZ to report Account Number of the beneficiary of a Wire
// Minor Fixes to FINTRAC Reports

// 6.440 published on July 25/2020
// setBusinessRelationship is now a method that can be used in the Aggregate Rule Engine
// birthday card email: updated the code to Log if the Birthday template is missing @jon
// BOJ Import : Updated the code to meet BOJ requirements. However, there is a pending question about Triggers @jonna
// aml: Customers.Entry: the isAccount button will be locked for normal users to check; only managers and compliance officers can assign it. 
// fix: Customers.Entry form was missing the label for UNICODE Name or Ethnic Spelling: reported by Hash ; @tiran
// updated wapi component / web methods / webfolder @ibb
// added isCancelled to bookings: @ibb
// made a change to selectPrivilegesForTable method that prevents a runtime error in 4D v17.4 hotfix: @tiran
// added optInEmail/optInSMS/optInPhone - to customer table
// addeed isWebConstraint and Condition to [FieldConstraints]
// added method: isConditionTrue to work with [FieldConstaints]condition
// added the sending of birthday greeting in `SP_notificationProcess` 
// created a Calendar Events for Birthday greetings ?? @jonna what do you mean by this?  
// updated sendBirthdayCard method @jonna
// added a new field 'isChequing' to Accounts. This will affect all cheque deposits ; #test @tiran 
// warning; Can no longer pick a customer that is ON HOLD during an invoice. The picker will not allow picking customers that are on hold. 
// List_PIN.listbox has a search field ; columns can be hidden ; column widths are adjustable ; window can be resized ; @tiran
// Authorization Table (Macs) now uses the modern listbox; new button to select expired workstations; new button to assign batch dates
// CXR-495: Added upgrading of the 'Addresses' to the 'Integrity' menu. A new item called 'Upgrade old database Addresses'
// Fixed bug for address splitting to unit number and street address: when pattern didn't match, it doesn't modify the address.
// Trimming of leading and trailing spaces from remote directory path in ftpUpload method
// Trimming of leading and trailing spaces from ServerPrefs remote directory path during saving preferences

// 6.425 July 18th 2020
// fixed bug in Notifications table where attachements are not showing
// updated WAPI component and correspondng code
// Added `BirthdayGreeting`  item  in FilePathList
// Updated [Picker_Multi] form to have a Cancel button @jonna
// bugfix: update PickCompanyCustomer method to do nothing and not update customer company if the user does not pick any company @jonna
// bugfix: update the code for the BOJ import rates to check for right ISO currency, BOJ_ImportRates @jonna
// bugfix: sanction list check doesn't happen on invoice 'edit' anymore; @waikin
// bugfix: cannot add a company to the system as the picker expected a value to be entered. @tiran
// removed the indices for real numbers and integers from the [registers] table; this speeds up the sub-ledger for Globex by 17 times ; @tiran
// can now do a date range selection on notifications ; @tiran
// the Bookings printing now has the logo @tiran
// Bookings emailing has been improved @tiran
// Booking SMS is now using twilio service (instead of the SMTP)  @tiran
// notification listbox changed to complete form @tiran
// BOJ_ImportRates has been changed @jonna
// CXR-495: in [Customers] entry form, when the + button is pressed for addresses, in the dialog the google map of address is shown. @Amir

// 6.420 published on July 15/2020 // bug when 'autologout' is activated! it crashes  ; bug: selectUserPrivileges

// address has a new 'Unit' number for customers
// The exception log has now a button for quicly stamping a template note, which will automatically check the review checkmark
// The exception log entry form has a big 'review' stamp
// bugfix: reviewing an exception log was not getting stamped with username
// fixed bug where sanction list check in invoice not logged.
// create method createEmailforGreetings 
// fixed some compiler errors
//updated sync to 2.08 - blobo compression and maxsendsize parameter added
// tweaks to notifcation process - sp_noficationProcess for SMS
// methods: createNoficationForEmail, , createNoficationForSMS, createNoficationForHola(todo)
// bookings - on status change -> nofication create
// Company picker for Customer record
// Modified Orda picker temte form to make the form resizeable based on the column width/parameters 
// BUGFIX: fixed a bug where Sanction List results adds the number of exact matches into similair matches results
// added a new print template for BOJ . printInvoice_Thermal_BOJ (based on the complete thermal format)
//  webEwires has a new listbox design
// webEwires can be searched for today and date range
// webEwires has a full toolbar with search
// Modifed workaround for Jira ticket CXR6-513:
//     Export to HTML generates a files with lots of <br> tags and it takes long time to generate so the application looks as hang to a user @milan
//     It is due to the 4D bug, workaroiund implemented in printListbox method
// First workaround prevented 4D from hanging during generation of big HTML file and fixed the <br>
// issue for most of the client sites. MOdified workaround removes <br> tags from resulting HTML file
// after generating
//[Customers]: added AddressUnitNo field
//[Customers]entry form: added button to split street address to unit number and street address

// 6.400 published for BOJ June 30 /2020
// changed `displayRecord_` method to accept $2 - boolean, optional, pass True  if the View form will use an Entity Form Object
// Notifications record creation for SMS
// a new signature field was added to the invoices table
// integration with Topaz scanner for Windows (scanTopaz.exe).
// new key values and file paths added for Topaz scanner
// The invoice entry and view display a signature
// The printInvoice_large will print the signature on the form
//  Updated the [Booking]View form `Email Booking` button object method to prompt user  about the email status.
// Added check to RAL server integration to warn users if license is close to being expired
// Added get methods for RAl License (isLicenseExpired, isLicensePRO, isLicenseBE, isLicensePOS) 

// 6.396 - hotfix published June 27/2020
// a recent change on the displayRecord_ was creating an issue when we double clicked an Account
// Jonna made a change to make the displayRecord_ compatible with entity selection and it created a problem
// with forms that were using the Form. object where the Form was not necessarily a mapping of the data store


// 6.395 - published June 26/2020
// removed keyvalue for initializing/controling hola in confirmations
// update the `displayRecord_` method to also pass the object entity to the form. To be able to use ORDA as welll
// bugfix: Customers ID can now be copied from the Customers.view page; select, right click and copy
// notification process updated
// added SP_Start to on backup shutdown
// Can now search customers by both home phone number and cell phone number
// added [registersAudit]triggerUser - 
// bug fix on add [linkedDocs] to invoice - issue wiht getPrimaryKey and default table
// added a check for server side attachments when sending remotely - confirmationSendEmail - ibb
// made some changes in the email process for the Notification record
// Add new changes below this line...
// Customers.View dropdown menu for searching active customers can search on any date range now
// Customers.View dropdown menu for searching inactive customers can search on any date range now
// ...
// Jira ticket CXR6-495: 
//     These new fields added to [Addresses] table: creationDate, creationTime, isActive, validationDate
//     The value of creationDate and creationTime is assigned in [Addresses] Trigger.
//     The length of [Addresses]Type field is increased from 10 to 20 characters.
//     [Customers] Entry form changes
//         The customers address is now also saved in the [Addresses] table.
//         If the + button is pressed, the address search functionality can be used.
//         When customer record is saved, if a change in address is detected, a new address record will be created.
// ...
// Jira ticket CXR6-513:
//     Export to HTML generates a files with lots of <br> tags and it takes long time to generate so the application looks as hang to a user
//     It is due to the 4D bug, workaroiund implemented in printListbox method

// 6.380+ published:   June 16/ 2020
// Fixed the bug where PEP check blocks invoice from completing
// The customer profile KYC form is revamped; resizing window was buggy 
// Removes hold buttons from all sanction list checks, as the version with it is buggy and the one without works as expected.
// fixed bug where sanction list matches sometimes return a result value of 2 (red circle) instand of 1 (yellow circle).
// fixed bug where [SanctionCheckLog]ResponseText filling with an error message when the test is passed.
// refactored SP_managerProcess and other stored procedures
// added stored procedure for notifications - still in progress
// calendarEvents stored procedure only runs on server now - 
// added sendEmailNotification and sendSMSNotification - to create records in [notifcation] table - still TODO
// added OBJ_newPaymentInfo to initialize the paymentInfo object in [WebEwires]
//added paymentInfo object field to webEwires
// fixed bug in the AML Rule Engine that was causing wrong calculations in the value of the purchased funds #TB Jun 13/ 2020
// fixed a bug regarding the Aggregate Rule module where the Value calculation was wrong #needs testing #tb ; june 12 2020
// Notifications table module
// fixed a bug introduced in recent version where need 2 or more AML Aggr Rule for the engine to work
// added a review button in the invoice.entry screen
// updated wapi component and cxr code - added new customer dashboard
// fixed the Gender bug. The problem was in the Salutaion field, it's changing the field depending on the salutation. Added a line of code to change only if the Gender is blank
// new methods 'sendTodaysInvoiceToIM' for autmatic scheduling of Identity Mind sending
// updated wapi component/web folder - and supporting methods
// structure change: Changed ServerPrefs emails, server, smtp, etc from char to Text (to allow longer URLs and usernames)
// bugfix: The sanction list checker form would throw an error when clicking 'exact' or 'similar match' radio button
// [list_pot];"Listbox" now remember column sizes and positions
// [list_sof];"listbox" now remember column sizes and positions
// [ExceptionsLog];"ListBox" now remembers sizes and positions
// [WebUsers];"ListBox" now displays the count of records, remembers column widths and positions
// Sanction List check are being checked with JSON
// handleCustomerNameCompliance and handleCustomerEntityCompliance are generalized
// Added new RAL server integration. Includes new startup Registration and License check and new company info screen Support->Registration and Licensing
// updated AutoLogoutExecute to use notifyAlert insead of myAlert
// fixed the bug where sanction list check cause an error if the indicator icon is empty
// fixed the above bug again with replacing pointer to a null object to use null pointer
// fixed bug where where handleCustomerEntityCompliance does not run if over 4 parameters
// Added error catching to RAL methods

// 6.355 Published to Server
// some notifications have changed to automatically disappear from the screen
// amir made some changes to the trigger of 
// bugfix: eWire.Pay eWireID is changed from editable to non-editable; reported by Hash 
// bugfix: created an empty IM_Shutdown to prevent the system to throw an error during quit ; #TB
// bugfix: SET PRINT OPTION(Destination option;1) to printToPDF
// address trigger: when an address is saved or updated, two hashes (proximity and exact match) are calculated and saved with it
// 
// 6.350 published on  May 24, 2020 : bug: throws an error when quitting the app (IM_Shutdown)

// updated wapi component and methods
// changed [webusers]isCustomer to [WebUsers]relatedTable
// added email template for booking confirmation
// new version of sync somponent - validation now checks Hash and logs differences
// Booking module allows rateless (open) bookings
// Bugfix: Customers.entry form, deleting the additional picture ID is fixed; can now properly select which attachment 
// WebAttachments has now a complete toolbar with date range search
// importBOJRates method for Counter rater and Book rate import for BOJ
// [WebUsers];"view" has a button to take to customer page directly
// [WebUsers];"ListBox"  has a complete toolbar with search, today, and date range search
// WebUsers can be searched
// can now search customers by email
// Added fields related to PEP, HIO and false positive to Customer KYC/AML Tab
// added CSV Component (shall be removed #TB)
// Created a new method to Import BOJ rates
// Sync_Queue Module - to be tested (by Nora)
// added getTieredRate -- to test
// updated web app methos and webfolder
//moved SET TIMER (0) in [Registers].Listbox form method - ibb
// added new wapi component, updated webMethods, updated webfolder
// Improved: Added 'Hide Inactive Users' to Users Listbox
// Added buttons to Branch module for duplication and selection
// The Wire Print form now includes the branch Address
// bugfix:  fixed the license alert that happens after each save
// added a new option in Customers listbox dropdown for quickly filtering new web customers
// New table added for CurrencyRules - requires module development


// 6.330 published: bug Alert shows after each invoice save
// EFTO and EFTI LCTR Reports was corrected, no required fields added before was causing report rejects. There were deleted.
// The Invoice Transfer form has been improved; now include focus Rectangle on fields, added buttons to quickly select subAccounts
// ... The Invoice Transfer subAccounts fields now use a subAccount picker; fonts are bigger; colours are lighter
// BugFix: Invoice Transfer ; transfer to field would open the account picker twice.   
// The secondary IDs in the Customers.View page is revamped ; listbox instead of a subform; double clicking  opens a new window 
// Fixes to FINTRAC LCTR to add conversion from TOM to IRR in the report.
// Invoices.Entry.DueDiligence page has clickable links for picking relationships and country code
// Integrity Check and UpdateTable don't throw a blocking alert anymore, allowing the process to continue when there is an issue or problem
// Module for Relation Types
// turned off automatic backup during restart (when backup has not been done)
// In Customers.view form Can now right-click on CustomerID, or Account# to copy the text 
// clicking on the Invoice Amount field now highlights the 'Amount' field to prevent mistakenly adding extra zeros
// brought back the old image editing tools for the Attached Documents 
// new method getCustomerFullNameORDA
// bugfix: Accounts.view date range is not working due to an ORDA query; bug reported by Hash
// bugfix: Multi-branch account view is now working again; classic code won over ORDA; method: getAccountBalanceByBID
// Added a search box to Users ListBox
// Users can be searched by account, group, email, userID, username
// bugfix: duplicate User button in Users Listbox is fixed
// BOJ Export ASCII File for the Accounting System
// New changes in BOJ Export to refine TX's related to Checks and Wires
// allows PEP to be check automatically as desired
// Changes in FINTRAC LCTR Report fix transactions regarding checks and e-Wires
// Bugfix: When Editinf and saving a signature


// 6.300 Deployed for Lotus -- The Account Date Range filter is buggy (toDate should be entered as +1)

// Module for Relations table
// Module for Confirmations table
// subform listbox for adding LinkedDocs to other records ie. Invoices due diligence page
// Sending PDF emails from inside the invoice with all the attachments ; should be a pro feature
// Can now attach multiple documents to an invoice
// fixed counter in the mainListbox
// fixed window size in mainListBox
// fixed the todays button in currencies
// fixed the showDateRange button in currencies
// when we search customer, the counter is updated
// when we search cheques, the counter is updated
// improvements:
// can now search cheque by customer name
// can search wires by customer name
// can search in registers by customer name
// can search by Items name in the ItemInOuts listbox
// can search the customer name in the itemInOuts Listbox
// can search customer name in the AML_ReviewLog
// fixed bug: AML_ReviewLog search was throwing error
// can search customer in the booking
// Links: added a counter to listbox
// BUGFIX: Fixed an issue so now when a customer is being selected in an invoice, sanction check will run automaticlly if desired.

// 6.250 published
// Added a new method for PickInvoiceID, this is returning an entity selection for Invoice
// Customers.view all social media handles are clickable to automatically take to the correspondial page using handle (e.g. tiranbe)
// Customers.view displays the Picture Country Code again
// Implemented 'rejection' in the new AML_Aggr Rule engine
// Implemented filtering based on branch ID in the new AML Rule Engine
// Customers.view is more concise now ; merged wire & Wire Templates; Links & eWires; removed eMessages ; 13 tabs total ; 3 less pages
// and Customers.view added more splitters in multi-form pages for page organization and clarity
// 
// [customers];"view" form now displays the labels for occupation; industry; company; and title
// bugfix: viewing invoices from customers.view would lock the invoices, as well as links, eWires, eMessages, etc
// bugFix: Currency picker is showing the flags correctly again
// Currencies can be reordered from the new Rate Sheet ; also hidden from the XML publishing from the same site
// New Rate Sheet button in the Currencies Listbox module
// AML Aggregate Rules can be reordered 
// Added Company Types (Sole Propri; Corop.; ....)
// Added an index to incorporation no. for faster search
// Added Tags to Customers entry
// AML Rules  can automatically add Tags to customers table
// added 4 modes for confirmationSendEmails via broadcast - local synch, local async, server async, server cal event
// changed the way 'support' user gets authenticated. 
// The admin cannot edit the sanction lists anymore
// new createCalendarEvent createCalendarStoredProc createCalendarTask
// updated confimration code
// updated SP_Services in handling calendarEvents
// Government ID (PictureIDType) was replaced with Provincial ID Card
// new AML_Alert module
// confirmationSendBroadcastXXXXX methods
// added new web confirmations - fixed bug on display error
// bugfix: creating a new user would throw an error
//added _template_Hola _template_Confirmations _template_Progress methods
//updated Hola component - dialogs now open across screen as the window fills
//updated confirmations code - 
//updated hola startup code - new color scheme
// Major Upgrade: The new Rule Engine is now integrated with the Invoice module (CXR Pro users Only)
// bugfix; listing invoices will not lock the customer anymore
// The first successful sign of integration of the new Rule Engine with Invoice module
// There are bugs but it won't affect current clients as it only activates via key value
// a lot of testing is required!
// Added server preference to allow or disallow repeated passwords for users 
// Added designer-only button on User listbox to delete all historical password records
// Simplified user validation to speed up creation of new users 

// 6.215
// bugfix: the email sender would throw an error when the backup would fail; got rid of the code altogether
// minor error in login/logout fixed that threw syntax error on Mac v17.4
// added confirmationXXXXXX methods for remote confirmations
// new ih_hola component
// new WAPI component
// new tag field in invoices to be used for keyword search
// Consoliding exchange rate differences in GL Report (BOJ)


// 6.210 published
// Customer KYC Review has a new 100% complete stamp now to make it visually appealing
// bug fix: discount calculation on item now rounds the tax and prices before and after discount
// added [confirmations] table - ibb
// Bugfix: Users.ListBox duplicate button doesn't duplicate some information such as UUID, failed attempts, etc... 
// The Customers.ListBox 'Find Customers' pulldown menu can now search for Suspicous, Insiders, Whitelisted, ignoredKYC, Accounts, and Walkins
// Customers.Listbox view: Customers that are on hold or high risk now have a red Customer ID for easy detection
// New LCT Declaration (EDD) form created for printing
// Print Form: Large Cash Transaction Form in Invoices table
// BugFix: The cheque pay form can now pick from list of cheques previously written to
// updated convertPictures to work in v17 32bit - IBB
// FTP Upload: doesn't throw a blocking Alert message, instead uses the modern Hola notification
// FilePath.listbox form has a two new buttons for selecting records related to the same machine, or duplicate a filepath
// MainAccounts.entry form UI slightly improved
// MainAccounts.Listbox form now doesn't constantly get updated but only by request and the first time it gets opened
// customers.view form is slightly improved; an extra tab is deleted
// Customers.view form now includes the contact first name, last name as well as MSB, isBank checkboxes 
// Updated Currency Cloud API with various bugfixes and improvements
// Bank of Jamaica GL Report (JA)
// Bugfix: Fixed bug when changing administrator password from menu


// 6.190 published
// Customers.View revamped
//updated Hola component
// added iH_registerClient and iH_unregisterClient to the login/logout code Blake wrote
//added getSystemUserName for use with [Audit] -- able to get system user from a Trigger now
//updated sync component - hash mode can be set - is set to 4D Digest - 24 characters - changed existing fields to 24
//sync_startup - added Sync_hashMode(4D Digest)
// BUGS FOUND: Sanction list during invoicing will throw an error even if the test passes
// REVAMP: Customers.View is under redevelopment
// Doka component replaced by Toast UI Image Editor
// Toast UI Image editor added to Linkeddocs Table



// 6.180
//Standard module for 'FTP_Site' table
//Created Customization request for Money Way, Application Form Individual print form in Customers table 'Customer_AppForm' for printing
// Allow switch between v1 or v2 of the Sanction list using KeyValue sanctionList.version
// SanctionList v2 result window shows entity/person type and name

// FTP and FTP testing doesn't require the CX_Support Files anymore
// change HTTP Request default timeout from 4 seconds to 10 seconds
// improved: when doing a AML Review for a customer, the system won't force KYC Review (if due)
// improved: added the QUICK option for Sanction list checks; it will improve the speed of search dramatically
// Doka component Added to Customer Form


// 6.175 published
//Updated View form of WebEWires table
// the old customer image editor has the ability to add and edit address now
// upload of the XML will not display any success message on the screen to prevent standalone machine to
// new button in eWires.listbox allowing to manually settle eWires by admin only

// 6.170
// Bug fix: AccountInOut Pay/Receive form from the invoice would open the picker twice, once with empty selection
// Improvement: the AccountInOuts Pay/Receive form is improved with larger fonts, flags, stamp
// Improvement: The Invoice.Entry listbox columns can now be adjusted by the user (name of widget must contain listbox)
// Bug fix: Now Correctly displays the account balance during Account Pay/Receive during invoicing 
// Clicking on the 'Need Review' stamp will now open the review panel (like before)
// Bug Fix: Customer Review couldn't be completed 
// Bug Fix: Sanction lists methods will check with a entity query before calling checkNameAgainstSanctionList
// Bug Fix: Sanction list combobox whill now display the correct icon
// Bug Fix: Sanction list check for Company will work now
// Generalized automatic sanction list checks

// Doka Component added in order to edit pictures 
// updated WAPI component
// added WebEWireLog table and trigger method
// added inegration with Twilio for SMS sending
// added customer cell phone validation via text message

// 6.160
// Bug Fix: customers were put on hold no matter what
// added a separate button for Edit and Edit+
// 

// 6.150 - published
// A complete new image editor is available for editing picture IDs 
// increased the length of the Risk Factors, SOF, PIN, POT from 50 to 150 chars (feedback Eric)
//Create Module for table WebEWires: CRUD functionality, Forms, Methods, etc..
// updated WAPI component/WebFolder - agent/customert portal now used WebEwires
// Fixed a bug reported by Jihad regarding the sub-ledger accounts display (revered to the classic way instead of ORDA way)
// Added Time Zone to the Company Info again - The rate display was displaying the wrong date
// Allows the checking of each enabled sanction list
// searching on Wire Templates is now much faster (no more sequential search); added beneficiary name to the list of searchable fields
// added a counter in the footer for KeyValues
// added a counter in the footer for Flags module
// added SFTP support
// added [ServerPrefs]ftpUseSecure field
// ftpUpload method now checks the value of [ServerPrefs]ftpUseSecure field and passes to sftpUpload accordingly
// added downloading rates from cloud.clearviewsys.net (REST)
// added [ServerPrefs]currencyRateSource field, which determines the source of currency update rate 
// added support for sending secure email using cURL plugin by Keisuke Miyako
// new sendEmail method is created that calls sendEmailviacURL method, previous method is renamed as sendEmailOLD
// IdentityMind: add the ability to send the invoice shown in listbox to send to IdentityMind as a batch
// automatic check now uses the new version
// response JSON now is being stored as a Object and the check result is store as the response text
// BUGFIX: Sanction List check with no match and Sanction List check that is not set to place a hold will not hold the customer.

// 6.100 - published on Dec 6/2019
// Create Module for table AML_AggrRules: CRUD functionality, Forms, Methods, etc..
// Improved: LIST_SOF ListBox has now search functionality; can change the width of the window
// Improved: LIST_POT ListBox has now search functionality; can change the width of the window
// updated support menu - deletAllTransactions - now uses truncate table
// added support menu - createStarterDbase - purges all data but base codes/currencies/flags...
// updated SYNC and XML_Bags - support objects, object arrays, time, time arrays
// ORDA optimization: changed the method that calculates the account balances in subledger with ORDA equivalent; much simpler code and feels faster
// Improved: method getAccountByBID has been rewritten in ORDA - optimized for speed
// Bugfix: Countries module selection wasn't working for deleting, filtering, save, load, export, etc
// Bugfix: method getAccountBalance was calculating Credit-Debit instead of Debit-Credit 
// Bugfix: fixed a bug in the login: users couldn't login before a designer or admin would login: Blake
// New Feature: Added a clean fee button in invoice

// IdentityMind bugfixes: 
//  - IM_KYCLog now loads when [Customers]Entity form is open
//  - [Customers]Entity form save button now call the IM_preformKYCRelatedTasks
//  - autoCheck will not send to IdentityMind unless if it is a new record

// 6.090 published
// Bugfix: In Invoice when we add an account the 'Balance Before' now gets calculated again
// Two new keyValues for making the Transaction Type or Customer Type mandatory or not
// List_RiskFactors can pick multiple items
//updated wapi component - added customer portal - beta
//updated exportBOMeft - bug fix and changed keyvalue order
// New Feature: P&L for currency now has a Cost of Inventory column
// Improvement: When you pick a Wire Template in the Invoice AccountInOuts form, the wire template info appears on the notes
// Bugfix: Send page in the INvoices (Due Diligence) ; source of funds and Purpose labels can now be clicked on (for picker to open)
// UX: Customer module shows the Company Names that are a corporate account in a darker colour
// Improvement: SIN maximum characters increased from 9 to 15 to support Swedish National PID
// New Feature: Added 'Manual' option to Sanction lists ; integration is still pending
// New Feature: Added a CompanyID fields to Customers to be able to link Customers to companies
// New Feature:  Added a new combo box to allow selection of company from the Customer.entry screen
// Updated Audit View Form from Audit Control Log to be more visually appealing - NM
// Added integration with Bisnode Consumer Intelligence to new customer form, to search by legal ID (person ID)
// Bugfix: typing a date in the date widget will update the calendar if the format is correct

// 6.080 - unpublished
// updated WAPI component and web folders
// Added BOM EFT Wire export 
// SanctionCheckLog: can now search by date range or click on Today tosee who was checked today - TB
// Audit Trail module: Can now search by invoice ID; added index for faster search - TB
// Audit Trail module: search on Account ID is much faster; added index - TB
// Audit has been renamed to 'Audit Control Log; - TB
// Audit Control Log can now be searched by date - TB
//Modified the code 'listbox_exporWithDelimiters' to also check the variable type in manipulating the string in Screen Report Export function
//bug fix: Added the missing parameter '$arrFees' in 'PLItems_calcSummaryVars_server' for the calling method 'PL_calcSummaryVars_onArrays'
//bug fix: fixed the Listbox Header name of the following report to show the correct header name in the export file : ‘Summary of Income/Expense’,'Customer Stats', 'Customer Yearly Statistics','Summary of Bookings'
//bug fix: remove the code for getting the year drop down in 'Complete Profit Loss' report. It is not needed in the report
// bugfix: WizzForms scan now takes doesn't include extra space between first name and last name - TB
// added: CanAm BOM export for EFT - Wires - IBB
// UX: improved the Customer Notes.view form (larger and more visible) - TB
// Added 'Fix Currencies' button to Flags.Listbox - TB
// Added 'Load Flags' button to Flags.listbox - TB
// Fixed the loadFlags - TB
// Mayor changes to FINTRAC Reports related to 24Hours and Disposition in transactions - JA


// 6.070 published
// Screen Report : Created a report for Customers First and Last transaction
// UX: flags.entry and flags.view got revamped; 
// UX: Currencies.listbox has an improved look; larger flags, bigger row height
// UX: Currencies.entry clicking on the flag will automatically load the flag (if it exist in the flags table)
// Improved: Currencies.entry shift click on the flag will allow to load a flag from disk
// fixed a visual bug in the invoice.entry page where the amount field would get covered by a box (when entering a FC Value)
// fixed a display bug in the invoice.entry page where the flags were not correctly sized.
// UX: improved the way the invoice.entry looks ; colouring and themes
// UX: The forgot password code entry form is improved (more clear and larger fonts)
// Report: The Wire print form has been improved with better organization, more consistent fonts, and larger room for further credit and memo
// Improved: The Wire.listbox pulldown menu for picking bank accounts has been improved (faster) etc.
// Improved: Invoice.entry; the tab orders have slightly changed; the Buy/Sell buttons are now focusable; some of the labels changed
// Improved: MemberCheck uses internalTableId + interntalRecordId instead of [Customer] table, allowing it to use in different table
// Create module for mchk_CheckLog

// 6.055 unpublished
// UX: improved the looks of the 'new PEP' list dialog box (designed by Waikin)
// fixed some issues related the login (took the timer away temporarily)

// Alternative Sanction List/PEP
// : alias name use the regular font
// : match entity are expanded by defualt
// : list match summary now shows number of similar match and exact match instead of total matches

// Sanction list combobox is now one step process, and uses a list instead of an array to fill the options


// 6.050 published  
// updated WAPI component and related methods
// removed the Yahoo Finance logo and url link at the Currencies table View form
// Fixed the Picture of Email booking button in Booking View form
// Fixed the picture of Bulk Add button in the Common List table
// Fixed the mini gear picture that is used in the old listbox forms
// Fixed the Yahoo finance picture located at the Currencies View form
// Allow 1 character for Customer Lastname and Firstname. Modified Sanction list checking to accept atleast 3 characters Full name including space.  
// Bugfix: the invoice.entry is now properly showing 'receive' and 'pay' for buy and sell like before
// Currencies.entry form allows the upload of a picture by shift clicking on the flag (to replace the current flag)
// Currencies.entry.flag is now droppable and has a contexual menu
// WizzForms buttons can now load addresses from picture IDs.  
// UX fix: pulldown menu for date range in 'Accounts.View' was not moving with the window size
// added RELE and PSCA to the 'populate sanction list' button (method) in SanctionLists.Listbox
// registers audit trail doesn't show all records when opened ; speeding up the display of records the first time it's opened
// bugfix; fixed the 'show password' button in some forms
// wrote a method 'fixCurrencyFlags' and 'fixCurrencyFlags_ORDA' to fix the currency flags
// fixCurrencyFlags
// Registers search form can now search by sync_id
// Invoice Serial # is only assigned the first time the invoice is created; instead of each time the record is recreated by the sync engine
// ... preventing the serial number to be changed the the records are re-assigned. 
// Added check against all previous passwords when changing user password

// The Flags.listbox has a search now
// The Flags.entry form has improved interface; the flag has a contextual menu
// Changed autologout to lock user instead of quitting 4D
// Added Forgot password system for non-system users; requires user to have an email
//     associated with their account

// Fixed some errors regarding to FINTRAC Reports (Sequence report and subheaders)
// New sancation List: now uses the JSON value for 'MatchType' to define exact and similar matches
// fixed bug on password change in User privleges, user can now change password via screen
// remove bugged code in New Sanction list and add PEP JSON check to Customer

// All cals to API plugin method are replaced by native 4D methods

// For New Sanction List
// : Fix sanction list data not showing in the AML page (but don't mix new and old sanction list calls)
// : Add sanction list check for companies
// : Optimizated the check, now using one less for loop
// : Remove the progress bar for SanctionList form
// Combines five sanction list buttons into a single drop down listbox with a button
// MemberCheck fixed an 400 HTTP Error if [Customer]DOB=!00-00-00!
// Created module for IM_KYCLog


// 6.020 published
// bugfixes: 
//: the 'T' (Today) toolbar button of ShipmentLines
// : fixed bug which allowed users to access admin without changing to a stronger password
// IM Component 13.1 is fixed, both the KYC and Ongoiong monitoring is working again
// 

// improvements: 
// : Invoice due diligence page (view) is now consistent with the entry form
// : Suspicious Transactions has been reworded to Unusual Activity (as per Garry)
// : added the date of Shipment to Shipment Lines
// : added Auto logout system, settings available in Server Preferences
// : The AML Review automatic revision notes sentense wording changed. The phrase 'changed to' is mostly 'set to'  (feedback by Gary)


// 6.010
// improved: the printing of Invoice.FullPage and Invoice.FullPage_Internal have been improved by showing more fields 
// bugfix: printing of Invoice.FullPage and FullPage_Internal now correctly shows the Purpose of Transaction

// bugfix: ShipmentLines now can filter by date range
// Created View form for Shipment table
// changed table Agent, CommonList, Countries, States, TransferTemplates, Flags, Branches to Standard Listbox
// bugfix: create displayLbox_Flags method
// updated web component - 9/9/19

// Created a method that will disabled the New and Edit button in the Listbox if the table is a Transaction related table. Method name: isNewButtonDisabledForTable & isEditButtonDisabledForTable 
// 'isNewButtonDisabledForTable' method - New button is disabled and no need for  Entry form [CashTransactions],[ItemInOuts],[CashInOuts],[AccountInOuts],[ShipmentLines],[eWires],[Cheques],[Wires]
// 'isEditButtonDisabledForTable' method - New button is disabled and no need for  Entry form [CashTransactions],[ItemInOuts],[CashInOuts],[AccountInOuts],[ShipmentLines],[eWires],[Cheques],[Wires]

// DateRanges module allows picking a template date range
//Added Date Picker in Accounts View form
//Added Date picker in Date Range form
// new version of sync component to fix issue with SOAP request - modified WS calls in CXR
// Hiding/Showing signnature button in [Invoices]View Form automatically (J)
// Added a button for the new sanction list check in [Customer]Entry Form which allow on hold setting and icon appearing 


// v 6.005
// Added the Customer Signature to the [invoice]Entry and [invoice]View Forms (J)
// added a 'Pick' for all the note fields in customers.entry, customers.kyc_review, customers.aml_review forms
// changed AuditControls.Listbox to standard ListBox 
// bugfix: changed Wires table View form from List form to Detail form
// created View form fo Agent Accounts table
// bugfix: AML_ReviewLog Edit button not working because the Highleight Set name is incorrect
// bugfix: CallLogs table(Customer Notes) show two forms. Fixed by removing the form event On Getting focus property that shows also the Customers form.
// AML_RiskTemplates module and incorporate it on Customer KYC form- 8/8/2019
// added a new key value for IdentityMind component
// Create MemberCheck forms, table and methods



// Fixed some errors regarding to FINTRAC Reports (Sequence report and subheaders)
// fixed some syntax errors regarding the P&L reports, fee calculation
// updated wapi component and hook methods
// adding records to List_PIN, POT, SOF, risk factors, relationships are now restricted to compliance officers
// bugfix: validation code added to List_POT table
// fixed bug in Audit_createAudit handling types of BLOBs and Pictures - can't direct compare with OLD - 7/31/19
// writeLog now will write to a CXR.log file in the logs folder of the server
//
// added a column for AML_Report showing the status of the report
// added launchUpdateProcess to SP_Manager to monitor and relaunch if crashes
// updated web component - 7/29/19
// updated sync component - added data to delete logging - force sync id regardless of sync "enabled"
// fixed bug in query - forceSignOffAllTills
// updated web component and methods
// tweaked triggerSync - doRun optional for debug purposes - previously would never run - now can config with keyValue (debug.syncid) - iCenter issue
// 
// insert a new sanction list check with test form
// new utility methods: replaceUnsafeURLCharacters, splitTextToObject
// changing the following settings in Structure Setting -> Compatibilities
//   Use object notation to access object properties (Unicode required) to true
//   Save method as Unicode to true

