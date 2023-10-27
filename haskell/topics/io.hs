import Control.Monad (when, forever, forM)
import Data.Char

reverseWords :: String -> String  
reverseWords = unwords . map reverse . words

-- main = do
--     return ()
--     return 4
--     return "hello" -- return doesn't' cause the I/O do block to end in execution or anything like that.

myFunc = do  
    a <- return "hell"  
    b <- return "yeah!"  
    putStrLn $ a ++ " " ++ b 

fgetChar = do
    c <- getChar
    -- if c /= ' '
    --     then do
    --         putChar c
    --         main
    --     else return ()
    when (c /= ' ') $ do -- 'when' takes a boolean value and a I/0 action, it returns the same I/O action if the boolean value is True and returns 'result ()' if its value is False
        putChar c  
        fgetChar

fSequence = do
    rs <- sequence [getLine, getLine, getLine]  
    print rs -- Sequence to execute I/O actions one after the other. 

fForever = forever $ do
    putStr "Please give me some input: "
    l <- getLine
    putStrLn $ map toUpper l

fForM = do 
    colors <- forM [1,2,3,4] (\a -> do  
        putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"  
        color <- getLine  
        return color)  
    putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "  
    mapM putStrLn colors  

main :: IO ()
main = do
    -- putStrLn "Hello, what's your name?"
    -- name <- getLine
    -- putStrLn ("Hello, " ++ name ++ "! How are you?")
    
    -- putStrLn (name ++ " mate!") woundn't work because '++' requires its both parameters to be list over the same type.
    -- " mate!" is a String, but the 'name' is 'IO String'.
    
    line <- getLine  
    if null line  
        then return () -- The 'return' in Haskell is really nothing like the 'return' in most other languages. It makes an I/O action out of a pure value.
        else do -- ifs have to have a form of if condition then I/O action else I/O action.
            putStrLn $ reverseWords line  
            main
            
    mapM_ print [1,2,3] -- use mapM or mapM_ to map a I/O action into a list.
