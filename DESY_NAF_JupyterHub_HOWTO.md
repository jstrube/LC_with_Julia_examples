# How to get started with LCIO on the DESY JupyterHub

This set of instructions should get you started with Julia on the DESY NAF.
This assumes you have already an account.

The instructions should be directly applicable to your home institution's JupyterHub, or to your local Jupyter server.
We will first install a jupyter kernel for Julia. 

1. Navigate to https://naf-jhub.desy.de/user and log in with your credentials. Use the "Default" domain and select the "Jupyter Lab with user extensions".
1. Start the terminal (Under "Other")
1. Downlowd the latest stable Julia binary for x84_64 Linux (at the time of this writing v1.4.2) 
    ```
    wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.2-linux-x86_64.tar.gz
    tar xzf julia-1.4.2-linux-x86_64.tar.gz
    ```
1. Open the julia binary and install the IJulia package
    ```
    julia-1.4.2/bin/julia
    ]
    add IJulia
    build IJulia
    <Backspace>
    <Ctrl + d>
    ```
1. Refresh your browser page. You should now see a Jupyter kernel for Julia.
