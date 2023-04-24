//%attributes = {}
Case of 
	: ([AML_Alerts:137]status:8=1)
		stampText("stamp_Resolved"; "Resolved ✔"; "green"; ([AML_Alerts:137]status:8=1) & ([AML_Alerts:137]resolutionNotes:14#""))
	: ([AML_Alerts:137]status:8=2)
		stampText("stamp_Resolved"; "In Progress"; "grey")
	Else 
		stampText("stamp_Resolved"; "Pending"; "red")
End case   //handleTristateCheckBox (Self;->[AML_Alerts]status;"Resolved?";"Resolved ✔";"Unresolved")