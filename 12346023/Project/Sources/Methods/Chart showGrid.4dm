//%attributes = {"publishedWeb":true}
// Chart showGrid (area;object;major/minor;cat;value)
// show or hide grids for cat, series and value axis

// area: longint
// object: int
// major/minor: boolean true = major
// cat, value: boolean true = show


C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3; $4; $5)

//Ô14500;32Ô ($1;$2;0;Num($3);Num($4))  // show/hide category grids

//Ô14500;32Ô ($1;$2;2;Num($3);Num($5))  // show/hide values grids
