{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib (docx2html)

import System.Environment (getArgs)
import System.FilePath (FilePath)

import qualified Data.ByteString.Lazy as BS
import qualified Data.Text.IO as T

main :: IO ()
main = getArgs >>= \case
  [file] -> convert file
  _      -> error "Usage: pandoc_test <filename.docx>"

convert :: FilePath -> IO ()
convert f = BS.readFile f >>= T.putStrLn . docx2html
