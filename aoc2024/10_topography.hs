{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <&>" #-}
import AOCUtils (run)
import Data.List
import Data.Char
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)
import Data.Array

inputFiles1 = ["test", "10_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------
type Map2D = Array (Int, Int) Int
-- PARSING ----------------------------
digitP :: Parser Int
digitP = digit >>= return . digitToInt

lineP :: Parser [Int]
lineP = many1 digitP

parseInput :: Parser Map2D
parseInput = do
    rows <- sepEndBy1 lineP newline
    let numRows = length rows
        numCols = length (head rows)
        flatList = concat rows
        bounds = ((0, 0), (numRows - 1, numCols - 1))
    return $ listArray bounds flatList

-- SOLUTION 1 -------------------------
solve1 :: Map2D -> Int
solve1 array = length $ concatMap (\pos -> group $ sort $ search pos 0 array) $ zeros array
    where
        zeros array = [index | (index, value) <- assocs array, value == 0]
-- SOLUTION 2 -------------------------
solve2 :: Map2D -> Int
solve2 array = length $ concatMap (\pos -> search pos 0 array) $ zeros array
    where
        zeros array = [index | (index, value) <- assocs array, value == 0]
-- UTILS ------------------------------

search :: (Int, Int) -> Int -> Map2D -> [(Int, Int)]
search (x, y) h array | array ! (x, y) == 9 = [(x, y)]
                      | otherwise = concat [search pos h' array | (dx, dy) <- [(- 1, 0), (1, 0), (0, - 1), (0, 1)], let pos = (x + dx, y + dy), let h' = h + 1, inRange (bounds array) pos && array ! pos == h']