## Token Quickstart / Forte Rules Engine

This is a quickstart repo to easily deploy sample ERC-20 and/or ERC-721 token(s) that includes the hooks for using the Forte Rules Engine.

## Documentation

Check the docs at https://docs.forterulesengine.io/guides/ for more info.

- [Deploy ERC-20 Token](https://docs.forterulesengine.io/guides/tokens/deploy-erc-20-token)
- [Deploy ERC-721 Token](https://docs.forterulesengine.io/guides/tokens/deploy-erc-721-token)

## Usage

This is a template repository that you can easily copy to your own github account with the "Use this template" button on home page of the repo. Then simply clone to your local machine to begin.

```bash
git clone git@github.com:<YOUR_GITHUB_USERNAME>/fre-tokens-quickstart.git
```

### Setting up the `.env` File

The project includes a `sample.env` to get you started. Copy that to a new file named `.env` and fill in the values.

```bash
cp sample.env .env
```

```bash .env
ETH_RPC_URL=
PRIV_KEY=
TOKEN_ADMIN=
ETHERSCAN_API_KEY=
```

Next, make your environment variables available to the command line for running the scripts to deploy your token contract.

```bash
source .env
```

---

### Deploy the Quickstart ERC-20 Token

```bash
forge script script/QuickstartERC20.s.sol:DeployQuickstartERC20 --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```

> [!NOTE]  
> For the contract verification to work, you'll need to set the `ETHERSCAN_API_KEY` value in the `.env` file. You can obtain this for free from basescan.org. You can optionally remove the `--verify` switch from the above command.

### Mint Some Tokens

```bash
cast send 0xYourTokenAddress "mint(address,uint256)" 0xRecipientAddress 1000000000000000000000 --private-key $PRIV_KEY --rpc-url $ETH_RPC_URL
```

---

### Deploy the Quickstart ERC-721 Token

```bash
forge script script/QuickstartERC721.s.sol:DeployQuickstartERC721 --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```

> [!NOTE]  
> For the contract verification to work, you'll need to set the `ETHERSCAN_API_KEY` value in the `.env` file. You can obtain this for free from basescan.org. You can optionally remove the `--verify` switch from the above command.

### Mint Some Tokens

```bash
cast send 0xYourTokenAddress "mint(address,uint256)" 0xRecipientAddress 1000000000000000000000 --private-key $PRIV_KEY --rpc-url $ETH_RPC_URL
```

---

## Approve/Deny Oracle Contracts

These are some sample contracts that can be used as starting points for [oracle based rules](https://docs.forterulesengine.io/v2.2.0/rules/account-approve-deny-oracle).

### Denial Oracle

```bash
forge script script/OracleDenied.s.sol:DeployOracleDenied --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```

### Approval Oracle

```bash
forge script script/OracleApproved.s.sol:DeployOracleApproved --rpc-url $ETH_RPC_URL --private-key $PRIV_KEY --broadcast --verify
```
