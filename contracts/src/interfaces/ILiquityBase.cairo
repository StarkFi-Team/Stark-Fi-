use contracts::interfaces::IActivePool::{IActivePoolDispatcher};
use contracts::interfaces::IPriceFeed::{IPriceFeedDispatcher};
use contracts::interfaces::IDefaultPool::{IDefaultPoolDispatcher};
use starknet::ContractAddress;

#[starknet::interface]
trait ILiquityBase<TContractState> {
    fn activePool(self: @TContractState) -> IActivePool;
    fn getEntireSystemDebt(self: @TContractState) -> u256;
    fn getEntireSystemColl(self: @TContractState) -> u256;
}
// # LiquityBase -
// imports this interface and inherits it

// # IBorrowerOperations -
// imports this interface and inherits it

// # ITroveManager -
// imports this interface and inherits it

// # IStabilityPool -
// imports this interface and inherits it

