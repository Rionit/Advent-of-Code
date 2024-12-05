import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import qualified Data.IntMap as IntMap

inputFiles1 = ["test", "5_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput solve2 2

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
solve2 (rules, updates) = sum
                        $ map (\xs -> xs !! (length xs `div` 2))
                        $ map (map fst)
                        $ map (foldl step2 [])
                        $ filter (not . all snd)
                        $ map (foldl step1 []) updates
    where
        step2 prev page@(k, state) | state == True = prev++[page]
                                   | otherwise = fix prev page rulebook
        step1 prev page = prev++[check (IntMap.lookup page rulebook) page (map fst prev)]
        rulebook = IntMap.fromListWith (++) [(k, [v]) | (k, v) <- rules]
-- UTILS ------------------------------

fix :: [(Int, Bool)] -> (Int, Bool) -> IntMap.IntMap [Int] -> [(Int, Bool)]
fix prev page@(k, state) r | state' == True = prev'++[page']++[last prev]
                           | otherwise = (fix prev' page r)++[last prev]
    where
        page'@(k', state') = check (IntMap.lookup k r) k (map fst prev')
        prev' = init prev

check :: Maybe [Int] -> Int -> [Int] -> (Int, Bool)
check (Just v) k prev | all (not) $ map (`elem` prev) v = (k, True)
                      | otherwise = (k, False)
check Nothing k _ = (k, True)
