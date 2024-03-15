global DAYS_TILL_PREVIOUS_MONTH: [u64; 12] = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

// Converts a date string of format YYYYMMDDHHMMSS to a unix time
pub fn timestamp(
    data: [u8; 14],
    include_hours: bool,
    include_minutes: bool,
    include_seconds: bool
) -> u64 {
    // mutable variables
    let mut daysPassed: u64 = 0;
    let mut secondsPassed: u64 = 0;

    // parse year, month, day
    let year = convert_4([data[0], data[1], data[2], data[3]]);
    let month = convert_2([data[4], data[5]]);
    let day = convert_2([data[6], data[7]]);

    // leap year: 1972 is first leap year since epoch
    let yearDelta = year - 1972;
    let leap_year = (yearDelta - yearDelta % 4) / 4;

    // calculate `daysPassed`
    daysPassed += (year - 1970) * 365;
    daysPassed += leap_year;
    daysPassed += DAYS_TILL_PREVIOUS_MONTH[month - 1];
    daysPassed += day - 1;

    // current year is a leap year
    // today had passed the leap day
    if (yearDelta % 4 == 0) & (month > 2) {
        daysPassed += 1;
    }

    // calculate `secondsPassed`
    let mut secondsPassed: u64 = (daysPassed as u64) * 86400;

    // if include hours
    if include_hours {
        secondsPassed += (convert_2([data[8], data[9]]) as u64) * 3600;
    }
    if include_minutes {
        secondsPassed += (convert_2([data[10], data[11]]) as u64) * 60;
    }
    if include_seconds {
        secondsPassed += convert_2([data[12], data[13]]) as u64;
    }

    // return
    secondsPassed
}

unconstrained fn convert_4(d: [u8; 4]) -> u64 {
    let mut ret: u64 = 0;
    for i in 0..4 {
        ret = ret * 10 + (d[i] - 48) as u64;
    }
    ret
}

unconstrained fn convert_2(d: [u8; 2]) -> u64 {
    let mut ret: u64 = 0;
    for i in 0..2 {
        ret = ret * 10 + (d[i] - 48) as u64;
    }
    ret
}
