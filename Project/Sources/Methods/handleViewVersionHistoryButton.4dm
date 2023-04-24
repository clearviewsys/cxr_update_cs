//%attributes = {}
// handleVersionHistoryButton
// populate the array listbox 'mainListBox' with previous history of the method
// this method should be called from a view form of DB_CodeRevisions after a record
// has been loaded
// handleViewVersionHistoryButton ({methodName})

// this method needs a certain listbox object to go with it
// it uses SQL to load the version history into an array listbox

C_TEXT:C284($methodName; $1)

Case of 
	: (Count parameters:C259=0)
		$methodName:=[DB_CodeRevisions:103]MethodName:11
	: (Count parameters:C259=1)
		$methodName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (True:C214)
	Begin SQL
		SELECT DB_CodeRevisions.ID, DB_CodeRevisions.commitDate, DB_CodeRevisions.developer, DB_CodeRevisions.CommitMessage, DB_CodeRevisions.Comments, DB_CodeRevisions.SourceCode
		FROM DB_CodeRevisions 
		WHERE DB_CodeRevisions.MethodName = :$methodName
		ORDER BY DB_CodeRevisions.ID DESC
		INTO :arrIDs, :arrDates, :arrDevelopers, :arrSubjects, :arrComments, :arrSourceCodes
	End SQL
End if 