use starknet::ContractAddress;
// the borrowoperations interface inheretins this interface
// this is the only time that it is used!!!
#[starknet::interface]
trait IAddRemoveManagers<TContractState> {
    fn setAddManager(_troveId: u256,  _manager: ContractAddress) external;
    fn setRemoveManager(_troveId: u256,  _manager: ContractAddress) external;
    fn setRemoveManagerWithReceiver(_troveId: u256, _manager: ContractAddress, _receiver: ContractAddress) external;
    fn addManagerOf(_troveId: u256) external view returns (ContractAddress);
    fn removeManagerReceiverOf(_troveId: u256) external view returns (ContractAddress, ContractAddress);
}
