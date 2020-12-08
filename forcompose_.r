Red [
	;forcompose
	;test della funzione , se il concetto va bene
	;alpha

]


forcompose: function [
	"Purpose: run a block of code on a data block with headings iterating column values in object"
	'data-name
	"The object name"
	data-block
	"the source with headings on top"
	code-block
	"The code to execute"
	/deep
	"Code in parens is reduce in blocks too"
	/names
	"Only names are available and code is not compose"
	/ora

] 
[
	idx: 0
	headings: copy first data-block
	data-block: next data-block
	row-obj-specs: copy []
	forall data-block [
		forall  headings [
			append row-obj-specs to-set-word first headings 
			append row-obj-specs data-block/1/(index? headings)
		]
		do reduce [to-set-word data-name make object! row-obj-specs]
		case [
			ora = true 	[do code-block print "---ora---"]
			deep = true 	[do compose/deep code-block]
			true [do code-block]
		]
	
	]

]

dataset: [
	[CUSTOMER_CD Name Contact Role Personal-Number Interest]
	[001 "Amazon" "Jeff Bezos" "President" "0012666999" "'How to keep you money safe from world taxation'"]
	[002 "Microsoft" "Bill Gates" "Programmer" "0019852029" "'How to code in Basic'" ]
	[003 "Apple" "Steeve Wozniac" "President " "001196868FREE" "'How to make money with free software'"]	
]


Print ["----------- NOCOMPOSE ------------"]

forcompose/ora row dataset [
	print ["Person: " row/contact "Interest: " row/interest]
]


Print ["----------- Running Code ------------"]

forcompose/deep row dataset [
	print ["Person: " (row/contact) "Interest: " (row/interest)]
]





Print ["----------- Composing and running  ------------"]

code: copy []

forcompose/names row dataset [
	append code compose/deep copy [print ["Person: " (row/contact) "Interest: " (row/interest)]]
]

do code

Print ""
Print ["----------- Composing String ------------"]

dialer-text: copy ""

forcompose/names row dataset [append dialer-text rejoin [
	"Customer: Mr. " (row/contact) " Phone#: " (row/personal-number) " Interest: "(row/interest)" "lf ]
]

print dialer-text

query-text: copy ""

Print ""
Print ["----------- Composing a query ------------"]

forcompose/names row dataset [append query-text rejoin [
	"insert into Persons (Contact, personal-number) values (" (row/contact) "," (row/personal-number) " );"lf]
]

print query-text



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