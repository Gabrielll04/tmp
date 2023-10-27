reverseWords :: String -> String  
reverseWords = unwords . map reverse . words

main :: IO ()
main = do
    -- putStrLn "Hello, what's your name?"
    -- name <- getLine
    -- putStrLn ("Hello, " ++ name ++ "! How are you?")
    
    -- putStrLn (name ++ " mate!") woundn't work because '++' requires its both parameters to be list over the same type.
    -- " mate!" is a String, but the 'name' is 'IO String'.
    
    line <- getLine  
    if null line  
        then return ()  
        else do -- ifs have to have a form of if condition then I/O action else I/O action.
            putStrLn $ reverseWords line  
            main 
