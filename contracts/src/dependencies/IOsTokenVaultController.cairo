use starknet::ContractAddress;

#[starknet::interface]
trait IOsTokenVaultController<TContractState>{
    fn convert_to_assets(self: @TContractState, shares: u256 ) -> u256;
}
// I think we don't need this interface because in the whole project this interface is not used