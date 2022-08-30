//%attributes = {}

COPY NAMED SELECTION:C331([MainAccounts:28]; getTableNamedSelection(->[MainAccounts:28]))

//selectAccountsInDateRange (vFromDate;vToDate;numToBoolean (cbApplyDateRange))  ` first select all registers / accounts in the date range
//QUERY SELECTION([Accounts];[Accounts]MainAccountID=[MainAccounts]MainAccountID)  ` then select the main accounts
relateMany(->[Accounts:9]; ->[Accounts:9]MainAccountID:2; ->[MainAccounts:28]MainAccountID:1)

acc_fillAccouctsListBox

USE NAMED SELECTION:C332(getTableNamedSelection(->[MainAccounts:28]))
CLEAR NAMED SELECTION:C333(getTableNamedSelection(->[MainAccounts:28]))