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
    run inputFiles2 parseInput solve2 2

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
solve1 input = sum $ map (\(test, xs) -> eval [head xs] (tail xs) test "*+") input
-- SOLUTION 2 -------------------------
-- Could optimize by using '||' only on failed results from part 1 (should be half)
-- Don't have time to implement :(
solve2 input = sum $ map (\(test, xs) -> eval [head xs] (tail xs) test "*+|") input
-- UTILS ------------------------------
op :: Int -> Char -> Int -> Int
op x '*' y = x * y
op x '+' y = x + y
op x '|' y = x `join` y

join :: Int -> Int -> Int
join x y = read ((show x) ++ (show y))

eval :: [Int] -> [Int] -> Int -> String -> Int
eval [] _ test _ = 0
eval xs [] test _ = if any (== test) xs then test else 0
eval xs (y:ys) test ops = eval [result | x <- xs, o <- ops, let result = op x o y, result <= test] ys test ops
