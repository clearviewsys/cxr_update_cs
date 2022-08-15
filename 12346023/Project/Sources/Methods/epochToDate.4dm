//%attributes = {}
// ----------------------------------------------------
// Method: epochToDate
// ---------------------------------------------------
// ----------------------------------------------------
// Does:
//      returns a timestring (ISO Date) for the Epoch given
//      the timestring returned is in local time zone
// ----------------------------------------------------
// Parameters:
// ->  $1     real     the Epoch to convert
// <-  $0     text        the ISO timestring
// ----------------------------------------------------
// Parameter Definition
C_REAL:C285($1)
C_TEXT:C284($0)
// ----------------------------------------------------
// Local Variable Definition
C_DATE:C307($d_Date)
C_TIME:C306($h_Time)
C_LONGINT:C283($l_Days)
C_LONGINT:C283($l_Seconds)
C_REAL:C285($r_Epoch)
C_TEXT:C284($t_TimeStamp)
// ----------------------------------------------------
// Parameter Assignment
$r_Epoch:=$1
// ----------------------------------------------------
$l_Days:=Trunc:C95($r_Epoch/86400; 0)/1000
$d_Date:=Add to date:C393(Date:C102("1970-01-01T00:00:00"); 0; 0; $l_Days)
$0:=String:C10($d_Date)