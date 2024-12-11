{-# LANGUAGE TupleSections #-}
import AOCUtils (run)
import Data.List ( group, groupBy, sort )
import Text.Parsec ( char, digit, many1, sepEndBy1 )
import Data.Function ( on )
import Text.Parsec.String (Parser)
import qualified Data.Map as Map

inputFiles1 = ["test", "11_1"]
inputFiles2 = ["11_1"]

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------
-- PARSING ----------------------------
numberP :: Parser Int
numberP = read <$> many1 digit

parseInput :: Parser [Int]
parseInput = sepEndBy1 numberP (char ' ')

-- SOLUTION 1 -------------------------
solve1 :: [Int] -> Int
solve1 = solve 25

-- SOLUTION 2 -------------------------
solve2 :: [Int] -> Int
solve2 = solve 75

solve :: Int -> [Int] -> Int
solve n input = sum $ Map.elems $ foldr step (countsMap $ group $ sort input) [1..n]
  where
    grouped = groupBy ((==) `on` fst)
    countsMap xs = Map.fromList [(head x, length x) | x <- xs]
    step c acc = Map.fromList $ map (\xs -> (fst (head xs), sum (map snd xs))) $ grouped $ sort $ concat $ zipWith blinked (Map.keys acc) (Map.elems acc)
    blinked k e = map (, e) (blink k)

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
             | otherwise = [pebble * 2024]
