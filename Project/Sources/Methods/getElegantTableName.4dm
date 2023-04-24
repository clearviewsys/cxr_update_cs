//%attributes = {"publishedWeb":true}
//getElegantTableName(->[table]) -> String

// seeAlso : getElegantTableNameByNum (tableNum) -> string

// returns a human readable table title
C_POINTER:C301($1; $tablePtr)

Case of 
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		$tablePtr:=->[Currencies:6]
End case 


ARRAY TEXT:C222($tableNameArr; Get last table number:C254)  // Human readable table name

$tableNameArr{Table:C252(->[Accounts:9])}:="Subledger Accounts"
$tableNameArr{Table:C252(->[AccountInOuts:37])}:="Accounts In/Out Journal"
$tableNameArr{Table:C252(->[Audit:118])}:="Audit Controls Log"
$tableNameArr{Table:C252(->[AuditControls:117])}:="Audit Controls"

$tableNameArr{Table:C252(->[WebSessions:15])}:="Logged-In Users"
$tableNameArr{Table:C252(->[Agents:22])}:="Agents (Trusted Channels)"

$tableNameArr{Table:C252(->[BackupLogs:47])}:="Backup Logs"
//$tableNameArr{Table(->)}:="Individuals on Goverment Black List"

$tableNameArr{Table:C252(->[CalendarEvents:80])}:="Calendar Events"
$tableNameArr{Table:C252(->[CallLogs:51])}:="Customer Notes"
$tableNameArr{Table:C252(->[CashAccounts:34])}:="Cash Accounts"
$tableNameArr{Table:C252(->[CashRegisters:33])}:="Cash Register Machines"
$tableNameArr{Table:C252(->[CashInventory:35])}:="Denominations Inventory"
$tableNameArr{Table:C252(->[CashInOuts:32])}:="Denominations d"
$tableNameArr{Table:C252(->[CashTransactions:36])}:="Cash Transactions"
$tableNameArr{Table:C252(->[ChequeBooks:43])}:="Check books"
$tableNameArr{Table:C252(->[ClientPrefs:26])}:="Client Preferences"
$tableNameArr{Table:C252(->[CurrencyGroups:20])}:="Currency Groups"
$tableNameArr{Table:C252(->[CSMRelations:89])}:="Customer Interrelations"

$tableNameArr{Table:C252(->[ExceptionsLog:75])}:="Exceptions Log"

//$tableNameArr{Table(->[Denominations])}:="Currency Denominations"
$tableNameArr{Table:C252(->[eWires:13])}:="eWire Transactions"

$tableNameArr{Table:C252(->[FeeStructures:38])}:="Fee Structures"
$tableNameArr{Table:C252(->[FieldConstraints:69])}:="Database Field Constraints"

$tableNameArr{Table:C252(->[Invoices:5])}:="Invoices"

$tableNameArr{Table:C252(->[LetterTemplates:53])}:="Custom Letter Templates"

$tableNameArr{Table:C252(->[Links:17])}:="Links / Counterparties"

$tableNameArr{Table:C252(->[MACs:18])}:="Workstations Certification"
$tableNameArr{Table:C252(->[MainAccounts:28])}:="General Ledger Accounts"
$tableNameArr{Table:C252(->[MESSAGES:11])}:="eMessage Center"
$tableNameArr{Table:C252(->[LinkedDocs:4])}:="Attached Documents (Linked Docs)"

$tableNameArr{Table:C252(->[Registers:10])}:="Journal Registers"

$tableNameArr{Table:C252(->[SystemLogs:21])}:="System Log"
$tableNameArr{Table:C252(->[ServerPrefs:27])}:="Server Preferences"

$tableNameArr{Table:C252(->[TransferTemplates:54])}:="Transfer Templates"

$tableNameArr{Table:C252(->[IC_FailedRecords:49])}:="Failed Integrity Checks"
$tableNameArr{Table:C252(->[IntegrityChecks:48])}:="Integrity Checks"
$tableNameArr{Table:C252(->[ItemCategories:45])}:="Item Categories"
$tableNameArr{Table:C252(->[ItemInOuts:40])}:="Items Inventory Log"

$tableNameArr{Table:C252(->[Letters:52])}:="Letters"
$tableNameArr{Table:C252(->[LetterTemplates:53])}:="Letter Templates"

$tableNameArr{Table:C252(->[RegistersAuditTrail:88])}:="Audit Trail (Registers)"


$tableNameArr{Table:C252(->[WebAccessLog:16])}:="Online users activity log"


$tableNameArr{Table:C252(->[WebUsers:14])}:="Web Users"
$tableNameArr{Table:C252(->[Wires:8])}:="Wire Transfers"
$tableNameArr{Table:C252(->[WireTemplates:42])}:="Wire Templates"
$tableNameArr{Table:C252(->[ThirdParties:101])}:="Third Parties"

$tableNameArr{Table:C252(->[WebEWires:149])}:="Send Money Requests"

If (Is nil pointer:C315($tablePtr))
	$0:="n/a"
Else 
	If ($tableNameArr{Table:C252($tablePtr)}="")
		$0:=Table name:C256($tablePtr)
	Else 
		$0:=$tableNameArr{Table:C252($tablePtr)}
	End if 
End if 