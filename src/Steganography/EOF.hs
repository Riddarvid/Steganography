module Steganography.EOF (encode) where

import Utils (bytesToInteger)
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import System.IO (Handle, hSeek, SeekMode (SeekFromEnd))

encode :: ByteString -> ByteString -> ByteString
encode = BS.append

-- Drop bytes until you find the marker byte (0xFF)
-- If the next byte is the EOI specifier (0xD9), simply return the rest of the string
-- Otherwise, keep searching for the next marker byte.
-- Works in theory but not in practice. Reading the file from start to end is
-- very slow. Solution: Let the last bytes represent the size of the message
-- We can then seek to that position using some of the functions in System.IO for
-- a more efficient search.
decode :: ByteString -> ByteString
decode stego
  | BS.head stego' == 0xD9 = BS.tail stego'
  | otherwise = decode stego'
  where
    stego' = BS.dropWhileEnd (/= 0xFF) stego

msgLength :: Handle -> IO Integer
msgLength hdl = do
  hSeek hdl SeekFromEnd (-4)
  lengthBytes <- BS.hGetContents hdl
  return $ bytesToInteger lengthBytes