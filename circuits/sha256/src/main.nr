use dep::std::hash;

fn main(data: [u8; 4], result: [u8; 32]) {
    let v = hash::sha256(data);
    for i in 0..32 {
        assert(v[i] == result[i]);
    }
}
