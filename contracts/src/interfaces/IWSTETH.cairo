use starknet::ContractAddress;

#[starknet::interface]
trait IWSTETH<TContractState> {
    //in this interface all functions are external

    fn wrap(ref self: TContractState, _stETHAmount: u256) -> u256;
    fn unwrap(ref self: TContractState, _wstETHAmount: u256) -> u256;
    fn getWstETHByStETH(self: @TContractState, _stETHAmount: u256) -> u256;
    fn getStETHByWstETH(self: @TContractState, _wstETHAmount: u256) -> u256;
    fn stEthPerToken(self: @TContractState) -> u256;
    fn tokensPerStEth(self: @TContractState) -> u256;
}
//# in the pricefeeds folder :
//  * WSTETHPriceFeed -
//   in the function - _getCanonicalRate :
//    try IWSTETH(rateProviderAddress).stEthPerToken() returns (uint256 stEthPerWstEth) {
//             // If rate is 0, return true
//             if (stEthPerWstEth == 0) return (0, true);

//             return (stEthPerWstEth, false);
//         } catch {
//             // Require that enough gas was provided to prevent an OOG revert in the external call
//             // causing a shutdown. Instead, just revert. Slightly conservative, as it includes
//             gas used // in the check itself.
//             if (gasleft() <= gasBefore / 64) revert InsufficientGasForExternalCall();

//             // If call to exchange rate reverted for another reason, return true
//             return (0, true);
//         }

//# OracleMainnet , WSTETHTokenMock - these are test files


