//%attributes = {}
// Calc Colour(foreground ; background ) -> integer

// returns the colour number for the related foreground and background


C_LONGINT:C283($1; $2; $0)

$0:=-($1+(256*$2))

