use starknet::ContractAddress;

#[starknet::interface]
pub trait IHintHelpers<TContractState> {
    fn get_approx_hint(
        self: @TContractState,
        coll_index: u256,
        interest_rate: u256,
        num_trials: u256,
        input_random_seed: u256
    ) -> (u256, u256, u256);

    fn predict_open_trove_pfront_fee(
        self: @TContractState, coll_index: u256, borrowed_amount: u256, interest_rate: u256
    ) -> u256;

    fn predictAdjustInterestRateUpfrontFee(
        self: @TContractState, coll_index: u256, trove_id: u256, new_interest_rate: u256
    ) -> u256;

    fn force_predict_adjust_interest_rate_upfront_fee(
        self: @TContractState, coll_index: u256, trove_id: u256, _new_interest_rate: u256
    ) -> u256;

    fn predict_adjust_trove_upfront_fee(
        self: @TContractState, coll_index: u256, trove_id: u256, debt_increase: u256
    ) -> u256;

    fn predict_adjust_batch_interest_rate_upfront_fee(
        self: @TContractState,
        coll_index: u256,
        batch_address: ContractAddress,
        new_interest_rate: u256
    ) -> u256;

    fn predict_join_batch_interest_rate_upfront_fee(
        self: @TContractState, coll_index: u256, trove_id: u256, batch_address: ContractAddress
    ) -> u256;
}
//DeployLiquity2 defines a variable of this type in the struct addressvars

//OpenTroves import it
//create varibale of this type and it in this function
// use  function _findHints(IHintHelpers hintHelpers, BranchContracts memory c, uint256 branch,
// uint256 interestRate)
// internal
// view
// returns (uint256 upperHint, uint256 lowerHint)
// {
// // Find approx hint (off-chain)
// (uint256 approxHint,,) = hintHelpers.getApproxHint({
//     _collIndex: branch,
//     _interestRate: interestRate,
//     _numTrials: sqrt(100 * c.troveManager.getTroveIdsCount()),
//     _inputRandomSeed: block.timestamp
// });

// // Find concrete insert position (off-chain)
// (upperHint, lowerHint) = c.sortedTroves.findInsertPosition(interestRate, approxHint, approxHint);
// }

// and also in this function
// function run() external {
//  IHintHelpers hintHelpers;
// try vm.envAddress("HINT_HELPERS") returns (address value) {
//     hintHelpers = IHintHelpers(value);
// } catch {
//     hintHelpers = IHintHelpers(vm.parseJsonAddress(manifestJson, ".hintHelpers"));
// }
// vm.label(address(hintHelpers), "HintHelpers");

//AddressesRegistry defines a variable of this type in the struct addressvars and also call for
//event

// HintHelpers is import, inheretins and implement it.

// IAddressesRegistry is import, defines a variable of this type and declare function that return
// this interface function hintHelpers() external view returns (IHintHelpers);

//TestDeployer is use it


