# Examples for how to read LCIO files in Jupyter
The examples here are translated from the ILC tutorial https://github.com/ILDAnaSoft/miniDST.

They demonstrate how to open LCIO files, inspect them, and run a simple analysis over them.

## Prerequisites

- LCIO only works on Linux and Mac OS X.
- The examples are designed to be executed in a Jupyter notebook. This can be run either on the local machine, or on a designated Jupyterhub server.
    - For installation on conventional resources (laptop/desktop/...), you need to install the Julia programming language, which can be obtained from https://julialang.org/downloads/.
    - For installation on the DESY Jupyterhub, please follow the instructions here: https://github.com/jstrube/LC_with_Julia_examples/blob/main/DESY_NAF_JupyterHub_HOWTO.md
    - On OSG, Julia has been installed in a central location. All you need is
      ```
      module use /collab/project/snowmass21/software/modulefiles
      module load julia-1.5.1
      ```

All other software can be installed through the Julia package manager.

## Getting Started

1. After installation, start the julia executable. You will see a prompt.
1. Type `]` to enter the package manager mode.
1. Type `add IJulia`. This downloads the Jupyter package into julia.
1. Type `build IJulia`. This builds the package and registers julia as a kernel in Jupyter.
1. Exit the package manager mode by hitting `<Backspace>`
1. You are now back at the julia prompt.
   - If you want to execute the examples here, you can continue.
   - If you want to follow the examples on a jupyterhub, you can exit julia by hitting `Ctrl + d`. When you refresh the jupyterhub page, you should see the new kernel installed.
   - If you want to execute the jupyter notebooks on your local laptop/desktop/..., enter 
     ```
     using IJulia
     notebook()
     ```
      This should open a new browser tab with a Jupyter notebook browser.
1. Download the `.ipynb` notebook files from this directory and execute them.

On OSG, if you've logged in with port forwarding, you can now start a jupyter server
   ```
   source /cvmfs/belle.cern.ch/tools/b2setup release-04-02-08
   jupyter notebook --no-browser --port=<your forwarded port>
   ```

You are now ready to start the examples.
If you want to run the examples as scripts (not as notebooks), you need to convert them to julia scripts, either by executing `jupyter nbconvert --to=script <name of notebook>`, or by copying and pasting the lines into a new file or into the julia command line (called REPL).
