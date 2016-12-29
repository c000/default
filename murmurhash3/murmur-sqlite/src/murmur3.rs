
pub fn murmur3_32(key: &[u32], seed: u32) -> u32 {
    const C1 : u32 = 0xcc9e2d51;
    const C2 : u32 = 0x1b873593;
    const R1 : u32 = 15;
    const R2 : u32 = 13;
    const M  : u32 = 5;
    const N  : u32 = 0xe6546b64;

    let mut hash = seed;

    for ki in key {
        let mut k : u32 = *ki;
        k = k.wrapping_mul(C1);
        k = k.rotate_left(R1);
        k = k.wrapping_mul(C2);

        hash ^= k;
        hash = hash.rotate_left(R2);
        hash = hash.wrapping_mul(M);
        hash = hash.wrapping_add(N);
    }

    hash ^= key.len() as u32 * 4;

    hash ^= hash >> 16;
    hash = hash.wrapping_mul(0x85ebca6b);
    hash ^= hash >> 13;
    hash = hash.wrapping_mul(0xc2b2ae35);
    hash ^= hash >> 16;

    hash
}
