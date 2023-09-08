#include <string>
#include <iostream>
using std::cout;
using std::endl;

// https://youtube.com/playlist?list=PLSq9OFrD2Q3ChEc_ejnBcO5u9JeT0ufkg&si=U1ZZsFlDg1-Tu8AC
// https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/index.html

// Listing identifiers
enum Token {
    tok_eof = -1,

    //commands
    tok_def = -2,
    tok_extern = -3,

    //primary
    tok_identifier = -4,
    tok_number = -5
};

static std::string IdentifierStr; // filled in if tok_identifier
static double NumVal;             // filled in if tok_number

// gettok - Return the next token from standard input
// gettok also recognize identifiers and specific keywords like "def"
static int gettok() {
    static int LastChar = ' ';

    // skip any whitespace
    while (isspace(LastChar)) {
        LastChar = getchar();
    }

    if (isalpha(LastChar)) { // identifier: [a-zA-Z][a-zA-Z0-9], if the value is passed to isalpha is part of the alphabet, it returns an non-zero integer
        IdentifierStr = LastChar;
        while (isalnum((LastChar = getchar()))) {
            IdentifierStr += LastChar;
        };

        if (IdentifierStr == "def") {
            return tok_def;
        }
        if (IdentifierStr == "extern") {
            return tok_extern;
        };

        return tok_identifier;
    }

    if (isdigit(LastChar) || LastChar == '.') { // number: [0-9.]+
        std::string NumStr;
        do {
            NumStr += LastChar;
            LastChar = getchar();
        } while (isdigit(LastChar) || LastChar == '.');

        NumVal = strtod(NumStr.c_str(), 0);
        return tok_number;
    }

    if (LastChar == '#') {
        // Comment until end of file

        do {
            LastChar = getchar();
        } while (LastChar != EOF && LastChar != '\n' && LastChar != '\r');

        if (LastChar != EOF) {
            return gettok();
        }
    }

    // Check for end of file. Don't eat the EOF.
    if (LastChar == EOF) {
        return tok_eof;
    }

    // Otherwise, just return the character as its ascii value.
    int ThisChar = LastChar;
    LastChar = getchar();
    return ThisChar;
}

// int main() {
//     while (true) {
//         int tok = gettok();
//         cout << "got token: " << tok << endl;
//     }
// }
