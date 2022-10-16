# autoit-crt
Demonstration on how to execute a remote function using the AutoIt language

## How to prepare
Step 1: Download and Install AutoIt from [here](https://www.autoitscript.com/site/autoit/downloads/)</br>
Step 2: Create a new folder and copy __autoit-crt.au3__ inside it</br>
Step 3: Make sure that `$PROCESS_NAME` in __autoit-crt.au3__ is the same as the __.exe__</br>
Step 4: Compile __test.cpp__ and move the __.exe__ in the folder you created</br>


## How to test/use
Step 1: Run the compiled test program (from ___Step 4___)</br>
Step 2: Open the **autoit-crt.au3** in the SciTE editor and __(F5) Run__ it</br>
Step 3: Type something and it will appear on the console window of the test program</br>
Step 4: If you don't see the string on the program's console window, ___something's wrong___</br>

## What could be wrong?
- You compiled (or ran) the AutoIt file as x64</br>
- You compiled __test.cpp__ as x64</br>
- The test program is not in the same directory as the AutoIt file</br>
