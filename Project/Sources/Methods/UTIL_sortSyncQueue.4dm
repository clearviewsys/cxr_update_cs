//%attributes = {}


ARRAY LONGINT:C221($aiRecNums; 0)
ARRAY TEXT:C222($atActions; 0)
ARRAY TEXT:C222($atPK; 0)
SELECTION TO ARRAY:C260(<>vp_Sync_Table->; $aiRecNums; <>vp_Sync_Action->; $atActions; <>vp_Sync_PK->; $atPK)

MULTI SORT ARRAY:C718($atActions; >; $atPK; >; $aiRecNums)

CREATE SELECTION FROM ARRAY:C640(<>vp_Sync_Table->; $aiRecNums)