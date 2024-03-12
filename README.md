# FundMe Foundry project

## Setup

```bash
forge init
```

Install the chainlink/contracts packages
```bash
forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit
```

We have now to do a remapping in our `foundry.toml` to link the `@chainlink/contarct` to the `chainlink-brownie-contract`lib.
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
In this case, we run the `testPriceFeedVersionIsAccurate`test in a copy of sepolia chain. So this time, the test passed.

### Coverage

To see the coverage that tests covered, you can run :
```bash
forge coverage --fork-url $SEPOLIA_RPC_URL
```