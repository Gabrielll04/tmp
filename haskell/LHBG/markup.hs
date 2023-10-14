module Markup 
  ( Document
  , Structure (..)  
  )
where

import Numeric.Natural (Natural)

data Structure 
  = Heading Natural String
  | Paragraph String
  | UnorderedList [String]
  | OrderedList [String]
  | CodeBlock [String]

type Document
  = [Structure]