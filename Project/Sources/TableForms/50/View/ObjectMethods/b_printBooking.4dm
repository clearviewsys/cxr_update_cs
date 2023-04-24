// getbuild
C_TEXT:C284($printForm)

// get
//getKeyValueDescription
$printForm:=getKeyValue("Bookings.print.Form"; "print")

If ($printForm#"")
	FORM SET OUTPUT:C54([Bookings:50]; $printForm)  // Select the right output form for printing
	PRINT RECORD:C71([Bookings:50])  // Print Invoices as it is (without showing the printing dialog boxes)
	FORM SET OUTPUT:C54([Bookings:50]; "listbox")  // Restore the previous output form
End if 