
<div align="left">
  <h1>PandoraToken ERC20 Project</h1>
  <p><b>Solidity ERC20 token and Foundry development environment</b></p>
  <p>
    <img alt="Solidity version" src="https://img.shields.io/badge/solidity-%5E0.8.27-blue?logo=solidity">
    <img alt="License" src="https://img.shields.io/badge/license-MIT-green">
    <img alt="Tests" src="https://img.shields.io/badge/tests-100%25%20coverage-brightgreen">
  </p>
</div>


## 🚀 Overview

PandoraToken is a modern ERC20 token implementation using [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) and [Foundry](https://github.com/foundry-rs/foundry) for development, testing, and deployment.

---

## 📦 Features

- Fully tested ERC20 token contract (`PandoraToken.sol`)
- Permit support (EIP-2612)
- 100% test coverage with Foundry
- Modern Solidity (0.8.27+)
- Includes deployment scripts and Makefile automation

---

## 🗂️ Directory Structure

```text
src/                # Solidity contracts (PandoraToken.sol)
script/             # Deployment scripts (DeployPandoraToken.s.sol)
test/               # Foundry tests (PandoraToken.t.sol)
lib/                # External dependencies (OpenZeppelin, forge-std)
foundry.toml        # Foundry configuration
Makefile            # Automation commands
```

---

## 🛠️ Quick Start

### 1. Install Dependencies

```sh
forge install
```

### 2. Build Contracts

```sh
forge build
```

### 3. Run Tests

```sh
forge test --match-contract PandoraTokenTest
```

### 4. Deploy Locally

```sh
make anvil
make deploy
```

---

## 📝 Example: PandoraToken.sol

```solidity
contract PandoraToken is ERC20, ERC20Permit {
    constructor(uint256 initialSupply)
        ERC20("PandoraToken", "PT")
        ERC20Permit("PandoraToken")
    {
        _mint(msg.sender, initialSupply);
    }
    // ... increaseAllowance, decreaseAllowance ...
}
```

---

## 🧪 Example Test (Foundry)

```solidity
function testTransfer() public {
    uint256 amount = 10 * 10**18;
    vm.prank(bob);
    token.transfer(alice, amount);
    assertEq(token.balanceOf(alice), amount);
}
```

---

## 📚 Documentation

- [Foundry Book](https://book.getfoundry.sh/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

---

## 🤝 Contributing

Pull requests and issues are welcome! Please open an issue to discuss your ideas or report bugs.

---


### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## ⚖️ License

This project is licensed under the MIT License.

