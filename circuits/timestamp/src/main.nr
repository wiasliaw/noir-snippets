mod timestamp;

fn main(data: pub [u8; 14], result: pub u64) {
    assert(timestamp::timestamp(data, true, true, true) == result);
}

#[test]
fn test_main() {
    // YYYY MM DD HH MM SS
    // 2024 03 14 20 57 48
    let data: [u8; 14] = [
        50, 48, 50, 52, 48, 51,
        49, 52, 50, 48, 53, 55,
        52, 56
    ];
    main(data, 1710449868);
}
