//%attributes = {}
// handleTodayButton (->table; ->dateField)
C_POINTER:C301($1; $2)

QUERY:C277($1->; $2->=Current date:C33)
orderByTable($1)
highlightRecords($1)
handleVRecNum