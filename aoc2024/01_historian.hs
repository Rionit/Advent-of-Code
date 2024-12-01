import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.List

inputFiles1 = ["1_1"]
inputFiles2 = ["1_2"]

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput solve2 2

-- PARSING ----------------------------
separatePairs :: [(Int, Int)] -> ([Int], [Int])
separatePairs pairs = (map fst pairs, map snd pairs)

parseInt :: Parser Int
parseInt = read <$> many1 digit

parseLine :: Parser (Int, Int)
parseLine = do
    left <- parseInt
    space
    space
    space
    right <- parseInt
    optional endOfLine
    return (left, right)

parseInput :: Parser ([Int], [Int])
parseInput = do
    pairs <- many1 parseLine
    return (separatePairs pairs)

-- SOLUTION 1 -------------------------
solve1 :: ([Int], [Int]) -> Int
solve1 (left, right) = sum [abs (l - r) | (l, r) <- zip (sort left) (sort right)]

-- SOLUTION 2 -------------------------
solve2 :: ([Int], [Int]) -> Int
solve2 (left, right) = sum [ l | l <- left, r <- right, l==r]

-- UTILS -------------------------
