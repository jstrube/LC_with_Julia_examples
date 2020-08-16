# Examples for how to read LCIO files in Jupyter
The examples here are translated from the ILC tutorial https://github.com/ILDAnaSoft/miniDST.

They demonstrate how to open LCIO files, inspect them, and run a simple analysis over them.

## Prerequisites

- LCIO only works on Linux and Mac OS X.
- The examples are designed to be executed in a Jupyter notebook. This can be run either on the local machine, or on a designated Jupyterhub server.
    - For installation on the DESY Jupyterhub, please follow the instructions here: https://github.com/jstrube/LC_with_Julia_examples/blob/main/DESY_NAF_JupyterHub_HOWTO.md
    - For installation on conventional resources, you need to install the Julia programming language, which can be obtained from https://julialang.org/downloads/.

All other software can be installed through the Julia package manager.

## Getting Started
If you want to run the examples as scripts, you need to convert them to julia scripts, either by executing `jupyter nbconvert --to=script <name of notebook>`, or by copying and pasting the lines into a new file or into the julia command line (called REPL).

1. After installation, start the julia executable. You will see a prompt.
1. Type `]` to enter the package manager mode.
1. Type `add IJulia`. This downloads the Jupyter package into julia.
1. Type `build IJulia`. This builds the package and registers julia as a kernel in Jupyter.
1. Exit the package manager mode by hitting `<Backspace>`
1. You are now back at the julia prompt.
   - If you want to execute the examples here, you can continue.
   - If you want to follow the examples on a jupyterhub, you can exit julia by hitting `Ctrl + d`. When you refresh the jupyterhub page, you should see the new kernel installed.
   - If you want to run jupyter on your local resources, enter 
     ```
     using IJulia
     notebook()
     ```
      This should open a new browser tab with a Jupyter notebook server.

You are now ready to start the examples.