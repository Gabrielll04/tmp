myhtml :: String -> String -> String
myhtml title content = htmlWrap title content

htmlWrap :: String -> String -> String
htmlWrap title content = makeHtml title content

makeHtml :: String -> String -> String
makeHtml title content = html_ (head_ (title_ title) <> body_ content)

html_ :: String -> String
html_ content = "<html>" <> content <> "</html>"

head_ :: String -> String
head_ content = "<head>" <> content <> "</head>"

body_ :: String -> String
body_ content = "<body>" <> content <> "</body>"

title_ :: String -> String
title_ content = "<title>" <> content <> "</title>"

main :: IO ()
main = do
    print (myhtml "myTitle" "Hello :)")
