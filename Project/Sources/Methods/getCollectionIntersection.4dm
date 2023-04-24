//%attributes = {}
// getCollectionIntersection (col1 ; col2) -> intersection
// the Whole team wrote this one
// Col1 should be the smaller collection preferrably : it will be faster

#DECLARE($col1 : Collection; $col2 : Collection)->$int : Collection

$int:=$col1.filter("isInCollection"; $col2)