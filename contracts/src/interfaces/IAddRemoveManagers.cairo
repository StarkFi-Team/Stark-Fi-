use starknet::ContractAddress;
//in this interface all functions are external

#[starknet::interface]
trait IAddRemoveManagers<TContractState> {
    fn setAddManager(ref self: TContractState ,_troveId: u256,  _manager: ContractAddress);
    fn setRemoveManager(ref self: TContractState ,_troveId: u256,  _manager: ContractAddress);
    fn setRemoveManagerWithReceiver(ref self: TContractState ,_troveId: u256, _manager: ContractAddress, _receiver: ContractAddress);
    fn addManagerOf(self: @TContractState ,_troveId: u256) -> ContractAddress;
    fn removeManagerReceiverOf(self: @TContractState ,_troveId: u256) -> (ContractAddress, ContractAddress);
}
// /*the Iborrowoperations interface inheretins this interface
// this is the only time that it is used!!!*/