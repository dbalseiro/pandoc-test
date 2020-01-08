module Lib
    ( docx2html
    ) where

import Data.ByteString.Lazy (ByteString)
import Data.Text (Text)
import Data.Default (def)

import Control.Monad ((<=<))

import Text.Pandoc (readDocx, writeHtml5String, runPure)

docx2html :: ByteString -> Text
docx2html =
  either (error . show) id
  . runPure
  . (writeHtml5String def <=< readDocx def)
