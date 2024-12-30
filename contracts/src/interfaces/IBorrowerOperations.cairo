use starknet::ContractAddress;


use ILiquityBase;
use IAddRemoveManagers;
use IBoldToken;
use IPriceFeed;
use ISortedTroves;
use ITroveManager;
use IWETH;

#[derive(Copy, Drop)]
pub struct OpenTroveAndJoinInterestBatchManagerParams {
    owner: ContractAddress,
    owner_index: u256,
    coll_amount: u256,
    bold_amount: u256,
    upper_hint: u256,
    lower_hint: u256,
    interest_batch_manager: ContractAddress,
    max_upfront_fee: u256,
    add_manager: ContractAddress,
    remove_manager: ContractAddress,
    receiver: ContractAddress
}

#[derive(Copy, Drop)]
// -- individual delegation --
pub struct InterestIndividualDelegate {
    account: ContractAddress,
    min_interest_rate: u128,
    max_interest_rate: u128,
    min_interest_rate_change_period: u256,
}
#[derive(Copy, Drop)]
// -- batches --
pub struct InterestBatchManager {
    min_interest_rate: u128,
    max_interest_rate: u128,
    min_interest_rate_change_period: u256
}


// Common interface for the Borrower Operations.
#[starknet::interface]
trait IBorrowerOperations<TContractState> {
    fn CCR(self: @TContractState) -> u256;
    fn MCR(self: @TContractState) -> u256;
    fn SCR(self: @TContractState) -> u256;

    fn open_trove(
        ref self: TContractState,
        owner: ContractAddress,
        owner_index: u256,
        ETH_amount: u256,
        bold_amount: u256,
        upper_hint: u256,
        lower_hint: u256,
        annual_interest_rate: u256,
        max_upfront_fee: u256,
        add_manager: ContractAddress,
        remove_manager: ContractAddress,
        receiver: ContractAddress
    ) -> u256;


    fn open_trove_and_join_interest_batch_manager(
        ref self: TContractState, params: OpenTroveAndJoinInterestBatchManagerParams
    ) -> u256; //params is calldata

    fn add_coll(ref self: TContractState, trove_id: u256, ETH_amount: u256);

    fn withdraw_coll(ref self: TContractState, trove_id: u256, amount: u256);

    fn withdraw_bold(ref self: TContractState, trove_id: u256, amount: u256, max_upfront_fee: u256);

    fn repay_bold(ref self: TContractState, trove_id: u256, amount: u256);

    fn close_trove(ref self: TContractState, trove_id: u256);

    fn adjust_trove(
        ref self: TContractState,
        trove_id: u256,
        coll_change: u256,
        is_coll_increase: u256,
        debt_change: u256,
        is_debt_increase: bool,
        max_upfront_fee: u256
    );

    fn adjustZombieTrove(
        ref self: TContractState,
        trove_id: u256,
        coll_change: u256,
        is_coll_increase: bool,
        bold_change: u256,
        is_debt_increase: bool,
        upper_int: u256,
        lower_hint: u256,
        max_upfront_fee: u256
    );

    fn adjust_trove_interest_rate(
        ref self: TContractState,
        trove_id: u256,
        new_annual_interest_rate: u256,
        upper_hint: u256,
        lower_hint: u256,
        max_upfront_fee: u256
    );

    fn apply_pending_debt(
        ref self: TContractState, trove_id: u256, lower_hint: u256, upper_hint: u256
    );

    fn on_liquidate_trove(ref self: TContractState, trove_id: u256);

    fn claim_collateral(ref self: TContractState);

    fn has_been_shut_down(self: @TContractState) -> bool;
    fn shutdown(ref self: TContractState);
    fn shutdown_from_oracle_failure(ref self: TContractState);

    fn check_batch_manager_exists(self: @TContractState, batch_mananger: ContractAddress) -> bool;


