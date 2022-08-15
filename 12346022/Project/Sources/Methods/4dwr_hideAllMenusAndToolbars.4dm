//%attributes = {}
// this method hides all menus, status bar, toolbars from a 4D Write document
// this should be called on a "view" page

C_LONGINT:C283($1)
// hide the menus and rulers
If (is4DWriteAvailable)
	//‘12000;109‘ ($1;‘k12003;11‘;0)
	//‘12000;109‘ ($1;‘k12003;3‘;0)
	//‘12000;109‘ ($1;‘k12003;10‘;0)
	//‘12000;109‘ ($1;‘k12003;14‘;0)
	//‘12000;109‘ ($1;‘k12003;12‘;0)
	//‘12000;109‘ ($1;‘k12003;13‘;0)
	//‘12000;109‘ ($1;‘k12003;15‘;0)
End if 