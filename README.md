# Celebrate `push0`!

To celebrate the `push0` opcode's inclusion in the shapella, a minimal deployer script will deploy
the following contract to the ethereum network:

```
// 0x5f 0x5f 0xf3
push0
push0
return
```

> Note: at the time of writing, `push0` is not a valid instruction in foundry, so the
> `--skip-simulation` flag is required for the script to execute successfully.

> MORE IMPORTANT NOTE: especially since it skips simulation, you should extremely verify the
> contract is going to do what you think it is going to do. verification details and resources will
> be available below.

## Verification

The initcode declaration is as follows:

```
uint256 constant initcode = 0x62_5f_5f_f3_5f_52_60_03_60_1d_f3
```

this maps to the following instructions:

```
INIT CODE:
--------------------
push3 0x5f5ff3      // [runtime]
push0               // [zero, runtime]
mstore              // []
push1 0x03          // [runtime_size]
push1 0x1d          // [runtime_offset, runtime_size]
return              // []
--------------------

RUNTIME CODE:
--------------------
push0               // [zero]
push0               // [zero]
return              // []
--------------------
```

Sources:

- Instruction listings: https://www.evm.codes/
- Push0 EIP: https://eips.ethereum.org/EIPS/eip-3855

> Note: At the time of writing, the `push0` (`0x5f`) opcode is not listed on evm.codes, so it must
> be verified by reviewing EIP-3855

Now go read the code in [this file](./script/CelebratePush0.s.sol) and ensure it matches what you
see here.

## Execution

To execute, you will need foundry installed ([instructions here](https://book.getfoundry.sh/getting-started/installation)).

You will also need to have the `PRIVATE_KEY` environment variable set to the deployer key. The
[dotenv template](./.env.template) file may be copied into the dotenv file as follows.

```bash
cp .env.template .env
```

To run the deployer script, execute the following.

```bash
forge script script/CelebratePush0.s.sol --broadcast --skip-simulation --rpc-url <YOUR_RPC>
```

- `--broadcast` will broadcast the transaction to the network
- `--skip-simulation` bypasses the simulator (it will always fail until `push0` is added foundry)
- `--rpc-url <YOUR_RPC>` replace `<YOUR_RPC>` with a valid RPC URL
