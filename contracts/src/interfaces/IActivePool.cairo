use contracts::interfaces::IInterestRouter::{IInterestRouterDispatcher};
use contracts::interfaces::IBoldRewardsReceiver::{IBoldRewardsReceiverDispatcher};
use contracts::types::trove_change::TroveChange;
use starknet::ContractAddress;

#[starknet::interface]
trait IActivePool<TContractState> {
    fn defaultPoolAddress(self: @TContractState) -> ContractAddress;
    fn borrowerOperationsAddress(self: @TContractState) -> ContractAddress;
    fn troveManagerAddress(self: @TContractState) -> ContractAddress;
    fn interestRouter(
        self: @TContractState
    ) -> IInterestRouterDispatcher; // this needs to return IInterestRouter
    // We avoid IStabilityPool here in order to prevent creating a dependency cycle that would break
    // flattening
    fn stabilityPool(
        self: @TContractState
    ) -> ContractAddress; // this is sapose to return IBoldRewardsReceiver
    fn getCollBalance(self: @TContractState) -> u256;
    fn getBoldDebt(self: @TContractState) -> u256;
    fn lastAggUpdateTime(self: @TContractState) -> u256;
    fn aggRecordedDebt(self: @TContractState) -> u256;
    fn aggWeightedDebtSum(self: @TContractState) -> u256;
    fn aggBatchManagementFees(self: @TContractState) -> u256;
    fn aggWeightedBatchManagementFeeSum(self: @TContractState) -> u256;
    fn calcPendingAggInterest(self: @TContractState) -> u256;
    fn calcPendingSPYield(self: @TContractState) -> u256;
    fn calcPendingAggBatchManagementFee(self: @TContractState) -> u256;
    fn getNewApproxAvgInterestRateFromTroveChange(
        self: @TContractState, _troveChange: TroveChange
    ) -> u256;
    fn mintAggInterest(ref self: TContractState);
    fn mintAggInterestAndAccountForTroveChange(
        ref self: TContractState, _troveChange: TroveChange, _batchManager: ContractAddress
    );
    fn mintBatchManagementFeeAndAccountForChange(
        ref self: TContractState, _troveChange: TroveChange, _batchAddress: ContractAddress
    );
    fn setShutdownFlag(ref self: TContractState);
    fn hasBeenShutDown(self: @TContractState) -> bool;
    fn shutdownTime(self: @TContractState) -> u256;
    fn sendColl(ref self: TContractState, _account: ContractAddress, _amount: u256);
    fn sendCollToDefaultPool(ref self: TContractState, _amount: u256);
    fn receiveColl(ref self: TContractState, _amount: u256);
    fn accountForReceivedColl(ref self: TContractState, _amount: u256);
}
// /*
// # HintHelpers -
// in this file i don't see any import so that means that it gets it from a different import !!!
//   *in this predictOpenTroveUpfrontFee function-
//    there is a variable IActivePool activePool = troveManager.activePool();
//    and it is used to calculate
//   *in this predictAdjustInterestRateUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    it is returned at the end of the function
//   *in this forcePredictAdjustInterestRateUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    it is returned at the end of the function
//   *in this _predictAdjustInterestRateUpfrontFee function -
//    we receive variable IActivePool _activePool that is used for calculation
//   *in this predictAdjustTroveUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    that is used for calculation
//   *in this predictAdjustBatchInterestRateUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    that is used for calculation
//   *in this predictOpenTroveAndJoinBatchUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    that is used for calculation
//   *in this predictJoinBatchInterestRateUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    that is used for calculation
//   *in this predictRemoveFromBatchUpfrontFee function -
//    there is a variable IActivePool activePool = troveManager.activePool();
//    that is used for calculation

//    it seems like this is coming here in order to help with the calculations

// # ILiquityBase -
// imports this interface and has a function that returns a var of this type

// # IAddressesRegistry -
// imports this interface and then makes a var in the struct that is this type
// and has a function that returns a var of this type

// # ActivePool -
// inherits this interface and implements all of the functions

// # AddressesRegistry -
// this file does not import this interface but gets it by importing a file that imports it
// it has a var IActivePool public activePool - and it is used to set addresses

// # BorrowerOperations -
// first we have this IActivePool activePool in 3 struct:
//              LocalVariables_setInterestBatchManager,LocalVariables_adjustTrove,LocalVariables_openTrove
// then it is used in the approve function in the constructor
// * in the function openTrove it is used a few times and send to another function
// * in the adjustTroveInterestRate function it is used to mint
// * in the _adjustTrove function it is used for calculation minting and then sent to another
// function * in the closeTrove function -
// we have another var : IActivePool activePoolCached = activePool;
// and in this function this var only is used - for minting and sending coll
// * in the applyPendingDebt function - it is used for minting
// * in the lowerBatchManagementFee function - it is used for minting
// * in the getInterestBatchManager function - it is used for minting
// * in the setBatchManagerAnnualInterestRate function -
// we have another var : IActivePool activePoolCached = activePool;
// and in this function this var only is used - for minting and more
// * in the setInterestBatchManager function - it is used for minting
// * in the removeFromBatch function - it is used for minting
// * in the switchBatchManager function - it is used
// * in the _applyShutdown function - it is used for minting
// * in the _moveTokensFromAdjustment function -
// we have another var : IActivePool _activePool that we get in the function
// it is used to move and send collateral
// * in the _pullCollAndSendToActivePool function -
// we have another var : IActivePool _activePool that we get in the function
// it is used to move and send collateral

// in this file we can see that this interface is used for token transfer

// # in the script folder :
//    in DeployLiquity2 - it is used to set different addresses

// # DefaultPool -
// imports this interface and then is used in
// sendCollToActivePool function to send collateral

// # IStabilityPool -
// imports this interface

// # TroveManager -
// does not import this interface
// * in the batchLiquidateTroves function we have IActivePool activePoolCached = activePool;
// this var is used for minting and is being sent to a rew function from this function
// * the function _sendGasCompensation gets a var that is IActivePool
// and uses it to send coll
// * the function _updateBatchInterestPriorToRedemption gets a var that is IActivePool
// and uses it to mint
// * in the redeemCollateral function we have IActivePool activePoolCached = activePool;
// and it is used to mint and sent coll
// * the function activePoolCached gets a var that is IActivePool
// and uses it to get coll balance

// # LiquityBase -
// imports this interface
// then it uses a var IActivePool activepool to get the amount of coll and dept

// # Deployment-
//  it has a var IActivePool public activePool - and it is used to set addresses

// # BaseTest -
// imports this interface
// */


