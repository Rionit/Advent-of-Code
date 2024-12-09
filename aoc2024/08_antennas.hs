import AOCUtils (run)
import Data.List
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.Maybe (isJust, catMaybes, fromJust)

-- inputFiles1 = ["test", "8_1"]
inputFiles1 = ["test"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------

-- PARSING ----------------------------

parseInput :: Parser Char
parseInput = anyChar

-- SOLUTION 1 -------------------------
solve1 input = input
-- SOLUTION 2 -------------------------
-- Could optimize by using '||' only on failed results from part 1 (should be half)
-- Don't have time to implement :(
solve2 input = input
-- UTILS ------------------------------
