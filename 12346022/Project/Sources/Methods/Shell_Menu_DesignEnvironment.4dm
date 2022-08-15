//%attributes = {"publishedWeb":true}
// Project Method: Shell_Menu_DesignEnvironment

// Searching for answers? Be sure to check out the "About..." command located
// in the Apple menu (Macintosh), or the Help menu (Windows). There you can 
// find online help for this example database, as well as a listing of numerous
// 4D resources available to you.

// Method created by: Raymond Manley, 4D, Inc.

// Shortcut to take the user to the Design Environment.

C_LONGINT:C283($nDestinationProcessID)
C_TEXT:C284($tMessage)

Case of 
	: ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Desktop:K5:4) | (Application type:C494=4D Volume desktop:K5:2))
		$tMessage:="The Design Environment is not available under "
		myAlert($tMessage+"4D Runtime, 4D Runtime Classic, or 4D Engine.")
		
	: (Is compiled mode:C492)
		myAlert("The Design Environment is not available in a compiled database.")
		
	Else 
		$nDestinationProcessID:=1  // User/Custom Menus process
		POST KEY:C465(Character code:C91("u"); Command key mask:K16:1; $nDestinationProcessID)
		POST KEY:C465(Character code:C91("y"); Command key mask:K16:1; $nDestinationProcessID)
End case 