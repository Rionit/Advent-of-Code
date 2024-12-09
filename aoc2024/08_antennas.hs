import AOCUtils (run)
import Data.List
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)

inputFiles1 = ["test", "8_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------

-- PARSING ----------------------------
getPos :: Parser (Line, Column)
getPos = do
    posI <- getPosition
    return (sourceLine posI - 1, sourceColumn posI - 1)

antennaP :: Parser (Char, (Int, Int))
antennaP = do
    many $ oneOf ".\n"
    position <- getPos
    antenna <- noneOf ".\n"
    many $ oneOf ".\n"
    return (antenna, position)

parseInput :: Parser (Int, Int, [(Char, (Int, Int))])
parseInput = do
    antennas <- many1 antennaP
    dimensions@(rows, cols) <- getPos
    return (rows, cols - 1, antennas)

-- SOLUTION 1 -------------------------
solve1 :: (Int, Int, [(Char, (Int, Int))]) -> Int
solve1 (rows, cols, antennas) = length . group . sort $ concatMap (filter bounds . antinodes) $ grouped antennas
    where
        grouped = map (map snd) . groupBy ((==) `on` fst) . sort
        bounds (x, y) = x `elem` [0 .. cols] && y `elem` [0 .. rows]
-- SOLUTION 2 -------------------------
solve2 input = input
-- UTILS ------------------------------
antinodes xs = concatMap (\((x1, y1), (x2, y2)) -> [(2*x1 - x2, 2*y1 - y2), (2*x2 - x1, 2*y2 - y1)]) pairs
  where
    pairs = [(x, y) | (x:ys) <- tails xs, y <- ys]