
VHDL
====

Structure
---------

File structure goes like this:

    |
    +- modules-\        is for the HDL level code 
    |          |
    |          +- <module name> -\
    |          |                 |
    |                            +- hdl    for HDL sources 
    |                            |
    |                            +- tb     for testbenches
    |
    \- toplevel -\
                 |
                 +- <target> -\
                 |            |
                              +- ISE    ISE Project goes here [^1].
                              |
                              \- ...    implementation files (toplevel.vhd, board.ucf, ..)

[^1]: Only the files really needed like *.xise or *.ise


Naming & Coding Conventions
---------------------------

- All filenames are lower case, names separated by underscores
  - Testbenches end in "_tb.vhd"

- All keywords are lower case!
- Generics are UPPER CASE.

- All signals (except "clk" and "reset") in the port list get the suffix "_p"
- Low active signals should be avoid. If neccessary they get the suffix "_n"
  (or "_np" when they are in the port list).
- Packages get the suffix _pkg

- Always use named association when instantiating sub-modules.

- Use the 'two-process' method whenever possible, see [A structured VHDL design method][two-process]
- Use records types to group associated signals

- Use 3 spaces for indention (Emacs default VHDL style)

[two-process]: www.gaisler.com/doc/vhdl2proc.pdf
