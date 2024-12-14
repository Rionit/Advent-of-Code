import AOCUtils (run)
import Data.List
import Data.Char
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)
import Data.Array
import Data.Ord (comparing)

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
solve1 :: Map2D -> Int
solve1 farm = sum $ snd $ foldr step ([],[]) (assocs farm)
    where
        step c acc@(visited, fences) = if fst c `elem` visited then acc else acc'
            where
                acc' = (visited++visited', fences++[length fences' * length visited'])
                (visited', fences') = uncurry floodfill c [] farm

floodfill :: (Int, Int) -> Char -> [(Int, Int)] -> Map2D -> ([(Int, Int)], [(Int, Int)])
floodfill pos@(x, y) c visited farm
    | not $ inRange (bounds farm) pos = (visited, [pos])
    | farm ! pos /= c = (visited, [pos])
    | pos `elem` visited = (visited, [])
    | otherwise = foldl visitNeighbor (visited ++ [pos], []) neighbors
  where
    neighbors = [(x + dx, y + dy) | (dx, dy) <- [(-1, 0), (1, 0), (0, -1), (0, 1)]]
    visitNeighbor (accVisited, accFences) neighbor =
        let (newVisited, fences) = floodfill neighbor c accVisited farm
         in (newVisited, accFences ++ fences)
-- SOLUTION 2 -------------------------
solve2 farm = farm
-- Sadly didn't work for one small edge case :(
-- solve2 farm =  snd $ foldr step ([],[]) (assocs farm)
--     where
--         step c acc@(visited, fences) = if fst c `elem` visited then acc else acc'
--             where
--                 -- acc' = (visited++visited', fences++[(nub $ longs xs ++ longs ys ++ shorts, snd c)])
--                 -- acc' = (visited++visited', fences++[edges * length visited'])
--                 acc' = (visited++visited', fences++[(headsntails, snd c)])
--                 edges = sum $ map (final trips dubs quads headsntails) prep
--                 headsntails = map head prep ++ map last prep
--                 prep = nub $ longs xs ++ longs ys ++ shorts
--                 quads = duplicates fences' 4
--                 trips = duplicates fences' 3
--                 dubs = duplicates fences' 2
--                 longs xss = filter (\x -> length x > 1) xss
--                 shorts = filter (\x -> length x == 1 && x `elem` ys) xs
--                 xs = concatMap (splitX . nub) (groupBy (\a b -> fst a == fst b) $ sort fences')
--                 ys = concatMap (splitY . nub) (groupBy (\a b -> snd a == snd b) $ sortBy (comparing snd) $ sort fences')
--                 (visited', fences') = uncurry floodfill c [] farm
-- UTILS ------------------------------


-- This didn't work for one small edge case and I couldn't find a way to fix it
-- final :: [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)] -> [(Int, Int)] -> Int
-- final trips dubs quads headsntails edge
--         | head edge `elem` trips && last edge `elem` trips = 4
--         | head edge `elem` trips = 3
--         | last edge `elem` trips = 3
--         | length edge == 1 && head edge `elem` quads = 4
--         | length edge == 1 && head edge `elem` dubs = 2
--         | length edge == 1 && length (filter (`elem` headsntails) neigs) == 1 = 3
--         | otherwise = 1
--     where
--         (x, y) = head edge
--         neigs = [(x-1,y-1),(x-1,y+1),(x+1,y-1),(x+1,y+1)]

-- duplicates :: (Eq a) => [a] -> Int -> [a]
-- duplicates xs n = nub [x | x <- xs, length (filter (== x) xs) == n]

-- splitX :: [(Int, Int)] -> [[(Int, Int)]]
-- splitX [] = []
-- splitX (x:xs) = go [x] xs
--   where
--     go acc [] = [acc]
--     go acc (y:ys)
--       | snd y == snd (last acc) + 1 = go (acc ++ [y]) ys
--       | otherwise = acc : go [y] ys

-- splitY :: [(Int, Int)] -> [[(Int, Int)]]
-- splitY [] = []
-- splitY (x:xs) = go [x] xs
--   where
--     go acc [] = [acc]
--     go acc (y:ys)
--       | fst y == fst (last acc) + 1 = go (acc ++ [y]) ys
--       | otherwise = acc : go [y] ys

-- Tried completely different way, didn't work
-- floodfill2 :: (Int, Int) -> Char -> [(Int, Int)] -> Map2D -> ([(Int, Int)], [((Int, Int), Bool)])
-- floodfill2 pos@(x, y) c visited farm
--     | not $ inRange (bounds farm) pos = (visited, [(pos, corners `elem` [3, 4, 7])])
--     | farm ! pos /= c = (visited, [(pos, corners `elem` [3, 4, 7])])
--     | pos `elem` visited = (visited, [(pos, False)])
--     | otherwise = foldl visitNeighbor (visited ++ [pos], [(pos, False)]) neighbors
--   where
--     corners = length $ [(x + dx, y + dy) |
--        dx <- [-1 .. 1], dy <- [-1 .. 1], (dx, dy) /= (0, 0),
--        let pos = (x + dx, y + dy),
--        inRange (bounds farm) pos && farm ! pos == c]
--     neighbors = [(x + dx, y + dy) | (dx, dy) <- [(-1, 0), (1, 0), (0, -1), (0, 1)]]
--     visitNeighbor (accVisited, accFences) neighbor =
        -- let (newVisited, fences) = floodfill2 neighbor c accVisited farm
        --  in (newVisited, accFences ++ fences)