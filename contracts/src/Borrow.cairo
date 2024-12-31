use starknet::ContractAddress;

#[starknet::interface]
trait IBorrower<TContractState> {
    fn deposit(ref self: TContractState, token: ContractAddress, amount: felt252);
    fn withdraw(ref self: TContractState, token: ContractAddress, amount: felt252);
    fn enable_token_as_collateral(ref self: TContractState, token: ContractAddress);
    fn borrow(ref self: TContractState, token: ContractAddress, amount: felt252);
    fn repay(ref self: TContractState, token: ContractAddress, amount: felt252);
}

#[starknet::contract]
mod Borrower {
    use super::IBorrower;
    use starknet::{ContractAddress, get_caller_address, get_contract_address};
    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    use contracts::interfaces::IMarket::{IMarketDispatcher, IMarketDispatcherTrait};
    use core::debug::PrintTrait;
    use starknet::storage::{Map, StoragePathEntry};
    use starknet::storage::{StorageMapReadAccess, StorageMapWriteAccess};
    #[storage]
    struct Storage {
        // TODO: Implement the storage according to the instructions
        market: IMarketDispatcher,
        deposited_amount: Map<ContractAddress, u256>, // USDC amount
        borrowered_amount: Map<ContractAddress, u256>, // USDC amount
        supported_deposit_tokens: Map<ContractAddress, bool>,
        supported_borrow_tokens: Map<ContractAddress, bool>,
    }

    // TODO: Implement the constructor according to the instructions
    #[constructor]
    fn constructor(
        ref self: ContractState,
        market: ContractAddress,
        supported_deposit_tokens: Array<ContractAddress>,
        supported_borrow_tokens: Array<ContractAddress>
    ) {
        self.market.write(IMarketDispatcher { contract_address: market });

        // Initialize the supported deposit tokens
        let mut i = 0;
        while i < supported_deposit_tokens.len() {
            self.supported_deposit_tokens.write(*supported_deposit_tokens.at(i), true);
            i += 1;
        };

        // Initialize the supported borrow tokens
        i = 0;
        while i < supported_borrow_tokens.len() {
            self.supported_borrow_tokens.write(*supported_borrow_tokens.at(i), true);
            i += 1;
        };
    }

    // TODO: Implement private functions according to the instructions
    #[generate_trait]
    impl PrivateFunctions of PrivateFunctionsTrait {
        fn _is_supported_deposit_token(self: @ContractState, token: ContractAddress) -> bool {
            return self.supported_deposit_tokens.read(token);
        }

        fn _is_supported_borrow_token(self: @ContractState, token: ContractAddress) -> bool {
            return self.supported_borrow_tokens.read(token);
        }
    }

    // TODO: Implement public functions according to the instructions
    #[abi(embed_v0)]
    impl IBorrowerImpl of IBorrower<ContractState> {
        fn deposit(ref self: ContractState, token: ContractAddress, amount: felt252) {
            // Check if the token is supported
            assert(self._is_supported_deposit_token(token), 'Token is not supported');

            // Update the state of the contract
            let depositor = get_caller_address();
            let amount_uint256: u256 = amount.into();
            self
                .deposited_amount
                .write(depositor, self.deposited_amount.read(depositor) + amount_uint256);

            // Transfer the tokens from the user to the contract
            IERC20Dispatcher { contract_address: token }
                .transfer_from(depositor, get_contract_address(), amount_uint256);

            // Approve the zkLend market contract to spend the tokens
            IERC20Dispatcher { contract_address: token }
                .approve(self.market.read().contract_address, amount_uint256);

            // Deposit the tokens in the market contract
            self.market.read().deposit(token, amount);
        }

        fn withdraw(ref self: ContractState, token: ContractAddress, amount: felt252) {
            // Check if the token is supported
            assert(self._is_supported_deposit_token(token), 'Token is not supported');

            // Make sure the user has enough tokens to withdraw
            let depositor = get_caller_address();
            let amount_uint256: u256 = amount.into();
            assert(
                self.deposited_amount.read(depositor) >= amount_uint256,
                'Not enough tokens to withdraw'
            );

            // Update the state of the contract
            self
                .deposited_amount
                .write(depositor, self.deposited_amount.read(depositor) - amount_uint256);

            // Withdraw the tokens from the market contract
            self.market.read().withdraw(token, amount);

            // Transfer the tokens from the contract to the user
            IERC20Dispatcher { contract_address: token }.transfer(depositor, amount_uint256);
        }

        fn enable_token_as_collateral(ref self: ContractState, token: ContractAddress) {
            // Check if the token is supported
            assert(self._is_supported_deposit_token(token), 'Token is not supported');

            // Enable the token as collateral in the market contract
            self.market.read().enable_collateral(token);
        }

        fn borrow(ref self: ContractState, token: ContractAddress, amount: felt252) {
            // Check if the token is supported
            assert(self._is_supported_borrow_token(token), 'Token is not supported');

            // Update the state of the contract
            let borrower = get_caller_address();
            let amount_uint256: u256 = amount.into();
            self
                .borrowered_amount
                .write(borrower, self.borrowered_amount.read(borrower) + amount_uint256);

            // Borrow the tokens from the market contract
            self.market.read().borrow(token, amount);

            // Transfer the tokens from the contract to the user
            IERC20Dispatcher { contract_address: token }.transfer(borrower, amount_uint256);
        }

        fn repay(ref self: ContractState, token: ContractAddress, amount: felt252) {
            // Check if the token is supported
            assert(self._is_supported_borrow_token(token), 'Token is not supported');

            // Make sure the user has enough tokens to repay
            let borrower = get_caller_address();
            let amount_uint256: u256 = amount.into();
            assert(
                self.borrowered_amount.read(borrower) >= amount_uint256,
                'Not enough tokens to repay'
            );

            // Update the state of the contract
            self
                .borrowered_amount
                .write(borrower, self.borrowered_amount.read(borrower) - amount_uint256);

            // Transfer the tokens from the user to the contract
            IERC20Dispatcher { contract_address: token }
                .transfer_from(borrower, get_contract_address(), amount_uint256);

            // Approve the zkLend market contract to spend the tokens
            IERC20Dispatcher { contract_address: token }
                .approve(self.market.read().contract_address, amount_uint256);

            // Repay the tokens to the market contract
            self.market.read().repay(token, amount);
        }
    }
}
