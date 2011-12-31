ANBasic
=======

ANBasic is my personal spin on the primitive programming language used on my Casio fx-9750G Plus calculator. This project is going to process a script in ANBasic, process and tokenize it, group the tokens, and compile it to my own proprietary binary format. This project also includes a runtime that loads a compiled ANBasic script, and executes it, printing output to the console.

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

Sample Usage
============

The ANBasic project comes with two components: a compiler and a runtime. The compiler converts an ANBasic script file into a binary file, and the runtime executes the binary file. Let's say you have stored an ANBasic script into the file *myfile.anb*. This script could be compiled by entering the following command in Terminal:

    ./ANBasicCompiler myfile.anb -o myfile.bin

The compiled byte-code of the original script will be written to myfile.bin, and can be executed through the ANBasic runtime:

    ./ANBasicRuntime myfile.bin

Current Progress
================

Both the ANBasic compiler and runtime are almost complete, needing only a few tweaks before being stable and completely usable. Both the compiler and the runtime work as they should for all of the tests that I have run. All that is needed now is proper documentation for the ANBasic language, which may or may not become a reality in the future.

Code Grouping
-------------

For those who are interested, these are the steps that my program goes through in order to process ANBasic scripts:

* Tokenize the script, splitting up operators, control functions, variable names, and strings
* Convert '-' operators into negation functions where appropriate
* Group mathematical expressions together using PEMDAS
* If a line in the script appears to begin a control block, such as a while loop or if statement, the body of the control block will be read recursively via custom methods for different types of control blocks.
  * In the special case of If statements, lines after Then or Else control tokens are explicitly processed by the special If block reader method.
* All lines and control blocks are put into a root control block

License
=======

Copyright (c) 2011, Alex Nichol
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
