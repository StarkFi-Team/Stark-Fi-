use contracts::interfaces::IAddRemoveManagers::{IAddRemoveManagersDispatcher};
use contracts::interfaces::IBoldToken::{IBoldTokenDispatcherTrait, IBoldTokenDispatcher};
use contracts::interfaces::IPriceFeed::{IPriceFeedDispatcherTrait, IPriceFeedDispatcher};
use contracts::interfaces::ISortedTroves::{ISortedTrovesDispatcherTrait, ISortedTrovesDispatcher};
use contracts::interfaces::IWETH::{IWETHDispatcherTrait, IWETHDispatcher};
use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
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

#[derive(Copy, Drop, Serde)]
// -- individual delegation --
pub struct InterestIndividualDelegate {
    account: ContractAddress,
    min_interest_rate: u128,
    max_interest_rate: u128,
    min_interest_rate_change_period: u256,
}
#[derive(Copy, Drop, Serde)]
// -- batches --
pub struct InterestBatchManager {
    min_interest_rate: u128,
    max_interest_rate: u128,
    min_interest_rate_change_period: u256
}


// Common interface for the Borrower Operations.
#[starknet::interface]
pub trait IBorrowerOperations<TContractState> {
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

    fn adjust_zombie_trove(
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
        delegate: ContractAddress,
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
    fn set_batch_manager_annual_interest_rate(
        ref self: TContractState,
        new_annual_interest_rate: u128,
        upper_hint: u256,
        lower_hint: u256,
        max_upfront_fee: u256
    );
    fn interest_batch_manager_of(self: @TContractState, trove_id: u256) -> ContractAddress;
    //return memory varibale
    fn get_interest_batch_manager(
        self: @TContractState, account: ContractAddress
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

    fn switch_batch_manager(
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
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
//* fn open_trove_and_join_interest_batch_manager(ref self:TContractState,  params:
//OpenTroveAndJoinInterestBatchManagerParams) -> u256
//  Function Purpose:
//  To open a new Trove with the provided parameters.
//  To associate the Trove with an existing interest batch for managing debt, interest rates, and
//  fees.
//  To update the Trove manager and the data structure that organizes the Troves.
//* fn add_coll(ref self:TContractState,  trove_id: u256, ETH_amount: u256);
//  The function adds a specified amount of collateral to an existing Trove.
//* fn withdraw_coll(ref self:TContractState, trove_id: u256,  amount: u256);
//  The function withdraws a specified amount of collateral from an existing Trove.
//* fn withdraw_bold(ref self:TContractState, trove_id: u256, amount: u256, max_upfront_fee: u256);
//  The function increases the debt (Bold) of an existing Trove to receive the requested amount.
//* fn repay_bold(ref self:TContractState, trove_id: u256,  amount: u256);
//  The function reduces the debt (Bold) of an existing Trove by repaying it.
//* fn close_trove(ref self:TContractState, trove_id: u256);
//  The closeTrove function closes an active Trove by:
//  Repaying the full debt.
//  Returning the collateral to the owner.
//  Updating the system and deleting the Trove's data.
//  The burn operation is performed by the BoldToken contract.
//  The token is burned directly from the user's address that calls the closeTrove function (i.e.,
//  msg.sender).
//* fn adjust_trove(ref self:TContractState,trove_id: u256,coll_change: u256,is_coll_increase:
//  u256,debt_change: u256,is_debt_increase: bool,max_upfront_fee: u256 );
//  The function modifies the properties of an existing Trove, including increasing or decreasing
//  the collateral and debt (Bold), while ensuring system conditions are met and necessary fees are
//  paid.
//* fn adjustZombieTrove(ref self:TContractState,trove_id: u256,coll_change:
//  u256,is_coll_increase:bool,bold_change: u256, is_debt_increase: bool, upper_int:
//  u256,lower_hint:
//  u256,max_upfront_fee: u256);
//  The adjustZombieTrove function is designed to modify the attributes of a Zombie Trove (a Trove
//  that does not meet the minimum requirements), including increasing or decreasing the collateral
//  and debt (Bold), and returning it to an active state while updating the system accordingly.
//* fn adjust_trove_interest_rate(ref self:TContractState,trove_id: u256,new_annual_interest_rate:
//  u256,upper_hint: u256,lower_hint: u256,max_upfront_fee: u256) ;
//  The adjustTroveInterestRate function allows changing the annual interest rate of an existing
//  Trove while updating the debt and collateral data accordingly. It ensures that all required
//  conditions are met, including time restrictions and upfront fee adjustments, and updates the
//  system's data structures.
//* fn apply_pending_debt(ref self:TContractState, trove_id: u256, lower_hint: u256,
//upper_hint:u256);
//  The applyPendingDebt function is designed to apply the pending debt and redistribution gains to
//  a specific Trove, update the calculations related to debt and interest management, and restore a
//  Zombie Trove (if applicable) to an active state.
//* fn on_liquidate_trove(ref self:TContractState, trove_id: u256);
//  The onLiquidateTrove function is part of the liquidation process of a Trove. When a Trove is
//  liquidated, the function deletes all mappings and data related to the Trove from the system's
//  data structures.
//* fn claim_collateral(ref self:TContractState);
//  Claims the remaining collateral surplus stored in the Collateral Surplus Pool after the
//  liquidation the Trove.
//* fn has_been_shut_down(self:@TContractState) -> bool;
//  The function checks if the system has been shut down and returns true if it has, or false if it
//  hasn't.
//* fn shutdown(ref self:TContractState);
//  The shutdown function is used to shut down the system in a state where it can no longer operate
//  properly. The shutdown occurs only when the Total Collateral Ratio (TCR) is below a critical
//  value (SCR), or when a failure in the price oracle is detected.
//* fn shutdown_from_oracle_failure(ref self:TContractState);
//  The function serves as an emergency shutdown triggered by the oracle in cases of failure,
//  ensuring the system transitions to a shutdown state without causing the failure of other
//  functions that rely on oracle data.
//* fn check_batch_manager_exists(self:@TContractState,  batch_mananger: ContractAddress)  -> bool;
//  The function checks if a specific Batch Manager exists in the system. It returns true if the
//  Batch Manager exists, and false if it does not.
//* fn get_interest_individual_delegate_of(self:@TContractState,  trove_id: u256) //memory
//varibale-> InterestIndividualDelegate ;
//  The function returns the information about the Interest Individual Delegate associated with a
//  specific Trove in the system.
//* fn set_interest_individual_delegate(ref self:TContractState,trove_id: u256,delegate
//:ContracrAddress,min_interest_rate: u128,  max_interest_rate: u128,
//  only needed if trove was previously in a batch:new_annual_interest_rate: u256, upper_hint: u256,
//  lower_hint: u256,max_upfront_fee: u256, min_interest_rate_change_period: u256);
//  The setInterestIndividualDelegate function allows a user to set or update the Interest
//  Individual Delegate for a specific Trove. Additionally, if the Trove is part of a Batch Manager
//  the function removes it from the batch.
//* fn remove_interest_individual_delegate(ref self:TContractState,  trove_id: u256);
//  The  function is remove the Interest Individual Delegate associated with a specific Trove.
//* fn register_batch_manager(ref self:TContractState,min_interest_rate: u128,max_interest_rate:
//u128,current_interest_rate: u128,fee: u128,min_interest_rate_change_period: u128);
//  The registerBatchManager function allows a user to register as a Batch Manager in the system,
//  defining parameters for managing the batch (such as interest rates, management fees, and time
//  limits for rate changes).
//* fn lower_batch_management_fee(ref self:TContractState, new_annual_fee: u256);
//  The lowerBatchManagementFee function allows a Batch Manager to reduce the annual management fee
//  for managing the batch (Annual Management Fee).
//  The process includes updating the system's data to reflect the change.
//* fn set_batch_manager_annual_interest_rate(ref self:TContractState,new_annual_interest_rate:
//u128,upper_hint: u256,lower_hint: u256,max_upfront_fee: u256;
//  The setBatchManagerAnnualInterestRate function allows a Batch Manager to change the Annual
//  Interest Rate for the batch they manage.
//  The function ensures that the change complies with system rules, updates the relevant
//  calculations, and handles an Upfront Fee if the change is made before the allowed time.
//* fn interest_batch_manager_of(self:@TContractState,  trove_id: u256)-> ContracrAddress;
//  in other contract
//return memory varibale
//* fn get_interest_batch_manager(self:@TContractState,  account: ContracrAddress) ->
//InterestBatchManager;
//  The function is retrieves information about a Batch Manager for a specific address.
//* fn set_interest_batch_manager(ref self:TContractState,trove_id: u256,new_batch_manager:
//ContractAddress,upper_hint: u256,lower_hint: u256, max_upfront_fee: u256 );
//  The setInterestBatchManager function allows setting a new Batch Manager for a specific Trove. It
//  updates the data related to the new batch, including debt, collateral, management fees, and
//  interest rates, ensuring the change complies with the system's rules.
//* fn remove_from_batch(ref self:TContractState, trove_id: u256,new_annual_interest_rate:
//u256,upper_hint: u256,lower_hint: u256,max_upfront_fee: u256);
//  the function is remove trove from batch
//* fn switch_batch_manager(ref self:TContractState,  trove_id: u256,remove_upper_hint: u256,
//  remove_lower_hint: u256, new_batch_manager: ContractAddress, add_upper_hint:
//  u256,add_lower_hint:
//u256,max_upfront_fee: u256);
//  The  function is used to transfer a Trove from one Batch Manager to another. It removes the
//  Trove from the current batch and assigns it to the new Batch Manager while updating all the
//  required data.
// +++++++++ the propuse of this interface: +++++++++
//  Trove management, including opening, closing and adjusting Troves, as well as interest management and operations related to collateral 
//  and debt.Its purpose is for users to perform loan and repayment operations, and help the manager maintain the stability of the 
//  system and compliance with the requirements
//   --------------------------------------------------------------------------------------------------------------------------------

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


