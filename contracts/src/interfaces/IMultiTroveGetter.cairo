#[starknet::interface]
pub trait IMultiTroveGetter <TContractState> {
    // struct CombinedTroveData {
    //     uint256 id;
    //     uint256 debt;
    //     uint256 coll;
    //     uint256 stake;
    //     uint256 annualInterestRate;
    //     uint256 lastDebtUpdateTime;
    //     uint256 lastInterestRateAdjTime;
    //     address interestBatchManager;
    //     uint256 batchDebtShares;
    //     uint256 batchCollShares;
    //     uint256 snapshotETH;
    //     uint256 snapshotBoldDebt;
    // }

    // struct DebtPerInterestRate {
    //     address interestBatchManager;
    //     uint256 interestRate;
    //     uint256 debt;
    // }

    // fn getMultipleSortedTroves(self: @TContractState, _collIndex: u256, int256 _startIdx, _count: u256) -> (CombinedTroveData[] memory _troves);

    // fn getDebtPerInterestRateAscending(self: @TContractState, _collIndex: u256, _startId: u256, _maxIterations: u256) -> (DebtPerInterestRate[] memory, currId: u256);
}

