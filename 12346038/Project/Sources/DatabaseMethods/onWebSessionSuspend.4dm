

// On Web Session Suspend
// After a period of inactivity or whenever necessary, 4D closes the session
C_TEXT:C284(WWW_SessionID)
WWW_SessionID:=""
// We store the session info
// We save the preferences of the previously connected user
//ie. ... QUERY([prefs];[prefs]Login=WWW_Username)  // kept in the session
//ARRAY TO SELECTION(prefNames;[prefs]name;prefValues;[prefs]values)

// Important: the process is then killed
// 4D deletes the variables, selections, etc.
