; Red []
Rebol [
	Name: "FORDATA"
	Purpose: {Run a for loop on data-table with headings
	The loop is run having the fields for each line available
	as object elements on the word you have provided
	A /WHERE refinement is available and you can specify a condition for the loop to be exectude (ALL BLOCK condition)
	}
	Version: 1.1
	Author: "Giuseppe Chillemi"
	TBD: {
		Investigate on the advantages of not using an object but a simple block to store row values
		whenever possible, it should avoid the overhead of context creation which should be meaningful
		for very large data blocks
		
		Investigate on a way to not make accessible to passed code other function words other than word object
	}
	History: {
		1.1: Headings block (first data block) no longer copied
		1.1: Added comments
		1.1: Remove the row word from global context
		1.1: added TBD and HISTORY to the header
	}
	Note: {}
]


fordata: func [
	"Iterate a block of code on data block where columns data is using column name"
	'data-name [word!]
	;Annotation: Word binding should be the main one once object is created. To verify, just in case 
	"The object name"
	data-block [block!]
	"the source with headings on top"
	code-block [block!]
	"The code to execute"
	/where
	"Condition for data filtering"
	condition [block!]
	"Block where you can use WORD/COLUMN in a condition to express valid ROWS (It is an ALL BLOCK condition)"
	/local
	headings
	row-obj-specs
] 
[
	
	;=== Init phase ===
	headings: first data-block																										;Get the headings on the first line of data
	data-block: next data-block																										;Data block starts from the second block on
	row-obj-specs: copy []																												;Init the specs block fort the object which will be
																																								;	named as DATA-NAME arg content

	;=== Main loop ===
	;Iterates for all data
	forall data-block [
		
		;Create the specs block assignining column values to object words which will have the same nae of the columns
		forall  headings [
			
			;Iterate throught the headings and append a SET-WORD with heading name to the object spec
			;ie: [Customer:]
			append row-obj-specs to-set-word first headings
			
			;Append the value of the corresponding column to the object specs
			;ie: [Costomer-name: "Amazon"] 
			append row-obj-specs data-block/1/(index? headings)
		]

		;The following code creates the object with the provided specs
		;Example: do [myrow: make object! [customer: "amazon"]] ;(if row name provided is MYROW)
		do reduce [to-set-word data-name make object! row-obj-specs]
		
		; Executes the block of code provided to the function
		either where = true [
			if all condition [
				do code-block
			]
		]
		[
			do code-block			
		]
	]

	;=== Cleaning ====
	;Remove the row object word from global word list
	unset data-name
]
