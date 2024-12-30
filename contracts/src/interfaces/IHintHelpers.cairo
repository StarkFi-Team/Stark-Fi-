use starknet::ContractAddress;

#[starknet::interface]
trait IHintHelpers<TContractState> {
    fn getApproxHint(
        self: @TContractState,
        _collIndex: u256,
        _interestRate: u256,
        _numTrials: u256,
        _inputRandomSeed: u256
    ) -> (u256, u256, u256);

    fn predictOpenTroveUpfrontFee(
        self: @TContractState, _collIndex: u256, _borrowedAmount: u256, _interestRate: u256
    ) -> u256;

    fn predictAdjustInterestRateUpfrontFee(
        self: @TContractState, _collIndex: u256, _troveId: u256, _newInterestRate: u256
    ) -> u256;

    fn forcePredictAdjustInterestRateUpfrontFee(
        self: @TContractState, _collIndex: u256, _troveId: u256, _newInterestRate: u256
    ) -> u256;

    fn predictAdjustTroveUpfrontFee(
        self: @TContractState, _collIndex: u256, _troveId: u256, _debtIncrease: u256
    ) -> u256;

    fn predictAdjustBatchInterestRateUpfrontFee(
        self: @TContractState,
        _collIndex: u256,
        _batchAddress: ContractAddress,
        _newInterestRate: u256
    ) -> u256;

    fn predictJoinBatchInterestRateUpfrontFee(
        self: @TContractState, _collIndex: u256, _troveId: u256, _batchAddress: ContractAddress
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


