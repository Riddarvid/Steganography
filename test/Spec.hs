import Utils (integerToBytes, bytesToInteger)
import Test.QuickCheck (Property, (===), quickCheck)

main :: IO ()
main = do
  quickCheck propIntegerToBytes

propIntegerToBytes :: Integer -> Property
propIntegerToBytes n = n' === bytesToInteger (integerToBytes n' 4)
  where
    n' = abs n