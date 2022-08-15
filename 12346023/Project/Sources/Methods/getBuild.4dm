//%attributes = {}


// getBuild
// getCurrentVersion
// works with getMajorVersion and getCurrentVersion
// previous notes are availabel getBuild_CXR6

C_TEXT:C284($0)
$0:="000"

// moved to GitHub

// NOTES: PLEASE ADD YOUR COMMENTS BELOW THE VERSION NUMBER ; LATEST CHANGES ON TOP
// Add Date when publishing the code and changing version no; mention your name when adding a new line @user ; 
// good hashtags to use:  #bugfix , #feature , #optimization , #improvement , #security, #UI, #bug, #orda, #web , #index

/*
 Version : 7.000
#newfeature #customization: AML Alerts Summary report added to the AML_Alerts listbox form; requested by BOJ ; July 14/2021; TB
#improvement #customization: made changes to the top 100 customers report based on customer request
             .. filtering companies, and local currency transactions, counting invoices instead of registers
#improvement: Added License Check for AML Batch Reports
#UI [Customers]Pick changed the "New", "Edit", "Pick Customer" button to Automatoc color
#UI update email header.html to show email.configuration.header.text as text not hyperlink
# added loop on ws_getcurrency_s2 and wss_httppost
# fixed close box not saving ibb
#UI: Table modules icon match the new Menu Icons
#bug: fixed some sompiler errors
#improvement: allows the sanction list to run in the background as needed.
#  // updated alert for update rates - now using hola - non-blocking

# added sync_exectpiont to keyValues and calendarEvents
` updated WSS_httpListener/WSS_httpPost and other WS_Remote calls to use http 
#bugfix AML Reports and KYC/AML Reviews not displayed on page 1 on load @milan
# udpated UTIL_getMacAddress to get serial num instead - issue with multiple adapters causing re-licensing
  //added webOnChange_Invoices
#improvement: Make the sanction list item searchable when able @waikin
#refactored: most of the current sanations check now uses sl_ prefix @waikin
#updated wapi/web component added code for payment gateway
#feature: added 2 reports Top100 customer and Transaction Summary @jonna
#improvement : replaces applyForSanctionListCheck with isCustomerSubjectToScreening @waikin
#bugfix : fixed an issues where the sanction check not showing matches @waikin
#bugfix : when saving a KeyValue, it will now update Storage. @waikin
# added KYC2020 into sanction list check, to use set sanctionlist.version to "KYC2020" (more work are needed). @waikin
# updated wapi component and web folder
# updated webconfirmAccount/webLoginCustomer/webNotification
#bugfix : Link{Entry]'s name will now be formatted. @waikin
`added polipay to workflow - webewire and invoice @barclay
#improvement : created and tested create4DUSer method to create user in 4D users and groups system (needed to create Support and User - our default user - user once converted to project mode) @milan
#improvement : created isProjectMode method @milan
#bugfix in getSystemUserID : checking if Find in array actually found the user @milan
# fixed bug in [wiretemplates] new record not setting an id @barclay
#optimization : removed Fix QR Bug menu item from Support menu, not needed in v18 @milan
# added POLiPay Link API @barclay
`updated webfolder @barclay
`updated /resources/email-templates/webewires-new-record.html @barclay
#UX : improved the SanctionCheckLog.view form with a splitter, resizing is fixed  @tiran
 #feature :  Customer Entry Form now has a validate email button that check validity with Zero Bounce @viktor
 #feature : Zero Bounce email validations methods single and bulk @viktor
 #bug : New ValidateIBAN method that works with their new API version @viktor
 #feature :  WebEWireLogs module has been created along with all nessecary methods @viktor
 #web : updated  webRegister/webnotification @ibb
 #web : updated webFolder @ibb
 #feature create the deleteWebAttachmetFromDisk method and run it in deleteWebAttachmets as garbage collector for WebDocuments folder @viktor
 #feature added startup check of 4D application versions and builds on Client and Server, informs user about difference and let them quit or continue @milan
 #bugfix Syntax error on Confirmations Module @milan
 #bugfix Customers Wires HTML report creates a blank report HTML file when saved @milan
 #bugfix Changed bday dropdown to for $days=2 to look at bdays tomorrow not in the next 2 days @viktor
 #UI add a more detail alert heading for Identity Mind HTTP errors. @waikin
 #bugfix : entring the tag in the Customers.entry was checking the sanction lists
 #UI added DOB to Customers.View form as it was missing from the main screen @tiran
 #UI add an ability to return when sanction check fails when Customer or Invoice is being saved
 #index added an index to Customers.createdByUserID for fast search based on who created the customer @tiran
 #index added an index to Customer Notes date field for fast search based on date range (CallLogs) @tiran
 #UI #feature Added a Button in Customers.listbox form to apply Business Relationship date to selection of customers @tiran
 #UI #feature Customers.entry form,  added a button to automatically calculate the start of Business Relationship for Canadian Customers @tiran
 #UI #feature added a 'self' checkbox in the Links to simplify creating self Links @tiran
 #UI The Users.listbox displays the Admin users in Red @tiran
 #UI The Users.listbox has a new column for displaying Admin users @tiran
 #UI #fix fixed a checkbox 'show active users'  in the Users.Listbox form @tiran
 #feature Added sanction check saving customers and sacing invoices with customizated list @waikin
 Added dropdown menu to filter customer module by Group, bottom right corner @viktor
 Make 'isInsider' checkbox only appear for managers and compliance officers. Changed condition from setEnterableIff to setVisibleIff @jonna
 #bugfix: CXR7-870 AML_Alert View Form check box status should be clickable @jonna
 #bugfix : CXR7-887 Set Notification lisbox property correctly for the bittons to work @jonna
 #bugfix : CXR7-826 Added On Display Detail form event in handleListBoxObjectMethod for relation field to work
 # Links.entry is now using a subform to display the customer info
 #feature: Links.entry has a new ☑ Beneficiary is Self:  checkbox
 #UI: new icons, new toolbar, in progress... @tiran 
 #bugfix:  CXR7 is running under v18 where the bug ACI0100567 is fixed, so there is no need for this workaround in printListBox method while exporting to HTML @milan
 #replaced all calls to OBJECT SET COLOR to OBJECT SET COLORS, 4D apllete colors are changed using convPalleteColourToRGB method @milan
 cal event stored procedure now checks for recurring event that have [CalendarEvents]RepeatsEveryNDay<=0 and sets them to 1 

 reduces the number of parameters in handleCustomerNameCompliance and handleCustomerEntityCompliance ; @waikin
 #bugfix: Agents sanction check sometimes doesn't log (because [Agents]AgentId isn't filled). Now it will not do check until [Agents]AgentId is filled ; @waikin
 udpated wapi component and webfolder
 #bugfix: PEP Check in Customer AML review will now be logged ; @waikin
 replaced all _O_C_String with C_Text ; @tiran
 #bugfix: customerID was not showing in Customer View
 #bugfix: a bug related to denomination entry in an cash transaction (in invoice) not recognizing certain denominations (reported by Shanice from BOJ): @tiran
 #UI:  AML_Alerts: added two buttons to display open and closed cases ; @tiran
 #AML: added sanction check for [ThirdParties]Entity ; @waikin
 e.g. fixed some syntax errors related to v18 -#syntax;  29 Nov 2020 ; @tiran  
*/