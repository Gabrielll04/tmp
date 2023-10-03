-- Still working on it...

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn Earth seconds = (seconds / 86400) / 365.256

main :: IO ()
main =  do
    print(ageOn Earth 1000000000)
