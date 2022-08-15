//%attributes = {}


// parent process = SP_managerProcess
// manager's job is to make sure other stored procedures are running. currently this includes:
//.    SP_calendarEventsProcess
//.    SP_notificationProcess 
//.    SP_updateRatesProcess

//shutting down the manager will shut down other stored procedures
