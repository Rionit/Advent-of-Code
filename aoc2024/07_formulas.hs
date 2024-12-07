import AOCUtils (run)
import Data.List
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.Maybe (isJust, catMaybes, fromJust)

inputFiles1 = ["test", "7_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------

-- PARSING ----------------------------
numberP :: Parser Int
numberP = read <$> many1 digit

parseLine :: Parser (Int, [Int])
parseLine = do
    test <- numberP
    string ": "
    nums <- numberP `sepBy1` char ' '
    optional endOfLine
    return (test, nums)

parseInput :: Parser [(Int, [Int])]
parseInput = many1 parseLine

-- SOLUTION 1 -------------------------
solve1 input = sum $ map (\(test, xs) -> eval [head xs] (tail xs) test) input
        
-- SOLUTION 2 -------------------------
solve2 input = input
-- UTILS ------------------------------
op :: Int -> Char -> Int -> Int
op x '*' y = x * y
op x '+' y = x + y

eval :: [Int] -> [Int] -> Int -> Int
eval [] _ test = 0
eval xs [] test = if any (== test) xs then test else 0
eval xs (y:ys) test = eval [result | x <- xs, o <- "*+", let result = op x o y, result <= test] ys test