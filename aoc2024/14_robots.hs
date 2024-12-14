import AOCUtils (run)
import Data.List
import Data.Char
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)
import Data.Ord

-- inputFiles1 = ["test", "14_1"]
inputFiles1 = ["14_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES --------------
type Position = (Int, Int)
type Velocity = (Int, Int)
data Robot = Robot Position Velocity deriving (Show, Eq, Ord)

-- PARSING ----------------------------
bounds :: Position
bounds = (101, 103) -- 14_1

numberP :: Parser Int
numberP = do
    sign <- option "" (string "-")
    digits <- many1 digit
    return $ read (sign ++ digits)

parseLine :: Parser Robot
parseLine = do
    string "p="
    x <- numberP
    char ','
    y <- numberP
    string " v="
    dx <- numberP
    char ','
    dy <- numberP
    optional endOfLine
    return (Robot (x, y) (dx, dy))

parseInput :: Parser [Robot]
parseInput = many1 parseLine

-- SOLUTION 1 -------------------------
solve1 :: [Robot] -> Int
solve1 robots = product $ map length $ quadrants $ sort $ foldr (\i acc -> map move acc) robots [1..100]
    where
        quadrants xs = [filter (\(Robot (x, y) (_, _)) -> x < midX && y < midY) xs,
                        filter (\(Robot (x, y) (_, _)) -> x > midX && y < midY) xs,
                        filter (\(Robot (x, y) (_, _)) -> x < midX && y > midY) xs,
                        filter (\(Robot (x, y) (_, _)) -> x > midX && y > midY) xs]
        midX = div (fst bounds - 1) 2
        midY = div (snd bounds - 1) 2

-- SOLUTION 2 -------------------------
solve2 robots = robots
-- UTILS ------------------------------
wrap :: Position -> Position
wrap (x, y) = (x `mod` fst bounds, y `mod` snd bounds)

inBounds :: Position -> Bool
inBounds (x, y) | x >= fst bounds || y >= snd bounds || x < 0 || y < 0 = False
                | otherwise = True

move :: Robot -> Robot
move (Robot pos@(x, y) velocity@(dx, dy))
    | inBounds pos' = Robot pos' velocity
    | otherwise = Robot (wrap pos') velocity
    where pos' = (x + dx, y + dy)
