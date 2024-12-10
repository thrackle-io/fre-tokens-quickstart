## Token Quickstart / Forte Rules Engine=

This is a quickstart repo to easily deploy an ERC-20 token that includes the hooks for using the Forte Rules Engine.

Questions - can I pass an address to the deploy scripts via command line?

## Documentation

https://docs.forterulesengine.io

## Usage

### Fork and Clone

Create a fork of this repo and then clone it to your local machine.

```shell
git clone git@github.com:<YOUR_GITHUB_USERNAME>/token-quickstart.git

```

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Deploy the Quickstart Token

```shell
forge script script/QuickstartERC20.s.sol:DeployQuickstartERC20 --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```

### Verify the Contract

```shell
forge verify-contract <CONTRACT_ADDRESS> --rpc-url <rpc>
```

requirements:

- ETHERSCAN_API_KEY from basescan.org

### Mint Some Tokens

```shell
cast send 0xYourTokenAddress "mint(address,uint256)" 0xRecipientAddress 1000000000000000000000 --rpc-url $ETH_RPC_URL --private-key 0xYourPrivateKey
```

# verify contract

```bash
forge verify-contract 0xaF66085424Dc150B56ed6d8C16D9b863EbeeB92A --rpc-url https://base-sepolia.g.alchemy.com/v2/iprqfxvnTrUckGiS9kBmRVS1NYGHVinL --constructor-args ["QuickstartToken" "QTK" 0xE4F53F8aD1EB9B8A556ccF363a2389D59447a6df]
```

#abi encoded args

```
000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000e4f53f8ad1eb9b8a556ccf363a2389d59447a6df0000000000000000000000000000000000000000000000000000000000000010517569636b737461727420546f6b656e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000351544b0000000000000000000000000000000000000000000000000000000000
```

# check status

```bash
curl "https://api.basescan.org/api?module=contract&action=checkverifystatus&guid=RETURNED_GUID&apikey=API_KEY"
```

# mint tokens

```bash
cast send <contract_address> "mint(address,uint256)" <recipient> 1000000000000000000000 --rpc-url https://base-sepolia.g.alchemy.com/v2/API_KEY --private-key <priv_key>
```

# hasRole TOKEN_ADMIN_ROLE

```bash
cast call <contract_address> "hasRole(bytes32,address)" 0x9e262e26e9d5bf97da5c389e15529a31bb2b13d89967a4f6eab01792567d5fd6 <address_to_check_for_role> --rpc-url https://base-sepolia.g.alchemy.com/v2/API_KEY
```

# getHandlerAddress

```bash
cast call <contract_address> "getHandlerAddress()" --rpc-url https://base-sepolia.g.alchemy.com/v2/API_KEY
```

## Oracle Time

### Denial Oracle

```bash
forge script script/OracleDenied.s.sol:DeployOracleDenied --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```

### Approval Oracle

```bash
forge script script/OracleApproved.s.sol:DeployOracleApproved --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```
