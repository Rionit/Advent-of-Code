{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <&>" #-}
import AOCUtils (run)
import Data.List
import Data.Char
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)
import Data.Array

inputFiles1 = ["test", "12_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------
type Map2D = Array (Int, Int) Char
-- PARSING ----------------------------
lineP :: Parser String
lineP = many1 (noneOf "\n")

parseInput :: Parser Map2D
parseInput = do
    rows <- sepEndBy1 lineP newline
    let numRows = length rows
        numCols = length (head rows)
        flatList = concat rows
        bounds = ((0, 0), (numRows - 1, numCols - 1))
    return $ listArray bounds flatList
-- SOLUTION 1 -------------------------
-- solve1 farm = farm
solve1 farm = sum $ snd $ foldr step ([],[]) (assocs farm)
    where
        step c acc@(visited, fences) = if fst c `elem` visited then acc else acc'
            where
                acc' = (visited++visited', fences++[length fences'* length visited'])
                (visited', fences') = uncurry floodfill c [] farm
-- SOLUTION 2 -------------------------
solve2 input = input
-- UTILS ------------------------------
mergePairs :: [([(Int, Int)], [(Int, Int)])] -> ([(Int, Int)], [(Int, Int)])
mergePairs xs = (nub $ concatMap fst xs, concatMap snd xs)

floodfill :: (Int, Int) -> Char -> [(Int, Int)] -> Map2D -> ([(Int, Int)], [(Int, Int)])
floodfill pos@(x, y) c visited farm
    | not $ inRange (bounds farm) pos = (visited, [pos])
    | farm ! pos /= c = (visited, [pos])
    | pos `elem` visited = (visited, [])
    | otherwise = foldl visitNeighbor (visited ++ [pos], []) neighbors
  where
    neighbors = [(x + dx, y + dy) | (dx, dy) <- [(-1, 0), (1, 0), (0, -1), (0, 1)]]
    visitNeighbor (accVisited, accFailed) neighbor =
        let (newVisited, failed) = floodfill neighbor c accVisited farm
         in (newVisited, accFailed ++ failed)