#include <string>
#include <vector>
#include <iostream>
#include <memory> 
#include <map>
// using std::cout;
// using std::endl;

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

// ExprAST - Base class for all expression nodes.
/// This allow the later phases of the compiler to know what the storage expression value is.
class ExprAST {
public:
    virtual ~ExprAST() = default;
};

/// NumberExprAST - Expression class for numeric literals like "1.0".
class NumberExprAST : public ExprAST {
    double Val;
    
public: 
    NumberExprAST(double Val) : Val(Val) {}
};

class VariableExpreAST : public ExprAST {
    std::string Name;


public:
    VariableExpreAST(const std::string &Name) : Name(Name) {}; // the '&' is a reference, with references you can directly access the memory location, thats why its passes as a const value. This makes it much more efficient, saving memory and processing time.
};

/// BinaryExprAST - Expression class for a binary operator.
class BinaryExprAST : public ExprAST {
    char Op; // + - * / > < 
    std::unique_ptr<ExprAST> LHS, RHS;

public: 
    BinaryExprAST(
        char op, 
        std::unique_ptr<ExprAST> LHS,
        std::unique_ptr<ExprAST> RHS
    ) : Op(op), LHS(std::move(LHS)), RHS(std::move(RHS)) {};
};

/// Expression class for function calls
class CallExprAST : public ExprAST {
    std::string Callee;
    std::vector<std::unique_ptr<ExprAST>> Args; // You can read this in this way: Args is a vector which contains uniques objects of ExprAST.

public: 
    CallExprAST(
        std::string Callee,
        std::vector<std::unique_ptr<ExprAST>> Args
    ) : Callee(Callee), Args(std::move(Args)) {};
};

// The two thins we need next are a way to talk about the interfaces to a function and a way to talk about functions themselves.

/// PrototypeAST - This class represents the "prototype" for a function,
/// which captures its name, and its argument names (thus implicitly the number
/// of arguments the function takes).
class PrototypeAST : public ExprAST {
    std::string Name;
    std::vector<std::string> Args; 

public: 
    PrototypeAST(
        const std::string &Name,
        std::vector<std::string> Args
    ) : Name(Name), Args(std::move(Args)) {}

    const std::string &getName() const { return Name; }
};

///FunctionAST - This class represents the function definition itself.
class FunctionAST : public ExprAST {
    std::unique_ptr<PrototypeAST> Proto;
    std::unique_ptr<ExprAST> Body;

public:
    FunctionAST(
        std::unique_ptr<PrototypeAST> Proto,
        std::unique_ptr<ExprAST> Body
    ) : Proto(std::move(Proto)), Body(std::move(Body)) {}
};

// Parsing expressions and function bodies in Kaleidoscope

/// CurTok/getNextToken - Provide a simple token buffer. CurTok is the current
/// token the parser is looking at. getNextToken reads another token from the
/// lexer and updates CurTok with its results.
static int CurTok;
static int getNextToken() {
    CurTok = gettok();
}

/// LogError* - These are little helper functions for error handling.
std::unique_ptr<ExprAST> LogError(const char *Str) {
    fprintf(stderr, "Error: %s\n", Str);
    return nullptr;
}
std::unique_ptr<PrototypeAST> LogErrorP(const char *Str) {
    LogError(Str);
    return nullptr;
}

// Expression parsing, the parsers:

/// numberexpr ::= number
static std::unique_ptr<ExprAST> ParseNumberExpr() {
    auto Result = std::make_unique<NumberExprAST>(NumVal); // It takes the current number value, creates an NumberExprAST node, advances the lexer to the next token, and finally returns.
    getNextToken(); //consume the number
    return std::move(Result);
}

static std::unique_ptr<ExprAST> ParseExpression();

