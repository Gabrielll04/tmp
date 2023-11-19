module Markup 
  ( Document
  , Structure (..)  
  )
where

import Numeric.Natural (Natural)
import Data.Maybe (maybeToList)

data Structure 
  = Heading Natural String
  | Paragraph String
  | UnorderedList [String]
  | OrderedList [String]
  | CodeBlock [String]
  deriving (Eq, Show)

data Context 
  = CtxHeading Natural String
  | CtxParagraph [String]
  | CtxUnorderedList [String]
  | CtxOrderedList [String]
  | CtxCodeBlock [String]

type Document
  = [Structure]

parse :: String -> Document
parse = parseLines Nothing . lines 

parseLines :: Maybe Structure -> [String] -> Document
parseLines context txts = 
  case txts of
    [] -> maybeToList context

    -- Heading case
    ('*' : ' ' : line) : rest ->
      maybe id (:) context (parseLines (Just (Heading 1 (trim line))) rest) -- Na prática, caso o maybe receba um Just, ele vai aplicar append do context com o context Heading da próxima iteração. 
      
    -- UnorderedList case
    ('-' : ' ' : line) : rest ->
      case context of
        Just (UnorderedList list) -> 
          parseLines (Just (UnorderedList (list <> [trim line]))) rest 
        _ -> -- Here we cannot use Nothing because if we do, we would lose the earlier contexts.
          maybe id (:) context (parseLines (Just (UnorderedList [trim line])) rest) -- O maybe aqui é necesário pois irá juntar o contexto que foi gerado até então com a próxima iteração. Imagine que tivéssimos um parágrafo Heading, e agora um UnorderedList, na próxima iteração, o contexto será UnorderedList. Para não perdermos o contexto anterior com Heading, nós usamos maybe, que na prática, é como se fosse um case. Caso o contexto seja Just, nós juntamos esse context com o context da próxima iteração.

    -- OrderedList case
    ('#' : ' ' : line) : rest ->
      case context of
        Just (OrderedList list) ->
          parseLines (Just (OrderedList (list <> [trim line]))) rest
        _ ->
          maybe id (:) context (parseLines (Just (OrderedList [trim line])) rest)

    -- CodeBlock case
    ('>' : ' ' : line) : rest ->
      case context of
        Just (CodeBlock code) ->
          parseLines (Just (CodeBlock (code <> [line]))) rest
        _ ->
          maybe id (:) context (parseLines (Just (CodeBlock [line])) rest)

    -- Paragraph case
    (currentLine : rest) ->
      let 
        line = trim currentLine 
      in
        if line == ""
          then 
            maybe id (:) context (parseLines Nothing rest) -- Eu não perco o contexto ao aplicar o Nothing por conta do maybe.
          else 
            case context of
              Just (Paragraph paragraph) ->
                parseLines (Just (Paragraph (unwords [paragraph, line]))) rest
              _ -> 
                maybe id (:) context (parseLines (Just (Paragraph (trim line))) rest)

trim :: String -> String
trim = unwords . words
