use std::io;

fn read_numbers(temp_to_convert: char) -> Result<f64, String> {
    let mut n1: String = String::new();
    
    println!("Insira a temperatura em {temp_to_convert}");
    
    io::stdin()
        .read_line(&mut n1)
        .expect("Ocorreu um erro ao ler a temperatura inserida");

    // work in progress, writing this bc im bored
    match n1.trim().parse::<f64>() {
        Ok(num) => {
            match temp_to_convert {
                'F' => Ok((num - 32.) * 5.0 / 9.0),
                'C' => Ok(num * 9.0 / 5.0 + 32.0),
                _ => Err("Opção inválida!".to_string()),
            }
        },
        Err(_) => Err("Ocorreu um erro ao converter o valor recebido!".to_string()),
    } 
}

fn f2c() -> Result<f64, String> {
    return read_numbers('F');
}

fn c2f() -> Result<f64, String> {
    return read_numbers('C');
}

fn menu() {
    loop {
        let mut op: String = String::new();
    
        println!("MENU");
        println!("1 - Converter de F para C");
        println!("2 - Converter de C para F");
        
        io::stdin()
            .read_line(&mut op)
            .expect("Failed to read line");
    
        let op: u8 = match op.trim().parse() {
            Ok(num) => num,
            Err(_) => {
                println!("Entrada inválida. Tente novamente.");
                continue;
            },
        };
    
        match op {
            1 => match f2c() {
                Ok(result) => println!("Resultado: {:.2} °C", result),
                Err(e) => println!("{}", e),
            },
            2 => match c2f() {
                Ok(result) => println!("Resultado: {:.2} °F", result),
                Err(e) => println!("{}", e)
            }
            _ => println!("Você deve inserir uma opção existente!"),
        };
    }
}

fn main() {
    menu();
}
