-- In Javascript and some other weakly typed languages, you ca put almost anything inside an if expression.
-- For exemple 'if (0) alert("YEAH!") else alert("NO!")' will alert 'NO!'
-- Lets replicate that behaviour in Haskell:

class YesNo a where
    yesno :: a -> Bool
    
instance YesNo Int where
    yesno 0 = False
    yesno _ = True
    
instance YesNo [a] where
    yesno [] = False
    yesno _ = True
    
instance YesNo Bool where
    yesno = id -- id takes a parameter and returns the same thing.
    
instance YesNo (Maybe a) where  
    yesno (Just _) = True  
    yesno Nothing = False
    
-- yesnoIf is a functiona that mimic the if statement
yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesnoVal yesResult noResult = if yesno yesnoVal then yesResult else noResult
    
main :: IO ()
main = do
    print (yesno $ length []) -- False
    print (yesno "test") -- True
    print (yesnoIf "True" "really?" "no :(")
    print (yesnoIf (Just 500) "YEAH!" "NO!"  )
