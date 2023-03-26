module Main (main) where

import qualified Data.ByteString as BS
import System.FilePath ((</>))
import Steganography.EOF (encode)

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
  coverBytes <- BS.readFile coverFile
  msgBytes <- BS.readFile msgFile
  let stegoBytes = encode coverBytes msgBytes
  BS.writeFile stegoFile stegoBytes
