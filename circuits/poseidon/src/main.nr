use dep::std::hash::poseidon;

fn main(data: [Field; 1], result: pub Field) {
    let v = poseidon::bn254::hash_1(data);
    assert(v == result);
}
