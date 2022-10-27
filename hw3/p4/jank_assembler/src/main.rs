#![allow(dead_code, unused_variables, unused_mut)]

use regex::{Regex, RegexSet};

use std::fs::File;
use std::io::{self, BufWriter};
use std::io::{BufRead, BufReader, Error, Result, Write};

use std::collections::HashMap;

use phf::phf_map;

static REGISTER_MAP: phf::Map<&'static str, Register> = phf_map! {
    "r0" => 0,
    "r1" => 1,
    "r2" => 2,
    "r3" => 3,
    "r4" => 4,
    "r5" => 5,
    "r6" => 6,
    "r7" => 7,
    "r8" => 8,
    "r9" => 9,
    "r10" => 10,
    "r11" => 11,
    "r12" => 12,
    "r13" => 13,
    "r14" => 14,
    "r15" => 15
};

static OPCODE_MAP: phf::Map<&'static str, u8> = phf_map! {
    "nop" => 0,
    "ld" => 1,
    "str" => 2,
    "bra" => 3,
    "xor" => 4,
    "add" => 5,
    "rot" => 6,
    "shf" => 7,
    "hlt" => 8,
    "cmp" => 9
};

static CONDCODE_MAP: phf::Map<&'static str, ConditionalCode> = phf_map! {
    "a" => ConditionalCode::Always,
    "p" => ConditionalCode::Parity,
    "e" => ConditionalCode::Even,
    "c" => ConditionalCode::Carry,
    "n" => ConditionalCode::Negative,
    "z" => ConditionalCode::Zero,
    "nc" => ConditionalCode::NoCarry,
    "po" => ConditionalCode::Positive
};

#[derive(Debug, Copy, Clone)]
enum ConditionalCode {
    Always = 0,
    Parity = 1,
    Even = 2,
    Carry = 3,
    Negative = 4,
    Zero = 5,
    NoCarry = 6,
    Positive = 7,
}

type Register = u32;
type Immediate = i32;

#[derive(Debug)]
enum MemAddr {
    Raw(u32),
    Label(String),
}

#[derive(Debug)]
enum Src {
    Reg(Register),
    Imm(Immediate),
}

#[derive(Debug)]
enum Mem1 {
    Addr(MemAddr),
    Imm(Immediate),
}

#[derive(Debug)]
enum Operation {
    Nop,
    Load(Register, Mem1),
    Store(MemAddr, Src),
    Branch(MemAddr, ConditionalCode),
    Xor(Register, Src),
    Add(Register, Src),
    Rotate(Register, Immediate),
    Shift(Register, Immediate),
    Halt,
    Complement(Register, Src),
}

impl Operation {
    fn opcode(&self) -> u32 {
        match self {
            Operation::Nop => 0,
            Operation::Load(_, _) => 1,
            Operation::Store(_, _) => 2,
            Operation::Branch(_, _) => 3,
            Operation::Xor(_, _) => 4,
            Operation::Add(_, _) => 5,
            Operation::Rotate(_, _) => 6,
            Operation::Shift(_, _) => 7,
            Operation::Halt => 8,
            Operation::Complement(_, _) => 9,
        }
    }

    fn to_word(&self, labels: &HashMap<String, u32>) -> u32 {
        let opcode = self.opcode();

        let mut cc = 0;
        let mut src_type: bool = false;
        let mut dest_type: bool = false;
        let mut src_addr_cnt: i32 = 0;
        let mut dest_addr: u32 = 0;

        match self {
            Operation::Nop | Operation::Halt => {}
            Operation::Load(reg, mem1) => {
                dest_addr = *reg;
                match mem1 {
                    Mem1::Addr(addr) => {}
                    Mem1::Imm(_) => todo!(),
                }
            }
            Operation::Store(mem, src) => {
                match mem {
                    MemAddr::Raw(_) => todo!(),
                    MemAddr::Label(_) => todo!(),
                }
                match src {
                    Src::Reg(_) => todo!(),
                    Src::Imm(_) => todo!(),
                }
            }
            Operation::Branch(mem, s_cc) => {
                cc = *s_cc as u32;
                // TODO: does mem go in src or dest addr?
            }
            Operation::Xor(reg, src) => {
                dest_addr = *reg;
                match src {
                    Src::Reg(s_reg) => {
                        src_addr_cnt = *s_reg as i32;
                    }
                    Src::Imm(imm) => {
                        src_addr_cnt = *imm;
                        src_type = true;
                    }
                }
            }
            Operation::Add(reg, src) => {
                dest_addr = *reg;
                match src {
                    Src::Reg(s_reg) => {
                        src_addr_cnt = *s_reg as i32;
                    }
                    Src::Imm(imm) => {
                        src_addr_cnt = *imm;
                        src_type = true;
                    }
                }
            }
            Operation::Rotate(reg, cnt) => {
                dest_addr = *reg;
                src_addr_cnt = *cnt;
            }
            Operation::Shift(reg, cnt) => {
                dest_addr = *reg;
                src_addr_cnt = *cnt;
            }
            Operation::Complement(reg, src) => {
                dest_addr = *reg;
                match src {
                    Src::Reg(s_reg) => {
                        src_addr_cnt = *s_reg as i32;
                    }
                    Src::Imm(imm) => {
                        src_addr_cnt = *imm;
                        src_type = true;
                    }
                }
            }
        };

        // limit these fields to 12 bits, just in case
        src_addr_cnt &= 0xFFF;
        dest_addr &= 0xFFF;

        let word: u32 = (opcode << 28)
            | (cc << 24)
            | ((src_type as u32) << 27)
            | ((dest_type as u32) << 26)
            | ((src_addr_cnt as u32) << 12)
            | (dest_addr << 0);

        word
    }

