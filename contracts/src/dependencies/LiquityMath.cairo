
mod LiquityMath {
    use contracts::dependencies::Constants::{DECIMAL_PRECISION,MAX_UINT256};

    fn _min(a: u256, b: u256) -> u256 {
        if a < b {
            a
        } else {
            b
        }
    }

    fn _max(a: u256, b: u256) -> u256 {
        if a >= b {
            a
        } else {
            b
        }
    }

    fn _sub_min_0(a: u256, b: u256) -> u256 {
        if a > b {
            a - b
        } else {
            0
        }
    }

    // * Multiply two decimal numbers and use normal rounding rules:
    // * -round product up if 19'th mantissa digit >= 5
    // * -round product down if 19'th mantissa digit < 5
    // *
    // * Used only inside the exponentiation, _decPow().

    fn dec_mul(x: u256, y: u256) -> u256 {
        let prod_xy: u256 = x * y;
        (prod_xy + DECIMAL_PRECISION / 2) / DECIMAL_PRECISION
    }

    // * _decPow: Exponentiation function for 18-digit decimal base, and integer exponent n.
    // *
    // * Uses the efficient "exponentiation by squaring" algorithm. O(log(n)) complexity.
    // *
    // * Called by function CollateralRegistry._calcDecayedBaseRate, that represent time in units of
    // minutes *
    // * The exponent is capped to avoid reverting due to overflow. The cap 525600000 equals
    // * "minutes in 1000 years": 60 * 24 * 365 * 1000
    // *
    // * If a period of > 1000 years is ever used as an exponent in either of the above functions,
    // the result will be * negligibly different from just passing the cap, since:
    // *
    // * In function 1), the decayed base rate will be 0 for 1000 years or > 1000 years
    // * In function 2), the difference in tokens issued at 1000 years and any time > 1000 years,
    // will be negligible

    fn _dec_pow(base: u256, mut minutes: u256) -> u256 {
        if minutes > 525600000 {
            minutes = 525600000
        } // cap to avoid overflow
        if minutes == 0 {
            return DECIMAL_PRECISION;
        }

        let mut y: u256 = DECIMAL_PRECISION;
        let mut x: u256 = base;
        let mut n: u256 = minutes;

        // Exponentiation-by-squaring
        while n > 1 {
            if n % 2 == 0 {
                x = dec_mul(x, x);
                n = n / 2;
            } else {
                // if (n % 2 != 0)
                y = dec_mul(x, y);
                x = dec_mul(x, x);
                n = (n - 1) / 2;
            }
        };
        return dec_mul(x, y);
    }

    fn _get_absolute_difference(a: u256, b: u256) -> u256 {
        if a >= b {
            a - b
        } else {
            b - a
        }
    }

    //compute the collateral ratio for trove based on its debt, collateral and current price of the collateral.
    //the CR is computed a lot of times in the project to manage the health of the system and each trove,
    //to purpose or perform actions.
    fn compute_CR(coll: u256, debt: u256, price: u256) -> u256 {
        if debt > 0 {
            let new_coll_ratio: u256 = coll * price / debt;
            new_coll_ratio
        }
        //Return the maximal value for u256 if the debt is 0. Represents "infinite" CR.
        else {
            //if (debt ==0)
            MAX_UINT256
        }
    }
}
//----------------------------------------------
//general explanation
//----------------------------------------------
//this is the math library of the project, containing the math calculation pure functions
//used in a many places in the project for various needs.
//all functions are internal pure
//----------------------------------------------
//dependencies
//----------------------------------------------
//this library using the constants dependency.


