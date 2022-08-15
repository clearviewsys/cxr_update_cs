//%attributes = {}
// createBankNotes( countryCode; bankNoteID; Description ; denomination;prefix;postfix;currency)

C_TEXT:C284($1; $2; $3; $5; $6; $7)
C_REAL:C285($4)

READ WRITE:C146([BankNotes:23])
CREATE RECORD:C68([BankNotes:23])
[BankNotes:23]CountryCode:2:=$1
[BankNotes:23]BankNotesID:1:=$2
[BankNotes:23]CatNo:3:=Num:C11(Substring:C12($2; 3))
[BankNotes:23]Description:4:=$3
[BankNotes:23]Denomination:5:=$4
[BankNotes:23]Prefix:6:=$5
[BankNotes:23]Postfix:7:=$6
[BankNotes:23]CurrencyCode:8:=$7
SAVE RECORD:C53([BankNotes:23])
UNLOAD RECORD:C212([BankNotes:23])
READ ONLY:C145([BankNotes:23])