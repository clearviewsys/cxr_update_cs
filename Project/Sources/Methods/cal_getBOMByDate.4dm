//%attributes = {}
// cal_getBOMByDate (date) -> date

// returns the beginning of month date
//Unit test done @Zoya 

C_DATE:C307($0; $1)



$0:=cal_date(1; Month of:C24($1); Year of:C25($1))