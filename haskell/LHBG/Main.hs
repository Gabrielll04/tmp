module Main where

import Html

main :: IO ()
main = putStrLn (ul_ [h_ "teste"])

myhtml :: Html
myhtml = 
  html_ 
    "myTitle>>" 
      ( append_ 
        ( h1_ "Hello world>>" ) 
          ( append_ 
            ( p_ "are you okay?" )
            ( p_ "I hope you're fine" )
          )
      )