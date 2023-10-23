calcBmis :: (RealFloat a) => [(a,a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight heigth = weight / heigth ^ 2

main :: IO ()
main = do
    print (calcBmis [(32,41), (32,53), (43,12)])
