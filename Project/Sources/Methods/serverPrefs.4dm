//%attributes = {}
// how to add a field to the Server Preferences 


// 1) add the field in the ServerPrefs  [ServerPrefs]
// 2) add the field in the serverPrefs Preferences dialog ([ServerPrefs];"Preferences")
// 3) initialize the interprocess variable with exact name of the field in initServerPrefsVars 
// 4) declare the interprocess var in Compiler_Variables_Inter

// 5) Set default values in loadServerPreferences