module Main where

import Html

main :: IO ()
main = putStrLn (render myhtml)

myhtml :: Html
myhtml = 
  html_ 
    "myTitle>>" 
      ( append_ 
        ( h1_ "Hello world>>" ) 
          ( append_ 
            (
              ul_ 
                [ p_ "are you ok?"
                , p_ "I hope you're fine"
                , p_ ":D"
                ]
            )
            (
              code_ "are you ok?"
            )
          )
      )