    fn from_str_vec(v: &Vec<&str>) -> Option<Operation> {
        let re_op = Regex::new(r"(nop|ld|str|bra|xor|add|rot|shf|hlt|cmp)\b").unwrap();
        let re_register = Regex::new(r"\br(?:1[0-5]{1}|[0-9]{1})\b").unwrap();
        let re_cc = Regex::new(r"(a|p|e|c|n|z|nc|po)\b").unwrap();

        let n = v.len();
        let op_name = v[0];
        if n < 1 || !re_op.is_match(op_name) {
            return None;
        }

        if op_name == "hlt" {
            return Some(Operation::Halt);
        } else if op_name == "nop" {
            return Some(Operation::Nop);
        }

        if n < 3 {
            return None;
        }

        if op_name == "bra" {
            let cond_code = CONDCODE_MAP.get(v[2]).cloned();
            if cond_code.is_none() {
                return None;
            }
            let cond_code = cond_code.unwrap();

            let mem_addr = extract_memory_addr(v[1]);

            if mem_addr.is_none() {
                return None;
            }

            return Some(Operation::Branch(mem_addr.unwrap(), cond_code));
        }

        if op_name == "xor" || op_name == "add" || op_name == "cmp" {
            let r1 = REGISTER_MAP.get(v[1]).cloned();
            let r2 = REGISTER_MAP.get(v[2]).cloned();

            if r1.is_none() {
                return None;
            }
            let r1 = r1.unwrap();

            let src = if r2.is_some() {
                Src::Reg(r2.unwrap())
            } else {
                let imm = extract_immediate(v[2]);
                if imm.is_none() {
                    return None;
                }
                Src::Imm(imm.unwrap())
            };

            return Some(if op_name == "xor" {
                Operation::Xor(r1, src)
            } else if op_name == "add" {
                Operation::Add(r1, src)
            } else {
                Operation::Complement(r1, src)
            });
        }
        if op_name == "rot" || op_name == "shf" {
            let r1 = REGISTER_MAP.get(v[1]).cloned();
            if r1.is_none() {
                return None;
            }
            let r1 = r1.unwrap();

            let imm = extract_immediate(v[2]);

            if imm.is_none() {
                return None;
            }

            return Some(if op_name == "rot" {
                Operation::Rotate(r1, imm.unwrap())
            } else {
                Operation::Shift(r1, imm.unwrap())
            });
        }

        Some(Operation::Nop)
        // None
    }
}

fn extract_memory_addr(s: &str) -> Option<u32> {
    let regex = Regex::new(r"[0-9]{1,4}").unwrap();
    if !regex.is_match(s) {
        return None;
    }
    let string = s.to_string()[1..].to_string();
    let i = string.parse::<u32>().unwrap();
    Some(i)
}

fn extract_immediate(s: &str) -> Option<Immediate> {
    let regex = Regex::new(r"#[-]{0,1}[0-9]{1,4}\b").unwrap();
    if !regex.is_match(s) {
        return None;
    }
    let string = s.to_string()[1..].to_string();
    let i = string.parse::<i32>().unwrap();
    // if i > 2047 || i < -2048 {
    //     return None;
    // }
    Some(i)
}

use std::env;

fn main() -> io::Result<()> {
    println!("Hello, world!");

    let args: Vec<String> = env::args().collect();
    dbg!(&args);

    if args.len() < 3 {
        panic!("Not enough args!");
    }

    let input_file = args[1].clone();
    let output_file = args[2].clone();

    // define regex
    let re_label_marker = Regex::new(r"\b[a-zA-Z][a-zA-Z0-9]*:").unwrap();

    let re_immediate_mem = RegexSet::new(&[
        r"0x[[:xdigit:]]{1,3}\b",
        r"0o[0-7]{1,4}\b",
        r"0b[0-1]{1,12}\b",
        r"[0-9]{1,4}\b",
    ])
    .unwrap();

    let fd = File::open(input_file)?;
    let reader = BufReader::new(fd);

    // define variabless
    let mut line_count = 0;
    let mut tag_map: HashMap<String, u32> = HashMap::new();
    let mut operations: Vec<Operation> = Vec::new();

    for line in reader.lines() {
        // println!("{}", &line?);
        let trimmed = line.unwrap().clone().to_lowercase();
        println!("{}", &trimmed);
        if trimmed == "" || trimmed.starts_with("//") {
            // comment or blank line
            continue;
        }

        // line_count += 1;
        let mut split = trimmed
            .split(" ")
            .map(|s| s.split(","))
            .flatten()
            .collect::<Vec<_>>();
        let n = split.len();
        println!("{:?}", split);

        if re_label_marker.is_match(split[0]) {
            // found label
            println!("{}", split[0]);
            let mut chars = split[0].chars();
            chars.next_back();
            let label_line = if n > 1 { line_count } else { line_count + 1 };
            tag_map.insert(String::from(chars.as_str()), label_line);
            dbg!(&tag_map);
            split.remove(0);
        }
        if split.len() > 0 {
            line_count += 1;
            let op = Operation::from_str_vec(&split).expect("Invalid operation found");
            dbg!(&op);
            operations.push(op);
        }
        // println!("Operation found: {}", split[op_idx]);
    }

    if operations.len() < 1 {
        panic!("No operations found");
    }

    let mut fd_out = File::create(output_file)?;
    // let writer = BufWriter::new(fd_out);

    for op in operations {
        let word = op.to_word(&tag_map);
        writeln!(fd_out, "{:032b}", word)?;
    }

    drop(fd_out);

    Ok(())
}
