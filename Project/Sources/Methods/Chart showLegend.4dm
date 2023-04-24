//%attributes = {"publishedWeb":true}
// Chart showLegend (area;object;show/hide;orientation;location)
// show or hide grids for cat, series and value axis

// area: longint
// object: int
// show/hide: boolean true=show
// orientation: boolean TRUE=VERTICAL
// location code

// 1 - 7 - 3
// 5 - - - 6
// 2 - 8 - 4


C_LONGINT:C283($1; $5)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3; $4)

//Ô14500;39Ô ($1;$2;Num($3);Num($4);-1;-1;$5)  // Show/hide the legend P.94