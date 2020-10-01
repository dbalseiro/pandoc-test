{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib (docx2html)

import System.Environment (getArgs)
import System.FilePath (replaceExtension, FilePath)

import Data.Semigroup ((<>))
import Data.Text (Text)
import qualified Data.ByteString.Lazy as BS
import qualified Data.Text.IO as T
import qualified Data.Text as T

main :: IO ()
main = getArgs >>= \case
  [file] -> convert file
  _      -> error "Usage: pandoc_test <filename.docx>"

convert :: FilePath -> IO ()
convert f = BS.readFile f
            >>= T.putStrLn
            -- >>= T.writeFile (newFilename f)
                -- . replaceDeletion
                -- . replaceInsertion
                . docx2html

replaceTextWith :: Text -> Text -> Text -> Text
replaceTextWith from to txt = go $ T.breakOn from txt
   where
    go (p, []) = p
    go (p, s)  = p <> replaceTextWith from to (replaceText s)
    replaceText t = to <> T.dropWhile ('>' /=) (T.drop (T.length from) t)

replaceDeletion :: Text -> Text
replaceDeletion = replaceTextWith "<span class=\"deletion\"" "<span text-decoration=\"line-through\""

replaceInsertion :: Text -> Text
replaceInsertion = replaceTextWith "<span class=\"insertion\"" "<span text-decoration=\"underline\""

newFilename :: FilePath -> FilePath
newFilename = flip replaceExtension "html"
