 use starknet::ContractAddress;

use openzeppelin::token::erc20::{ERC20Component, ERC20HooksEmptyImpl };
use openzeppelin::token::erc20::interface::{IERC20MetadataDispatcher};

use contracts::interfaces::ITroveManager::{ITroveManagerDispatcherTrait, ITroveManagerDispatcher};
use contracts::interfaces::IBoldToken::{IBoldTokenDispatcherTrait, IBoldTokenDispatcher};

#[starknet::interface]
pub trait ICollateralRegistry<TContractState> {
    fn base_rate(self:@TContractState) -> u256;
    fn last_fee_operation_time(self:@TContractState) -> u256;

    fn redeem_collateral(ref self:TContractState, boldamount: u256,  maxIterations: u256,  max_fee_percentage: u256) ;
    // getters
    fn total_collaterals(self:@TContractState) -> u256;
    fn get_token(self:@TContractState,  index: u256)  -> IERC20MetadataDispatcher;
    fn get_trove_manager(self:@TContractState, index: u256) -> ITroveManagerDispatcher;
    fn bold_token(self:@TContractState) -> IBoldTokenDispatcher;

    fn get_redemption_rate(self:@TContractState) -> u256;
    fn get_redemption_rate_with_decay(self:@TContractState) -> u256;
    fn get_redemption_rate_forRedeemed_amount(self:@TContractState,  redeem_amount: u256) -> u256;

    fn get_redemption_fee_with_decay(self:@TContractState, ETHDrawn: u256)-> u256;
    fn get_effective_redemption_fee_in_bold(self:@TContractState,  redeem_amount: u256)  -> u256;
}

// @note
// ################################################################################################################################
// changes from solidity and other notes
// ################################################################################################################################
// example of explaination
// this trait need to inherit IERC20Metadata, IERC20Permit, IERC5267
// because in cairo interface can't inherit another interfaces,
// so we need to inherit in impl this interface.
// and also import - use openzeppelin::token::erc20::IERC20Metadata;
// ################################################################################################################################
//
//
// --------------------------------------------------------------------------------------------------------------------------------
// General explanation
// --------------------------------------------------------------------------------------------------------------------------------
//
// explain all functions in the interface.
//
//
//
// +++++++++ the propuse of this interface: +++++++++
// manage all the types of colleteral, their fees,troves etc.up to 10 differance colleteral
//
//
//
// --------------------------------------------------------------------------------------------------------------------------------
//
//
// ================================================================================================================================
// usage
// ================================================================================================================================
//
// ------contracts-------
// *DeployLiquity2Script
//  ^ function _deployAndConnectCollateralContracts 
//    declare and initialize  variable in AddressVars struct in IAddressesRegistry.
// *LiquidateTrove
//    import the interface
// *OpenTroves
//  ^ import the interface
//  ^ function run()
//     declare and initialize a variable and also calling functin on the varibale.
// *RedeemCollateral
//  ^ import the interface
//  ^ function run()
//     declare and initialize a variable and also calling functin on the varibale.
// *AddressesRegistry
//  ^ declare a varibale 
//  ^ function setAddresses()
//     initialize the variable in AddressVars struct in IAddressesRegistry.
//     emit CollateralRegistryAddressChanged(address(_vars.collateralRegistry));
// *CollateralRegistry
//  ^ import and inherits the interface
// *HintHelpers
//  ^ import the interface and declare a variable
//  ^ fnuction constractor()
//     initialize the variable
//  ^ function getApproxHint, predictOpenTroveUpfrontFee, predictAdjustInterestRateUpfrontFee, forcePredictAdjustInterestRateUpfrontFee,
//     predictAdjustTroveUpfrontFee, predictAdjustBatchInterestRateUpfrontFee, predictOpenTroveAndJoinBatchUpfrontFee,
//     predictJoinBatchInterestRateUpfrontFee, predictRemoveFromBatchUpfrontFee
//     ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
// *MultiTroveGetter
//  ^ import the interface and declare a variable
//  ^ fnuction constractor()
//     initialize the variable
//  ^ function getMultipleSortedTroves
//     ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
// *TroveManager     
//  ^ import the interface and declare a variable
//  ^ fnuction constractor()
//     initialize the variable
//     emit CollateralRegistryAddressChanged(address(collateralRegistry));
//  ^ function _requireCallerIsCollateralRegistry
//     if (msg.sender != address(collateralRegistry))
//     The requirement check to ensure that the function invoking it is called by collateralRegistry. If the call is not made by the expected 
//     contract, the function will trigger a revert with the error message CallerNotCollateralRegistry.
// ------interfaces-------
// *IAddressesRegistry
//  ^ import the interface and declare a variable in the AddressVars struct
//  ^ function collateralRegistry() external view returns (ICollateralRegistry);
// *BaseMultiCollateralTest
//  ^ import the interface and declare a variable in the Contracts struct and extra time declare a variable
//  ^ function setupContracts
//     the function get ontracts memory contracts and  initialize the contract's internal variables with the values from the contracts structure. 
//     It also ensures that all branches  are copied into the branches storage variable.
// *BaseTest , Deployment, TroveManagerTester are test
// 
// ================================================================================================================================