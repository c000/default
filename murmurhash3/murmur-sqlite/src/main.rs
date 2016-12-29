mod murmur3;

extern crate rusqlite;
use rusqlite::Connection;

fn push_to_db(conn: &Connection, end_count: u32) -> rusqlite::Result<()> {
    let mut stmt = try!(conn.prepare("insert or ignore into answer values (?, ?)"));
    for i in 0..end_count {
        let answer = murmur3::murmur3_32(&[i], 0) as i64;
        try!(stmt.execute(&[&(i as i64), &answer]));
        if i & 0xFFFF == 0 {
            use std::io::Write;
            let mut buf = std::io::stdout();
            write!(buf, "{} / {}\r", i >> 16, end_count >> 16).unwrap();
            buf.flush().unwrap();
        }
    }
    Ok(())
}

fn write_sqlite<P>(path: P, iter_num: u32) -> rusqlite::Result<()>
  where P : AsRef<std::path::Path>
{
    let mut conn = try!(Connection::open(path));
    try!(conn.execute("create table if not exists answer (input integer primery key unique, output)", &[]));
    conn.execute("pragma synchronous = off", &[]).unwrap();
    let journal : String = conn.query_row("pragma journal_mode = wal", &[], |row| row.get(0)).unwrap();
    println!("Journal mode {}", journal);
    {
        let tx = try!(conn.transaction());
        push_to_db(&tx, iter_num).unwrap();
        try!(tx.commit());
    }
    Ok(())
}

fn main() {
    use std::env::args;
    let file_name = args()
        .nth(1)
        .unwrap_or_else(usage);
    let iter_num = args()
        .nth(2)
        .map(|x| x.parse().unwrap())
        .unwrap_or(0x1000000);
    match write_sqlite(file_name, iter_num) {
        Err(x) => println!("{:?}", x),
        _      => ()
    }
}

fn usage<T>() -> T {
    use std::io::{stderr,Write};

    let prog_name = std::env::args().nth(0).unwrap();
    let mut stderr = stderr();
    writeln!(stderr, "Usage: {} FILE_NAME", prog_name).unwrap();

    std::process::exit(1)
}
