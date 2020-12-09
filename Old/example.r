; Red []
Rebol [
  Name: "Test script"
  purpose: "Simple test file"
  Author: "Giuseppe Chillemi"
  Version: 1.0
]

do %fordata.r

dataset: [
	[CUSTOMER_CD Name Contact Role Personal-Number Interest]
	[001 "Amazon" "Jeff Bezos" "President" "0012666999" "BOOK: How to keep you money safe from world taxation"]
	[002 "Microsoft" "Bill Gates" "Programmer" "0019852029" "BOOK: How to code in Basic" ]
	[003 "Apple" "Steeve Wozniac" "President " "001196868FREE" "COURSE: How to make money with free software"]	
]

dataset2: [
	[type Number date]
	["OL" 1 06/06/2019]
	["OC" 2 01/01/2019]	
]

Print ["----------- Basic usage ------------"]

fordata row dataset [
	print ["Person: " row/contact "-- Interested in: " row/interest]
]


Print ["----------- Composing and running  ------------"]

code: copy []

fordata row dataset [
	append code compose/deep [print ["Person: " (row/contact) "-- Interested in: " (row/interest)]]
]

do code

Print ""
Print ["----------- Composing String ------------"]

dialer-text: copy ""

fordata row dataset [append dialer-text rejoin [
	"Customer: Mr. " row/contact " Phone#: " row/personal-number " Interested in: " row/interest " "lf ]
]

print dialer-text

query-text: copy ""

Print ""
Print ["----------- Composing a query ------------"]

fordata row dataset [append query-text rejoin [
	"insert into Persons (Contact, personal-number) values ( '" row/contact "' , '" row/personal-number "' );"lf]
]

print query-text

Print ["----------- Nested usage ------------"]

fordata docs dataset2 [
	fordata row dataset [
		print ["document: " docs/type " Person: " row/contact "-- Interested in: " row/interest]
	]
]

Print ["----------- Nested usage and condition ------------"]

fordata docs dataset2 [
	fordata/where row dataset [
		print ["document: " docs/type " Person: " row/contact "-- Interested in: " row/interest]
	] [row/name = "amazon"]
]
