module Main (main) where

import qualified Data.ByteString as BS
import System.FilePath ((</>))
import Steganography.JPG.EOI (encode, decode)

inputDir :: FilePath
inputDir = "/home/riddarvid/steg/stegInput"

coverFile :: FilePath
coverFile = inputDir </> "cover.JPG"

msgFile :: FilePath
msgFile = inputDir </> "msg.txt"

outputDir :: FilePath
outputDir = "/home/riddarvid/steg/stegOutput"

stegoFile :: FilePath
stegoFile = outputDir </> "stego.JPG"

outputFile :: FilePath
outputFile = outputDir </> "decoded.txt"

main :: IO ()
main = do
  mainEncode
  mainDecode

mainEncode :: IO ()
mainEncode = do
  coverBytes <- BS.readFile coverFile
  msgBytes <- BS.readFile msgFile
  let stegoBytes = encode coverBytes msgBytes
  BS.writeFile stegoFile stegoBytes

mainDecode :: IO ()
mainDecode = do
  decoded <- decode stegoFile
  BS.writeFile outputFile decoded