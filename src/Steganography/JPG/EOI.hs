module Steganography.JPG.EOI (encode, decode) where

import Utils (bytesToInteger, integerToBytes)
import Data.ByteString (ByteString)
import qualified Data.ByteString as BS
import System.IO (Handle, hSeek, SeekMode (SeekFromEnd), withFile, IOMode (ReadMode))

metaLength :: Int
metaLength = 4

-- Encoding

encode :: ByteString -> ByteString -> ByteString
encode cover msg = cover `BS.append` msg `BS.append` msgLength
  where
    msgLength = integerToBytes (toInteger $ BS.length msg) metaLength

-- Decoding

decode :: FilePath -> IO ByteString
decode stegoPath = do
  msgLength <- withFile stegoPath ReadMode getMsgLength
  withFile stegoPath ReadMode (getMsg msgLength)

getMsgLength :: Handle -> IO Int
getMsgLength hdl = do
  hSeek hdl SeekFromEnd (negate $ toInteger metaLength)
  lengthBytes <- BS.hGetContents hdl
  return $ fromInteger $ bytesToInteger lengthBytes

getMsg :: Int -> Handle -> IO ByteString
getMsg msgLength hdl = do
  hSeek hdl SeekFromEnd (negate $ toInteger (msgLength + metaLength))
  BS.hGet hdl msgLength