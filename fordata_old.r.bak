; Red []
Rebol [
	Name: "FORDATA"
	Purpose: {Run a for loop on data-table with headings
	The loop is run having the fields for each line available
	as object elements on the word you have provided
	A /WHERE refinement is available and you can specify a condition for the loop to be exectude
	}
	Version: 1.0
	Author: "Giuseppe Chillemi"
]


fordata: func [
	"Iterate a block of code on data block where columns data is using column name"
	'data-name [word!]
	;Domanda: il contesto è quello principale, oppure è quello della funzione ?
	"The object name"
	data-block [block!]
	"the source with headings on top"
	code-block [block!]
	"The code to execute"
	/where
	"Condition for data filtering"
	condition [block!]
	"Block where you can use WORD/COLUMN in a condition to express valid ROWS"
	/local
	headings
	row-obj-specs
] 
[
	headings: copy first data-block
	data-block: next data-block
	row-obj-specs: copy []
	forall data-block [
		forall  headings [
			append row-obj-specs to-set-word first headings 
			append row-obj-specs data-block/1/(index? headings)
		]
		do reduce [to-set-word data-name make object! row-obj-specs]
		either where = true [
			if all condition [
				do code-block
			]
		]
		[
			do code-block			
		]
	]
]

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

halt

; in dubbio come usarlo
; per un DO
; per un compose
; con do/compose assime
; compose implicito/esplicito
; per costruire dati
	
	
;	probe compose code-block
;	do compose/deep code-block	
	;probe so code-block ;!!!!
	
	
	
	


;perch? ROW viene trovato perch? globale ? Quindi quando fai il set da dentro, siccome esiste il globale ed
;? stato passato, allora lo si puo' usare ?
;E se uso SET invece di to-set-word ?





;	bind code-block 'loop-on ;It does not work, raw is not recognized
;	do code-block


;	probe (data-name)
;	probe do do compose/deep [to-path [(data-name) 1]]
;	probe first data-name
;	probe second data-name
;	probe third data-name

;potrei provare ad appendere solo la parola e non fare l'oggetto
																											;Si potrebbe usare anche un COMPOSE !