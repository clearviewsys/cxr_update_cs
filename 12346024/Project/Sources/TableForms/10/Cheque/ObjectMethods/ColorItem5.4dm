// Object Method: [Register].Input.Payment

// Searching for answers? Be sure to check out the "About..." menu located in the
// Apple menu (Macintosh) or the Help menu (Windows). There you can find online
// help for this example database, as well as a listing of numerous 4D resources
// available to you.

// Method created by Dave Batton, DataCraft

C_REAL:C285(vAmount)
//Self->:=Round(Self->;2)
vDollarsText:=NumToText(vAmount)+" "+[Registers:10]Currency:19