/// parenexpr ::= '(' expression ')'
static std::unique_ptr<ExprAST> ParseParenExpr() {
    getNextToken(); // eat (.
    auto V = ParseExpression();
    if (!V) {
        return nullptr;
    }

    if (CurTok != ')') {
        return LogError("expected ')'");
    }
    getNextToken(); 
    return V;
}

/// identifierexpr
/// ::= identifier
/// ::= identifier '(' expression ')'
/// It expects to be called if the current token is a tok_identifier token.
/// It also have recursion and error handling.
static std::unique_ptr<ExprAST> ParseIdentifierExpr() {
    std::string IdName = IdentifierStr;

    getNextToken(); // Eat identifier.

    if (CurTok != '(') { // Simple variable ref.
        return std::make_unique<VariableExpreAST>(IdName);
    }

    // Call.
    getNextToken();
    std::vector<std::unique_ptr<ExprAST>> Args;
    if (CurTok != ')') {
        while (true) {
            if (auto Arg = ParseExpression()) {
                Args.push_back(std::move(Arg));
            }
            else {
                return nullptr;
            }

            if (CurTok == ')') {
                break;
            }

            if (CurTok != ',') {
                return LogError("Expected ')' or ',' in argument list");
            }
            getNextToken();
        }
    }

    getNextToken();

    return std::make_unique<CallExprAST>(IdName, std::move(Args));
}

// Now that we have all of our simple parsing-expression in place, we need a function to wrap all of it together in one entry point.

/// primary
/// ::= identifierexpr
/// ::= numberexpr
/// ::= parenexpr
static std::unique_ptr<ExprAST> ParsePrimary() {
    switch (CurTok) {
        default:
            return LogError("unknown token when expecting an expression");
        case tok_identifier:
            return ParseIdentifierExpr();
        case tok_number:
            return ParseNumberExpr();
        case '(':
            return ParseParenExpr();
    }
}

// Binary expressions are significantly harder to parse because they are often ambiguous. For example, when given the string “x+y*z”, the parser can choose to parse it as either “(x+y)*z” or “x+(y*z)”. With common definitions from mathematics, we expect the later parse, because “*” (multiplication) has higher precedence than “+” (addition).

/// BinopPrecedence - This holds the precedence for each binary operator that is defined.
static std::map<char, int> BinopPrecedence;

/// GetTokPrecedence - Get the precedence of the pending binary operator token.
static int GetTokPrecedence() {
    if (!isascii(CurTok)) {
        return -1;
    }

    // Make sure its a declared binop.
    int TokPrec = BinopPrecedence[CurTok];
    if (TokPrec <= 0) return -1;
    return TokPrec;
}

int main() {
    // Install standard binary operators.
    // 1 Is lowest precedence
    BinopPrecedence['<'] = 10;
    BinopPrecedence['+'] = 20;
    BinopPrecedence['-'] = 20;
    BinopPrecedence['*'] = 40; // highest
}

// Note that because parentheses are primary expressions, the binary expression parser doesn't need to worry about nested subexpressions like (a+b) at all.

/// binoprhs
/// ::= ('+' primary)*
static std::unique_ptr<ExprAST> ParseBinOpRHS(int ExprPrec, std::unique_ptr<ExprAST> LHS) {
    // If this is a binop, find its precedence.
    while (true) {
        int TokPrec = GetTokPrecedence();

        // If this is a binop that binds at least as tighly as the current binop, consume it, otherwise we are done.
        if (TokPrec < ExprPrec) {
            return LHS;
        } else {
            // Okay, now we know this is a binop.
            int BinOp = CurTok; 
            getNextToken(); // Eat the binop.

            // Parse the primary expression after the binary operator
            auto RHS = ParsePrimary();

            if (!RHS) {
                return nullptr;
            }
        }
    }
}

/// expression
/// ::= primary binoprhs
static std::unique_ptr<ExprAST> ParseExpression() {
    auto LHS = ParsePrimary();
    if (!LHS) {
        return nullptr;
    }

    return ParseBinOpRHS(0, std::move(LHS));
}
