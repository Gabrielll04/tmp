use std::io;

fn getNumbers(tempToConvert: char) -> Result<String, f64> {
    let mut n1: String = String::new();
    
    println!("Insira a temperatura em {tempToConvert}");
    
    io::stdin()
        .read_line(&mut n1)
        .expect("Ocorreu um erro ao ler a temperatura inserita");

    // work in progress, writing this bc im bored
    // match n1.parse()::f64 {
    //     Ok(num) => Ok(num),
    //     Err(_)
    // } 
    
    // let n1: Result<String, f64> = match n1.trim().parse() {
    //     Ok(num) => num,
    //     Err(_) => Err("Ocorreu um erro ao converter o valor".toString()),
    // };
    
    return n1;
}

fn f2c() {
    return getNumbers('F');
}

fn c2f() {
    return getNumbers('C');
}

fn menu() {
    let mut op: String = String::new();
    
    loop {
        println!("MENU");
        println!("1 - Converter de F para C");
        println!("2 - Converter de C para F");
        
        io::stdin()
            .read_line(&mut op)
            .expect("Failed to read line");
    
        let op: u8 = match op.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
    
        match op {
            1 => f2c(),
            2 => c2f(),
            _ => println!("Você deve inserir uma opção existente!"),
        };
    }
}

fn main() {
    menu();
}
