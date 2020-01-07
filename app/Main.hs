{-# LANGUAGE LambdaCase #-}

module Main where

import Lib (docx2html)

import System.Environment (getArgs)
import System.FilePath (replaceExtension, FilePath)

import qualified Data.ByteString as BS

main :: IO ()
main = getArgs >>= \case
  [file] -> convert file
  _      -> error "Usage: pandoc_test <filename.docx>"

convert :: FilePath -> IO ()
convert f = BS.readFile f >>= BS.writeFile (newFilename f) . docx2html

newFilename :: FilePath -> FilePath
newFilename = flip replaceExtension "html"
