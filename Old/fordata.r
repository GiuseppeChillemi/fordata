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
