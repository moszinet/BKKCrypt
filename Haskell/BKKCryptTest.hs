import           BKKCrypt
import           Test.QuickCheck

prop_equal :: String -> Bool
prop_equal x = bkkCrypt x == x

main :: IO()
main = quickCheck prop_equal
