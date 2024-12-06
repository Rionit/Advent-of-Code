import AOCUtils (run)
import Data.List
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.Maybe (isJust, catMaybes, fromJust)

inputFiles1 = ["test", "6_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES --------------
data Player = Player Int Int Char deriving (Show)

-- PARSING ----------------------------

parseInput :: Parser String
parseInput = many1 anyChar

-- SOLUTION 1 -------------------------
solve1 input = length $ group $ sort $ eval player board [pos player]
    where
        player = findPlayer board
        board = lines input
        
-- SOLUTION 2 -------------------------
solve2 = undefined
-- UTILS ------------------------------
escaped (0, _) _ = True
escaped (_, 0) _ = True
escaped (x, y) board | y >= (length board) - 1 = True
                     | x >= (length $ head board) - 1 = True
                     | otherwise = False

field (x, y) board = (board !! y) !! x

move (Player x y dir@'^') = (Player x (y-1) dir)
move (Player x y dir@'v') = (Player x (y+1) dir)
move (Player x y dir@'>') = (Player (x+1) y dir)
move (Player x y dir@'<') = (Player (x-1) y dir)

rot (Player x y '^') = (Player x y '>')
rot (Player x y '>') = (Player x y 'v')
rot (Player x y 'v') = (Player x y '<')
rot (Player x y '<') = (Player x y '^')

pos (Player x y _) = (x, y)

eval :: Player -> [String] -> [(Int, Int)] -> [(Int, Int)]
eval player board path | escaped (pos player) board = path
                       | field pos' board /= '#' = eval (move player) board [pos']++path
                       | field pos' board == '#' = eval (rot player) board path
    where
        pos' = pos $ move player

findPlayer :: [String] -> Player
findPlayer board = Player x y '^'
    where
        x = head $ catMaybes maybes
        y = fromJust $ findIndex isJust maybes
        maybes = map (elemIndex '^') board