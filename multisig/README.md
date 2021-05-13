Elrond multisig proofs
======================

Setup
-----

* Install [Bazel](https://docs.bazel.build/versions/4.0.0/install.html)
* Install [K](https://github.com/kframework/k/releases)
* Clone this repository
  ```
  git clone git@github.com:virgil-serbanuta/verified-smart-contracts
  ```
* Setup K (make sure that the `K`'s `bin` directory is in `$PATH`)
  ```
  cd verified-smart-contracts/multisig
  cd kompile_tool
  ./prepare-k.sh
  cd ..
  ```

Unless specified otherwise, all following commands should be run in
`verified-smart-contracts/multisig`

Running proofs
--------------

Running all proofs as tests (default option):
```
cd verified-smart-contracts/multisig
bazel test //protocol-correctness/...
```

Running specific proof as test:
```
bazel test //protocol-correctness/proof/functions:proof-count-can-sign
```

If your hardware is different enough from the one where test timepouts were
configured, or if you run one of the tests not optimized yet, you may
get timeouts. If that happens, you can run proofs one by one like this:
```
bazel run //protocol-correctness/proof/functions:proof-count-can-sign
```

Wasm proofs
===========

1. Build https://github.com/WebAssembly/wabt and add it to `$PATH`
   ```
   git clone --recursive git@github.com:/WebAssembly/wabt
   cd wabt

   mkdir build
   cd build
   cmake ..
   cmake --build .

   export PATH=$(pwd):$PATH
   cd ../..
   ```
2. Install erdpy https://docs.elrond.com/sdk-and-tools/erdpy/installing-erdpy/
   ```
   sudo apt install libncurses5
   wget -O erdpy-up.py https://raw.githubusercontent.com/ElrondNetwork/elrond-sdk/master/erdpy-up.py
   python3 erdpy-up.py
   ```
3. Install venv:
   ```
   sudo apt-get install python3-venv
   ```
4. Install and configure rustup:
   ```
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

   rustup toolchain install nightly
   rustup default nightly
   rustup target add wasm32-unknown-unknown
   ```
5. Build the multisig contract
   ```
   git clone git@github.com:ElrondNetwork/elrond-wasm-rs

   cd elrond-wasm-rs
   erdpy contract build contracts/examples/multisig --wasm-symbols
   cd ..
   ```
   The wasm file will be generated as
   `elrond-wasm-rs/contracts/examples/multisig/wasm/target/wasm32-unknown-unknown/release/multisig_wasm.wasm`. If you want, you can convert it to a `wat` file:
   ```
   dir=elrond-wasm-rs/contracts/examples/multisig/wasm/target/wasm32-unknown-unknown/release; wasm2wat $dir/multisig_wasm.wasm > $dir/multisig_wasm.wat
   ```
6. Clone this repository:
   ```
   git clone git@github.com:virgil-serbanuta/verified-smart-contracts
   cd verified-smart-contracts/multisig
   git submodule update --init --recursive
   ```
7. Copy the contract to the `wasm/code` directory:
   ```
   cp ../../elrond-wasm-rs/contracts/examples/multisig/wasm/target/wasm32-unknown-unknown/release/multisig_wasm.* wasm/code
   ```
8. Compile the wasm semantics:
   ```
   cd wasm
   make --directory elrond-semantics/deps/wasm-semantics build-haskell DEFN_DIR=$(pwd)/.build
   ```
9. Random stuff
   ```
   python3 -m pip install pysha3
   python3 -m pip install numpy
   python3 -m pip install toolz
   sudo apt install libprocps-dev

   cd elrond-semantics
   make build-llvm
   cd ..
   ```