data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn Earth seconds = (seconds / 86400) / 365.25
ageOn Mercury seconds = (seconds / 86400*2) / 87.969257175 -- That's not finished.

main :: IO ()
main =  do
    print(ageOn Mercury 2134835688)
