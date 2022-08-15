//%attributes = {}
// makeEmailFromInvoiceBody


C_TEXT:C284($0)
C_LONGINT:C283($i; $n)
C_TEXT:C284($message; $record; $divider; $header; $signature)

$divider:="_____________________________________________________________"


$n:=Records in selection:C76([Registers:10])
READ ONLY:C145([Registers:10])
FIRST RECORD:C50([Registers:10])

$header:=replaceEmailTags(<>emailHeader)
$signature:=replaceEmailTags(<>emailSignature)


appendToString(->$message; $header; True:C214)

//appendToString (->$message;"Electronic receipt generated by CurrencyXchanger "+getCurrentVersion ;True)

appendToString(->$message; $divider; True:C214)

appendLabelString(->$message; "Invoice:"; [Invoices:5]InvoiceID:1; True:C214)
appendLabelString(->$message; "Date:"; String:C10([Invoices:5]invoiceDate:44); True:C214)
appendLabelString(->$message; "Customer:"; [Invoices:5]CustomerFullName:54; True:C214)
appendLabelString(->$message; "Address:"; [Invoices:5]CustomerFullAddress:59; True:C214)
appendLabelString(->$message; "Main Phone:"; [Customers:3]HomeTel:6; True:C214)
appendLabelString(->$message; "Cell Phone:"; [Customers:3]CellPhone:13; True:C214)

appendToString(->$message; $divider; True:C214)



C_OBJECT:C1216($entity)

$entity:=New object:C1471
$entity:=ds:C1482.WebEWires.query("paymentInfo.invoiceID == :1"; [Invoices:5]InvoiceID:1)

If ($entity.length=1)
	appendLabelString(->$message; "MoneyGram Reference:"; $entity[0].paymentInfo.result.referenceNumber; True:C214)
	appendToString(->$message; $divider; True:C214)
End if 



For ($i; 1; $n)
	$record:=serializeRecRegister
	$message:=$message+$record+CRLF
	NEXT RECORD:C51([Registers:10])
End for 
appendToString(->$message; $divider; True:C214)
appendToString(->$message; $signature; True:C214)
appendToString(->$message; <>DISCLAIMER; True:C214)

//@Zoya - 28 Aug 2021
If ([Bookings:50]BookingID:1#"")
	appendToString(->$message; getKeyValue("email.config.booking.declaration"); True:C214)
End if 

$0:=$message