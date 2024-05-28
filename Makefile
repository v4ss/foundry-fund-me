-include .env

build:; forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --account 0x14 --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv