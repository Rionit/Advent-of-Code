import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.List

inputFiles1 = ["test", "2_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseReports solve1 1
    run inputFiles2 parseReports solve2 2

-- PARSING ----------------------------
parseLevel :: Parser Int
parseLevel = read <$> many1 digit

parseReport :: Parser [Int]
parseReport = do
    levels <- sepBy1 parseLevel $ char ' '
    optional endOfLine
    return levels

parseReports :: Parser [[Int]]
parseReports = do
    many1 parseReport

-- SOLUTION 1 -------------------------

result :: (Int, Bool, Bool) -> Int
result (_, True, True) = 1
result _ = 0

-- This is so messy :DD I committed to using just one foldr, so that's why the -1 check
step :: Int -> (Int, Bool, Bool) -> (Int, Bool, Bool)
step curr (prev, dist, inc) = (curr, dist && abs (curr - prev) `elem` [1..3] || prev == -1, inc && curr > prev || prev == -1)

check :: [Int] -> Int
check report = if sum (map f [report, reverse report]) > 0 then 1 else 0
    where
        f = result . foldr step (-1, True, True)

checkVariations :: [Int] -> Int
checkVariations report = if sum (map check vars) > 0 then 1 else 0
    where
        vars = [take i report ++ drop (i + 1) report | i <- [0 .. length report - 1]]

solve1 :: [[Int]] -> Int
solve1 reports = sum $ map check reports

-- SOLUTION 2 -------------------------
solve2 :: [[Int]] -> Int
solve2 reports = sum $ map checkVariations reports

-- UTILS -------------------------
