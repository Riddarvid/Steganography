module Utils (
  bytesToInteger,
  integerToBytes
) where

import Data.ByteString (ByteString)
import qualified Data.ByteString as BS

bytesToInteger :: ByteString -> Integer
bytesToInteger = BS.foldl (\acc byte -> 0xFF * acc + fromIntegral byte) 0

integerToBytes :: Integer -> Int -> ByteString
integerToBytes n nBytes = 
  BS.pack $ map (fromInteger . (`mod` 0xFF)) $ reverse $ take nBytes $ iterate (`div` 0xFF) n