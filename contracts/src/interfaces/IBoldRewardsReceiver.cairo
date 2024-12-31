use starknet::ContractAddress;
//in this interface all functions are external

#[starknet::interface]
trait IBoldRewardsReceiver<TContractState> {
    fn triggerBoldRewards(ref self: TContractState, _boldYield: u256);
}
// /*
// # IActivepool uses this inteface - in this function
// function stabilityPool() external view returns (IBoldRewardsReceiver);
// this function returns a variable that is IBoldRewardsReceiver

// # Active pool -
// in this contract there is a variable called
// IBoldRewardsReceiver public immutable stabilityPool;
// so what does this variable do?
// stabilityPool = IBoldRewardsReceiver(_addressesRegistry.stabilityPool());

// in the function _mintAggInterest:
//   if (spYield > 0) {
//     boldToken.mint(address(stabilityPool), spYield);
//    stabilityPool.triggerBoldRewards(spYield);
//      }

// it also appers in 2 require functions
// so what i see is that this stabilitypool is an address of the one that
// is recieving the reward from the pool

// # IStabilitypool inherits it */


