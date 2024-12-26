use snforge_std::{BlockId, declare, ContractClassTrait, DeclareResultTrait,  start_cheat_caller_address, stop_cheat_caller_address, store, map_entry_address};
use starknet::ContractAddress;
use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
use contracts::Borrow::{
    IBorrowerDispatcher, IBorrowerDispatcherTrait
};

fn deploy_borrower(
    zklend_market_address: ContractAddress, usdc_address: Array<ContractAddress>, usdt_address: Array<ContractAddress>
) -> (ContractAddress, IBorrowerDispatcher) {
    // Declaring the contract class
    let contract_class = declare("Borrower").unwrap().contract_class();
    // Creating the data to send to the constructor, first specifying as a default value
    let mut data_to_constructor = Default::default();
    // Pack the data into the constructor
    Serde::serialize(@zklend_market_address, ref data_to_constructor);
    Serde::serialize(@usdc_address, ref data_to_constructor);
    Serde::serialize(@usdt_address, ref data_to_constructor);
    // Deploying the contract, and getting the address
    let (address, _) = contract_class.deploy(@data_to_constructor).unwrap();
    return (address, IBorrowerDispatcher { contract_address: address });
}

// TODO: Complete the test according to the TODOS and Instructions
#[test]
// #[fork("MAINNET_FORK_609051")]
fn test_starknet_protocols_2() {
    // Initial Values
    let alice: ContractAddress = 1.try_into().unwrap();
    let alice_felt: felt252 = 1;
    let hundred_usdc: u256 = 100 * 1000000; // 6 Decimals
    let hundred_usdc_felt: felt252 = hundred_usdc.try_into().unwrap();
    let fifty_usdt: u256 = 50 * 1000000; // 6 Decimals
    let fifty_usdt_felt: felt252 = fifty_usdt.try_into().unwrap();

    // Tokens
    let usdc_address: ContractAddress = 0x053c91253bc9682c04929ca02ed00b3e423f6710d2ee7e0d5ebb06f3ecf368a8.try_into().unwrap();
    let usdt_address: ContractAddress = 0x068f5c6a61780768455de69077e07e89787839bf8166decfbf92b645209c0fb8.try_into().unwrap();
    let usdc_dispatcher = IERC20Dispatcher { contract_address: usdc_address };
    let usdt_dispatcher = IERC20Dispatcher { contract_address: usdt_address };

    // Let's give Alice some USDC
    store(usdc_address, map_entry_address(selector!("ERC20_balances"), array![alice_felt].span()), array![hundred_usdc_felt].span());
    assert(usdc_dispatcher.balance_of(alice) == hundred_usdc, 'Wrong usdc balance');

    // TODO: define the Market contract Address
    let zklend_market_address: ContractAddress = 0x04c0a5193d58f74fbace4b74dcf65481e734ed1714121bdc571da345540efa05.try_into().unwrap();

    // TODO: Deploy our Borrower contract
    let (borrower_address, borrower_dispatcher) = deploy_borrower(zklend_market_address, array![usdc_address], array![usdt_address]);

    // TODO: Approve Borrower to spend Alice's USDC
    start_cheat_caller_address(usdc_address, alice);
    usdc_dispatcher.approve(borrower_address, hundred_usdc);
    stop_cheat_caller_address(usdc_address);

    // TODO: Deposit 100 USDC into the borrower contract
    let balance_before = usdc_dispatcher.balance_of(zklend_market_address);
    start_cheat_caller_address(borrower_address, alice);
    borrower_dispatcher.deposit(usdc_address, hundred_usdc_felt);
    stop_cheat_caller_address(borrower_address);
    let balance_after = usdc_dispatcher.balance_of(zklend_market_address);

    // TODO: Check that the market contract obtained the USDC (store the balance before and after the deposit and check the difference)
    assert(balance_after - balance_before == hundred_usdc, 'Wrong USDC balance in Market');

    // TODO: Enable USDC token as collateral
    start_cheat_caller_address(borrower_address, alice);
    borrower_dispatcher.enable_token_as_collateral(usdc_address);
    stop_cheat_caller_address(borrower_address);

    // TODO: Borrow 50 USDT
    start_cheat_caller_address(borrower_address, alice);
    borrower_dispatcher.borrow(usdt_address, fifty_usdt_felt);
    stop_cheat_caller_address(borrower_address);

    // TODO: Check that the alice has 50 USDT
    assert(usdt_dispatcher.balance_of(alice) == fifty_usdt, 'Wrong USDT balance');

    // TODO: Approve the Borrower to spend 50 USDT
    start_cheat_caller_address(usdt_address, alice);
    usdt_dispatcher.approve(borrower_address, fifty_usdt);
    stop_cheat_caller_address(usdt_address);

    // TODO: Repay the 50 USDT using the Borrower
    let balance_before_repay = usdt_dispatcher.balance_of(zklend_market_address);
    start_cheat_caller_address(borrower_address, alice);
    borrower_dispatcher.repay(usdt_address, fifty_usdt_felt);
    stop_cheat_caller_address(borrower_address);
    let balance_after_repay = usdt_dispatcher.balance_of(zklend_market_address);

    // TODO: Check that the market received the USDT (store the balance before and after the repayment and check the difference)
    assert(balance_after_repay - balance_before_repay == fifty_usdt, 'Wrong USDT balance in Market');

    // TODO: Withdraw the 100 USDC
    start_cheat_caller_address(borrower_address, alice);
    borrower_dispatcher.withdraw(usdc_address, hundred_usdc_felt);
    stop_cheat_caller_address(borrower_address);

    // TODO: Check that the Alice has 100 USDC and 0 USDT
    assert(usdc_dispatcher.balance_of(alice) == hundred_usdc, 'Wrong USDC balance');
    assert(usdt_dispatcher.balance_of(alice) == 0, 'Wrong USDT balance');
}
