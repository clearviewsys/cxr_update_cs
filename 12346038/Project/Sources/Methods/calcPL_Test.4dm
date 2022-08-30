//%attributes = {}


C_REAL:C285($buy; $sell; $rate; $buyAvg; $shortAvg; $inventory; $profit)

// case 1: buy 100 @ 1.1
calcPLRow(100; 0; 1.1; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
// profit: 0

ASSERT:C1129($profit=0)
ASSERT:C1129($buyAvg=1.1)
ASSERT:C1129($shortAvg=0)
ASSERT:C1129($inventory=100)

// case 2: sell 100 @ 1.2
calcPLRow(0; 100; 1.2; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)

ASSERT:C1129($profit=10)
ASSERT:C1129($buyAvg=1.1)
ASSERT:C1129($shortAvg=0)
ASSERT:C1129($inventory=0)

// case 3: sell 100 @ 1.3

calcPLRow(0; 100; 1.3; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)

ASSERT:C1129($profit=0)
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1.3)
ASSERT:C1129($inventory=-100)

// case 4: buy 50 @ 1.2
calcPLRow(50; 0; 1.2; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)

ASSERT:C1129($profit=5)  // 50 * (1.3-1.2) = 50 * 0.1 = 5
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1.3)
ASSERT:C1129($inventory=-50)


// case 5: Buy 100 @ 1.1
calcPLRow(100; 0; 1.1; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)

ASSERT:C1129($profit=10)
ASSERT:C1129($buyAvg=1.1)
ASSERT:C1129($shortAvg=0)
ASSERT:C1129($inventory=50)

// case 6: Sell 200 @ 1.4
calcPLRow(0; 200; 1.4; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=15)
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1.4)
ASSERT:C1129($inventory=-150)


// case 7: Sell 100 @ 1.5
calcPLRow(0; 100; 1.5; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=0)
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1.44)
ASSERT:C1129($inventory=-250)

// case 8: Buy 300 @ 1.2
calcPLRow(300; 0; 1.2; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=60)
ASSERT:C1129($buyAvg=1.2)
ASSERT:C1129($shortAvg=0)
ASSERT:C1129($inventory=50)


// case 9: Sell 100 @ 1.1
calcPLRow(0; 100; 1.1; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=-5)
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1.1)
ASSERT:C1129($inventory=-50)

// case 10: Buy 150 @ 1
calcPLRow(150; 0; 1; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=5)
ASSERT:C1129($buyAvg=1)
ASSERT:C1129($shortAvg=0)
ASSERT:C1129($inventory=100)

// case 11: Sell 1000 @ 1
calcPLRow(0; 1000; 1; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=0)
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1)
ASSERT:C1129($inventory=-900)

// case 11: Sell 100 @ 1.1
calcPLRow(0; 100; 1.1; ->$inventory; ->$buyAvg; ->$shortAvg; ->$profit)
ASSERT:C1129($profit=0)
ASSERT:C1129($buyAvg=0)
ASSERT:C1129($shortAvg=1.01)
ASSERT:C1129($inventory=-1000)