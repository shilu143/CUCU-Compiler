How to run and compile the code

    1. First of all we have to change the directory of the terminal
        to the folder where the lex and yacc files are present.
    2. Now type "flex cucu.l" and press enter
    3. Type "bison -d cucu.y" and enter
    4. Type "cc lex.yy.c cucu.tab.c -o cucu" and enter

    5. Lastly to run the program, type "./cucu filename.cu" and enter



    ASSUMPTION:

    1. for,do while loop are not defined
    2. arithmetic operation of function is not working