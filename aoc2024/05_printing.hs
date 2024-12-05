import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import qualified Data.IntMap as IntMap

inputFiles1 = ["test", "5_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES --------------

-- PARSING ----------------------------
numberP :: Parser Int
numberP = read <$> many1 digit

parseRule :: Parser (Int, Int)
parseRule = do
    x <- numberP
    char '|'
    y <- numberP
    endOfLine
    return (x,y)

parseUpdate :: Parser [Int]
parseUpdate = do
    nums <- numberP `sepBy1` char ','
    optional endOfLine
    return nums 

parseInput :: Parser ([(Int, Int)], [[Int]])
parseInput = do
    rules <- many1 parseRule
    endOfLine
    updates <- many1 parseUpdate
    return (rules, updates)

-- check (IntMap.lookup 0 rulebook)
-- SOLUTION 1 -------------------------
solve1 (rules, updates) = sum
                        $ map (\xs -> xs !! (length xs `div` 2))
                        $ map (map fst)
                        $ filter (all snd)
                        $ map (foldl step []) updates
    where
        step prev page = prev++[check (IntMap.lookup page rulebook) page (map fst prev)]
        rulebook = IntMap.fromListWith (++) [(k, [v]) | (k, v) <- rules]
-- SOLUTION 2 -------------------------
solve2 = undefined
-- UTILS ------------------------------
check :: Maybe [Int] -> Int -> [Int] -> (Int, Bool)
check (Just v) k prev | all (not) $ map (`elem` prev) v = (k, True)
                      | otherwise = (k, False)
check Nothing k _ = (k, True)

slice :: Int -> Int -> [a] -> [a]
slice from to xs = drop from $ take to xs

-- neighbours :: Int -> Int -> [String] -> [(Char, Char)]
-- neighbours x y board = extractDiagonals sliced
--     where
--         sliced = slice (y-1) (y+2) board >>= slice (x-1) (x+2)