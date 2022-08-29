CONFIRM:C162("Clear the recent picks array?"; "Clear"; "Cancel")
If (OK=1)
	READ WRITE:C146([RecentPicks:65])
	QUERY:C277([RecentPicks:65]; [RecentPicks:65]TableNo:1=Table:C252(->[Cities:60]))
	DELETE SELECTION:C66([RecentPicks:65])
	fillRecentPicksListBox
End if 