//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($ID)
$ID:=$1

QR SET DOCUMENT PROPERTY:C772($ID; 1; 0)
QR SET DOCUMENT PROPERTY:C772($ID; 2; 0)
QR SET REPORT KIND:C738($ID; 1)

QR SET DESTINATION:C745($ID; qr HTML file:K14903:5; "")

QR SET REPORT TABLE:C757($ID; 10)

QR INSERT COLUMN:C748($ID; 1; "[Registers]Currency")
QR SET INFO COLUMN:C765($ID; 1; "Currency"; "[Registers]Currency"; 0; -128; 1; Char:C90(0))
QR INSERT COLUMN:C748($ID; 2; "[Registers]AccountID")
QR SET INFO COLUMN:C765($ID; 2; "AccountID"; "[Registers]AccountID"; 0; -128; 1; Char:C90(0))
QR INSERT COLUMN:C748($ID; 3; "[Registers]RegisterID")
QR SET INFO COLUMN:C765($ID; 3; "RegisterID"; "[Registers]RegisterID"; 0; -128; 1; Char:C90(0))
QR INSERT COLUMN:C748($ID; 4; "[Registers]DebitLocal")
QR SET INFO COLUMN:C765($ID; 4; "DebitLocal"; "[Registers]DebitLocal"; 0; -129; 1; Char:C90(0))
QR INSERT COLUMN:C748($ID; 5; "[Registers]CreditLocal")
QR SET INFO COLUMN:C765($ID; 5; "CreditLocal"; "[Registers]CreditLocal"; 0; -133; 1; Char:C90(0))

ARRAY LONGINT:C221($_L1; 1)
ARRAY LONGINT:C221($_L2; 1)
$_L1{1}:=1
$_L2{1}:=1
QR SET SORTS:C752($ID; $_L1; $_L2)
ARRAY LONGINT:C221($_L1; 0)
ARRAY LONGINT:C221($_L2; 0)

QR SET INFO ROW:C763($ID; -3; 0)
QR SET INFO ROW:C763($ID; -2; 0)
QR SET INFO ROW:C763($ID; -1; 0)
QR SET INFO ROW:C763($ID; 1; 0)

QR SET HEADER AND FOOTER:C774($ID; 1; "header"; "header"; "header"; 113)
QR SET HEADER AND FOOTER:C774($ID; 2; ""; "Page n/m"; ""; 25)

QR SET TOTALS DATA:C767($ID; 4; 1; 1)
QR SET TOTALS DATA:C767($ID; 5; -3; 1)
QR SET TOTALS DATA:C767($ID; 5; 1; 1)

QR RUN:C746($ID)