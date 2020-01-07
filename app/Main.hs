{-# LANGUAGE LambdaCase        #-}

module Main where

import Lib (docx2html)

import System.IO (hPutStrLn, stderr)
import System.Environment (getArgs)

import Control.Monad ((<=<))

import Data.ByteString (ByteString)
import qualified Data.ByteString as BS

main :: IO ()
main = getArgs >>= \case
  [file] -> convert file
  _      -> usage

usage :: IO ()
usage = hPutStrLn stderr "Usage: pandoc_test <filename.docx>"

convert :: String -> IO ()
convert = saveFile . docx2html <=< BS.readFile

saveFile :: ByteString -> IO ()
saveFile = print
