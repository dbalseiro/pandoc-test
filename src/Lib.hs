{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( docx2html
    ) where

import Data.ByteString (ByteString)

docx2html :: ByteString -> ByteString
docx2html = const "data"
