use starknet::ContractAddress;

// this const is not necessary because the defalt is 0 ?
// const ZERO_ADDRESS : ContractAddress = ContractAddress;
const MAX_UINT256: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

const DECIMAL_PRECISION: u256 = 1000000000000000000_u256;
const _100pct: u256 = DECIMAL_PRECISION;
const _1pct: u256 = DECIMAL_PRECISION / 100;

// Amount of ETH to be locked in gas pool on opening troves
const ETH_GAS_COMPENSATION: u256 = 37500000000000000_u256; // 0.0375 ether

// Liquidation
const MIN_LIQUIDATION_PENALTY_SP: u256 =
    50000000000000000_u256; // 5% (0.05 in fixed-point representation)
const MAX_LIQUIDATION_PENALTY_REDISTRIBUTION: u256 =
    200000000000000000_u256; // 20% (0.2 in fixed-point representation)

// Fraction of collateral awarded to liquidator
const COLL_GAS_COMPENSATION_DIVISOR: u256 = 200; // dividing by 200 yields 0.5%
const COLL_GAS_COMPENSATION_CAP: u256 =
    2000000000000000000_u256; // Max coll gas compensation capped at 2 ETH

// Minimum amount of net Bold debt a trove must have
const MIN_DEBT: u256 = 2000000000000000000000_u256; // 2000 * 10^18

const MIN_ANNUAL_INTEREST_RATE: u256 = _1pct / 2; // 0.5%
const MAX_ANNUAL_INTEREST_RATE: u256 = _100pct;

// Batch management params
// const MAX_ANNUAL_BATCH_MANAGEMENT_FEE: u128 = _100pct / 10; // 10%
const MIN_INTEREST_RATE_CHANGE_PERIOD: u128 =
    120; // represents 120 seconds, prevents more than one adjustment per ~10 blocks

const REDEMPTION_FEE_FLOOR: u256 = _1pct / 2; // 0.5%

// For the debt / shares ratio to increase by a factor 1e9
// at a average annual debt increase (compounded interest + fees) of 10%, it would take more than
// 217 years (log(1e9)/log(1.1))
// at a average annual debt increase (compounded interest + fees) of 50%, it would take more than 51
// years (log(1e9)/log(1.5))
// The increase pace could be forced to be higher through an inflation attack,
// but precisely the fact that we have this max value now prevents the attack
const MAX_BATCH_SHARES_RATIO: u256 = 1000000000_u256; // 1e9

// Half-life of 6h. 6h = 360 min
// (1/2) = d^360 => d = (1/2)^(1/360)
const REDEMPTION_MINUTE_DECAY_FACTOR: u256 = 998076443575628800;

// BETA: 18 digit decimal. Parameter by which to divide the redeemed fraction, in order to calc the
// new base rate from a redemption.
// Corresponds to (1 / ALPHA) in the white paper.
const REDEMPTION_BETA: u256 = 1;

// To prevent redemptions unless Bold depegs below 0.95 and allow the system to take off
const INITIAL_BASE_RATE: u256 = _100pct; // 100% initial redemption rate

// Discount to be used once the shutdown thas been triggered
const URGENT_REDEMPTION_BONUS: u256 =
    20000000000000000_u256; // 2% (0.02 in fixed-point representation)

// const ONE_MINUTE : u256 = 1 minutes;
// const ONE_YEAR : u256 = 365 days;
// const UPFRONT_INTEREST_PERIOD : u256 = 7 days;
// const INTEREST_RATE_ADJ_COOLDOWN : u256 = 7 days;
const ONE_MINUTE: u256 = 60_u256;
const ONE_HOUR: u256 = 3600_u256; // 60 * 60
const ONE_DAY: u256 = 86400_u256; // 24 * 60 * 60
const ONE_WEEK: u256 = 604800_u256; // 7 * 24 * 60 * 60

const SP_YIELD_SPLIT: u256 = 75 * _1pct; // 75%

// Dummy contract that lets legacy Hardhat tests query some of the constants
mod Constants {
    use super::ETH_GAS_COMPENSATION;
    use super::MIN_DEBT;

    const _ETH_GAS_COMPENSATION: u256 = ETH_GAS_COMPENSATION;
    const _MIN_DEBT: u256 = MIN_DEBT;
}
