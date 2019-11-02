README version: 1.1

# fordata
A function that makes selected column data available in a for loop, with filtering

Compatible with both REBOL and RED


Run it with 

do %fordata.r

Try it with

do %example.r

USAGE:

     FORDATA 'data-name data-block code-block

DESCRIPTION: 

     Iterate a block of code on data block where columns data is using column name. 

     FORDATA is a function! value.

ARGUMENTS:

     'data-name   [word!] "The object name."
     
     data-block   [block!] "the source with headings on top."

     code-block   [block!] "The code to execute."

REFINEMENTS:

     /where       => Condition for data filtering.

          condition    [block!] {Block where you can use WORD/COLUMN in a condition to express valid ROWS.}

