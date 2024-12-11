{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <&>" #-}
import AOCUtils (run)
import Data.List
import Data.Char
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)
import Data.Array

inputFiles1 = ["test", "11_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------
-- PARSING ----------------------------
numberP :: Parser Int
numberP = read <$> many1 digit

parseInput :: Parser [Int]
parseInput = sepEndBy1 numberP (char ' ')
-- SOLUTION 1 -------------------------
solve1 :: [Int] -> Int
solve1 input = length $ foldr (\c acc -> concatMap blink acc) input [1..25]
-- SOLUTION 2 -------------------------
solve2 input = input
-- UTILS ------------------------------
split' :: Int -> [Int]
split' n = let
        (left, right) = splitAt (length digits `div` 2) digits
    in [fromDigits left, fromDigits right]
  where
    digits = toDigits n

toDigits :: Int -> [Int]
toDigits 0 = []
toDigits x = toDigits (x `div` 10) ++ [x `mod` 10]

fromDigits :: [Int] -> Int
fromDigits = foldl (\acc d -> acc * 10 + d) 0

blink :: Int -> [Int]
blink 0 = [1]
blink pebble | even $ length $ toDigits pebble = split' pebble
             | otherwise = [pebble*2024]