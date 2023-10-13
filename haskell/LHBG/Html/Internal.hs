-- Html/Internal.hs

module Html.Internal where

-- * types

newtype Html 
  = Html String

newtype Structure 
  = Structure String

type Title
  = String

-- * EDSL 

html_ :: Title -> Structure -> Html
html_ title content =
  Html (
    el "html"
      ( el "title" ( escape title ) )
      <>  el "body" ( getStructString content )
  )

append_ :: Structure -> Structure -> Structure
append_ ( Structure c1 ) ( Structure c2 ) = 
  Structure (c1 <> c2)

p_ :: String -> Structure
p_ = Structure . el "p" . escape

h1_ :: String -> Structure
h1_ = Structure .  el "h1" . escape

-- * Render

render :: Html -> String
render (Html html) = html

-- * Utilities

el :: String -> String -> String
el tag content =
  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

getStructString :: Structure -> String
getStructString (Structure str) = str 

escape :: String -> String
escape = 
  let
    escapeChar c =
      case c of
        '<' -> "&alt;"
        '>' -> "&gt;"
        '&' -> "&amp;"
        '"' -> "&quot;"
        '\'' -> "&#39;"
        _ -> [c]
  in 
    concatMap escapeChar