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

SEE **example.r** for usage examples

Run it with 
do %fordata.r

Try it with
do %example.r

