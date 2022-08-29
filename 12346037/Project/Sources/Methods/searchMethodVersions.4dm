//%attributes = {}

// searchMethodVersions ($fromDate;$toDate; $developer)

C_DATE:C307($1; $2; $fromDate; $toDate)
C_TEXT:C284($3; $developer)
C_TEXT:C284($sql)

ARRAY LONGINT:C221(arrID; 0)
ARRAY DATE:C224(arrCommitDate; 0)
ARRAY TIME:C1223(arrCommitTime; 0)

ARRAY TEXT:C222(arrVersion; 0)
ARRAY TEXT:C222(arrDeveloper; 0)
ARRAY TEXT:C222(arrMethodName; 0)
ARRAY TEXT:C222(arrMethodPath; 0)
ARRAY TEXT:C222(arrSourceCode; 0)
ARRAY TEXT:C222(arrComments; 0)

Case of 
		
	: (Count parameters:C259=3)
		
		$fromDate:=$1
		$toDate:=$2
		$developer:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

SQL_LOGIN(serverIP; user4D; password4D)
$sql:="SELECT ID, CommitDate, CommitTime, version, Developer, MethodName, MethodPath, SourceCode, Comments"
$sql:=$sql+" FROM DB_CodeRevisions"

$sql:=$sql+" WHERE  Developer = :$developer AND CommitDate between '"+String:C10($fromDate)+"' and '"+String:C10($toDate)+"'"

//$sql:=$sql+" WHERE  ((`CommitDate` >= :$fromDate AND `CommitDate` <= :$toDate ) AND `Developer` = :$developer)"
$sql:=$sql+" ORDER BY `CommitDate` DESC "


SQL EXECUTE:C820($sql; arrID; arrCommitDate; arrCommitTime; arrVersion; arrDeveloper; arrMethodName; arrMethodPath; arrSourceCode; arrComments)
If (Ok=1)
	
	If (Not:C34(SQL End selection:C821))
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL CANCEL LOAD:C824
		SQL LOGOUT:C872
	End if 
End if 

LISTBOX SET COLUMN WIDTH:C833(*; "Column1"; 70)
LISTBOX SET COLUMN WIDTH:C833(*; "Column2"; 90)
LISTBOX SET COLUMN WIDTH:C833(*; "Column3"; 60)

LISTBOX SET COLUMN WIDTH:C833(*; "Column4"; 60)
LISTBOX SET COLUMN WIDTH:C833(*; "Column5"; 90)
LISTBOX SET COLUMN WIDTH:C833(*; "Column6"; 120)

LISTBOX SET COLUMN WIDTH:C833(*; "Column7"; 180)