    fn get_interest_individual_delegate_of(
        self: @TContractState, trove_id: u256
    ) //memory varibale
    -> InterestIndividualDelegate;
    fn set_interest_individual_delegate(
        ref self: TContractState,
        trove_id: u256,
        delegate: ContracrAddress,
        min_interest_rate: u128,
        max_interest_rate: u128,
        // only needed if trove was previously in a batch:
        new_annual_interest_rate: u256,
        upper_hint: u256,
        lower_hint: u256,
        max_upfront_fee: u256,
        min_interest_rate_change_period: u256
    );
    fn remove_interest_individual_delegate(ref self: TContractState, trove_id: u256);


    fn register_batch_manager(
        ref self: TContractState,
        min_interest_rate: u128,
        max_interest_rate: u128,
        current_interest_rate: u128,
        fee: u128,
        min_interest_rate_change_period: u128
    );
    fn lower_batch_management_fee(ref self: TContractState, new_annual_fee: u256);
    fn setBatchManagerAnnualInterestRate(
        ref self: TContractState,
        _newAnnualInterestRate: u128,
        _upperHint: u256,
        _lowerHint: u256,
        _maxUpfrontFee: u256
    );
    fn interest_batch_manager_of(self: @TContractState, trove_id: u256) -> ContracrAddress;
    //return memory varibale
    fn get_interest_batch_manager(
        self: @TContractState, account: ContracrAddress
    ) -> InterestBatchManager;
    fn set_interest_batch_manager(
        ref self: TContractState,
        trove_id: u256,
        new_batch_manager: ContractAddress,
        upper_hint: u256,
        lower_hint: u256,
        max_upfront_fee: u256
    );
    fn remove_from_batch(
        ref self: TContractState,
        trove_id: u256,
        new_annual_interest_rate: u256,
        upper_hint: u256,
        lower_hint: u256,
        max_upfront_fee: u256
    );
    fn switchBatchManager(
        ref self: TContractState,
        trove_id: u256,
        remove_upper_hint: u256,
        remove_lower_hint: u256,
        new_batch_manager: ContractAddress,
        add_upper_hint: u256,
        add_lower_hint: u256,
        max_upfront_fee: u256
    );
}
// DeployLiquity2Script is import it, declare varibale of this type and also in AddressVars and
// calling function openTrove

// OpenTroves is import it, declare varibale of this type

// AddressesRegistry is declare varibale of this type

// IBorrowerOperations is import ,inherits and impliments

// GasPool is import and declare varibale of this  =_addressesRegistry.borrowerOperations();

// SortedTroves IBorrowerOperations is only import it but dont use

// TroveManager is declare varibale of this  =_addressesRegistry.borrowerOperations() and calling
// functions by it

//ITroveManager is import and returns in function
// function borrowerOperations() external view returns (IBorrowerOperations);

//MainnetPriceFeedBase is import and declare and borrowerOperations =
//IBorrowerOperations(_borrowOperationsAddress);

//BaseZapper is import and declare borrowerOperations = _addressesRegistry.borrowerOperations();

// GasCompZapper is declare varibale and calling function by it

// LeverageLSTZapper is inheints GasCompZapper and use borrowOperation varible from it  calling
// functions by itthis varibale

// WETHZapper  is inheints GasCompZapper and use borrowOperation varible from it  calling functions
// by itthis varibale

// InterestBatchManagementTest and InterestIndividualDelegationTest  BaseTest TestDeployer
// InvariantsTestHandler SPinvariantsTestHandler TroveManagerTester IBorrowerOperationsTester
// ITroveManagerTester is test

//RebasingBatchShares is

//SortedTroves is initialize addressVars.borrowerOperations

//BorrowerOperations is import inherits and test

// borrowOperation is address for borrow  on which many functions are invoked.

// in BorrowOpration we have to inhenits  ILiquityBase, IAddRemoveManagers because interface doesnt
// inheints othet interface


