use starknet::ContractAddress;
//in this interface all functions are external

#[starknet::interface]
trait ICollSurplusPool<TContractState> {
    fn getCollBalance(self : @TContractState) -> u256;
    fn getCollateral(self : @TContractState,_account : ContractAddress) -> u256;
    fn accountSurplus(ref self: TContractState,_account: ContractAddress, _amount:u256 );
    fn claimColl(ref self:TContractState,_account: ContractAddress);
}
// /*
// # CollSurplusPool - 
// inherits this interface and implements all the functions

// # IAddressesRegistry -
// imports this interface 
// and defines a variable of this type in the struct addressvars
// and defines a function named collSurplusPool that returns this type

// # AddressesRegistry-
// does not import it or inherit it because 
// it inherits the IAddressesRegistry and there is where it gets it from
// it defines a var called collSurplusPool that is type ICollSurplusPool
// and then has a function were he sets the address called setAddresses

// # in the script folder:
//  *DeployLiquity2 -
//   this has a struct that is called LiquityContracts
//   there they define ICollSurplusPool collSurplusPool
//   this is being used to set addresses atc.

// # BorrowerOperations -
// the contract imports this interface
// and defindes ICollSurplusPool internal collSurplusPool
// this collSurplusPool gets the address by the function:
// collSurplusPool = _addressesRegistry.collSurplusPool();
// and then it is used to send the colletaral to the owner by this function:

//     function claimCollateral() external override {
//         // send coll from CollSurplus Pool to owner
//         collSurplusPool.claimColl(msg.sender);
//     }

// # TroveManager -
// the contract imports this interface
// and defindes ICollSurplusPool internal collSurplusPool
// this collSurplusPool gets the address by the function:
// collSurplusPool = _addressesRegistry.collSurplusPool();
// and then it is used in the liqidate function:

//    // Differencen between liquidation penalty and liquidation threshold
//         if (singleLiquidation.collSurplus > 0) {
//             collSurplusPool.accountSurplus(owner, singleLiquidation.collSurplus);
//         }
// and in this batchLiquidateTroves function :

//         if (totals.collSurplus > 0) {
//             activePoolCached.sendColl(address(collSurplusPool), totals.collSurplus);
//         }
// # BaseTest , SPInvariantsTestHandler , Deployment -
// these are test...
// */
