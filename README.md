# FundMe Foundry project

## Setup

```bash
forge init
```

Install the chainlink/contracts packages

```bash
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
```

We have now to do a remapping in our `foundry.toml` to link the `@chainlink/contract` to the `chainlink-brownie-contract`lib.
Add this line :

```toml
remappings = [
    "@chainlink/contracts/=lib/chainlink-brownie-contracts/contracts/",
]
```

Than run :

```bash
forge build
# OR
forge compile
```

## Tests

Create a new file in `test/FundMeTest.t.sol` :

```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";

contract FundMeTest is Test {
    uint256 number;

    function setUp() external {
        number = 1;
    }

    function testDemo() public {
        console.log(number);
        assertEq(number, 1);
    }
}
```

Run `forge test` to execute the tests and `forge test -vv` to see the logs.

Run `forge test --match-test testPriceFeedVersionIsAccurate` to only run this test function.

If we have to interact with a real contract in a real chain, we can forked a network during the test like thie :

```bash
forge test --match-test testPriceFeedVersionIsAccurate -vvv --fork-url $SEPOLIA_RPC_URL
```

In this case, we run the `testPriceFeedVersionIsAccurate` test in a copy of sepolia chain. So this time, the test passed.

### Coverage

To see the coverage that tests covered, you can run :

```bash
forge coverage --fork-url $SEPOLIA_RPC_URL
```

## Deploy

```bash
anvil
# And in another terminal :
forge script script/DeployFundMe.s.sol --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast
```

## Storage Optimization

To see the contract storage :

```bash
forge inspect <contract-name> storageLayout
# Example :
forge inspect FundMe storageLayout
```

To see the slot of existing contracts :

```bash
cast storage <contract-address> <slot-number>
# Example :
cast storage 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 2
```

## Makefile

```makefile
-include .env

build:; forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --account 0x14 --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
```

To execute :

```bash
make build
make deploy-sepolia
```
