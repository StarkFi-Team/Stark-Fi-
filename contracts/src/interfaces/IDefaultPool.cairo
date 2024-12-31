use starknet::ContractAddress;
// ILiquityBase import it
// DefaultPool  inheretins this interface
// DeployLiquity2Script,TestDeployer,BaseTest,IAddressesRegistry,IAddressesRegistry,LiquityBase,
// TroveManager, ActivePool ,AddressesRegistry this interface
#[starknet::interface]
pub trait IDefaultPool<TContractState> {
    fn trove_manager_address(self: @TContractState) -> ContractAddress;
    fn active_pool_address(self: @TContractState) -> ContractAddress;
    fn get_coll_balance(self: @TContractState) -> u256;
    fn get_bold_debt(self: @TContractState) -> u256;
    fn send_coll_to_active_pool(ref self: TContractState, amount: u256);
    fn receive_coll(ref self: TContractState, amount: u256);

    fn increase_bold_debt(ref self: TContractState, amount: u256);
    fn decrease_bold_debt(ref self: TContractState, amount: u256);
}
//DeployLiquity2Script is  defines a variable of this type in the struct addressvars

// AddressesRegistry is defines a variable of this interface

//DefaultPool is import, inheretins and implement it.

// TroveMnager is defines a variable of this interface and send it to functions

//LiquityBase is import and  defines a variable of this interface

//  IAddressesRegistry is import, defines a variable in AddressVars struct  and declare function
//  that return this interface
// function defaultPool() external view returns (IDefaultPool);

// ILiquityBase  is import it

//BaseTest is import, defines a variable

//Deployment defines a variable and deploy the contract

//
//ActivePool is import and Calling the function receiveColl on an instance of the interface
// function sendCollToDefaultPool(uint256 _amount) external override {
//     _requireCallerIsTroveManager();

//     _accountForSendColl(_amount);

//     IDefaultPool(defaultPoolAddress).receiveColl(_amount);
// }
// so what i see is that  _amount of tokens of type Coll is sent to the Default Pool, the function
// receiveColl is invoked.

//DefaultPool is import, inheretins and implement it.

// TroveMnager is defines a variable of this interface and send it to functions

//LiquityBase is import and  defines a variable of this interface

//  IAddressesRegistry is import, defines a variable in AddressVars struct  and declare function
//  that return this interface
// function defaultPool() external view returns (IDefaultPool);

// ILiquityBase  is import it

//BaseTest is import, defines a variable

//Deployment defines a variable and deploy the contract


