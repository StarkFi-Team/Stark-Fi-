#[derive(Drop, Copy, Serde)]
pub struct TroveChange {
    applied_redist_bold_debt_gain: u256,
    applied_redist_coll_gain: u256,
    coll_increase: u256,
    coll_ecrease: u256,
    debt_increase: u256,
    debt_decrease: u256,
    new_weighted_recorded_debt: u256,
    old_weighted_recorded_debt: u256,
    upfront_fee: u256,
    batch_accrued_management_fee: u256,
    new_weighted_recorded_batch_management_fee: u256,
    old_weighted_recorded_batch_management_fee: u256,
}
