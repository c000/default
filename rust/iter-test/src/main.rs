
use std::boxed::Box;
use std::ops::Range;

fn chunked<'a, T, U>(range: T, span: U)
    -> Box<Iterator<Item=Range<U>> + 'a>
  where
    T: std::iter::Iterator<Item=U> + 'a,
    U: std::ops::Add<Output=U>
     + std::ops::Rem<Output=U>
     + std::cmp::PartialEq
     + std::default::Default
     + Copy
     + 'a
{
    use std::default::Default;
    Box::new(
        range.filter_map(move |x| {
            if x % span == Default::default() {
                Some(x..x+span)
            } else {
                None
            }
        })
    )
}

fn main() {
    let range = 0..64;
    for i in chunked(range, 16) {
        println!("{:?}", i);
    }
}
