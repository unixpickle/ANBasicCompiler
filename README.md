ANBasic
=======

ANBasic is my personal spin on the primitive programming language used on my Casio fx-9750G Plus calculator. This project is going to process a script in ANBasic, process and tokenize it, group the tokens, and compile it to my own proprietary binary format. I will then make another project that is able to execute ANBasic binary files.

Sample ANBasic
==============

Here is a basic example of something that one could write in ANBasic to estimate a number's square root. Note that I use # to denote comments, although this is invalid ANBasic syntax, as ANBasic supports no such luxury as comments:

    ?->A # read a number from the console into the variable A
    0->L
    A->H
    For 1->I To 30 # run a loop (up to the Next) 30 times
    (H+L)/2->G # take the average of H and L
    If G^2>A
    Then G->H # assign H = G
    Else G->L # assign L = G
    IfEnd
    Next
    (H+L)/2 # since this is the last expression in the document,
            # the result will be printed at the end of execution

Current Progress
================

As of now, this code is able to process any ANBasic script file, and can group control blocks, mathematical expressions, etc. It then outputs the structure that the compiled binary file would follow. My next step will be to implement a binary encoder for the existing ANBasicToken representation that my classes generate. Scripts are processed by going through the following stages:

* Tokenize the script, splitting up operators, control functions, variable names, and strings
* Convert '-' operators into negation functions where appropriate
* Group mathematical expressions together using PEMDAS
* If a line in the script appears to begin a control block, such as a while loop or if statement, the body of the control block will be read recursively via custom methods for different types of control blocks.
  * In the special case of If statements, lines after Then or Else control tokens are explicitly processed by the special If block reader method.
* All lines and control blocks are put into one, root control block.
