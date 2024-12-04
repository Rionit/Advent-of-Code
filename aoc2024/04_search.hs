{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use head" #-}
import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.List ( transpose, tails )
import Data.Either
import Data.Maybe (catMaybes)
import Data.Foldable (traverse_)

inputFiles1 = ["test", "4_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES --------------

-- PARSING ----------------------------
xmasP :: Parser Int
xmasP = string "XMAS" >> return 1

lineP = try (Just <$> xmasP) <|> (anyChar >> return Nothing)

parseLine :: Parser String
parseLine = do
    line <- many1 letter
    optional endOfLine
    return line

parseInput :: Parser [String]
parseInput = many1 parseLine

-- SOLUTION 1 -------------------------
solve1 :: [String] -> Int
solve1 mat = sum $ catMaybes $ concat $ rights all'
    where
        all' = rows++cols++dias
        matT = transpose mat
        diagLR = diagonals
        diagRL = diagonals . map reverse
        rows = concatMap (map (parse (many1 lineP) "")) [mat, map reverse mat]
        cols = concatMap (map (parse (many1 lineP) "")) [matT, map reverse matT]
        dias = concatMap (map (parse (many1 lineP) "")) [diagLR mat, diagLR matT, diagRL mat, map reverse $ diagRL mat]

-- SOLUTION 2 -------------------------
solve2 :: [String] -> Int
solve2 mat = sum $ concat $ mapi2d check
    where
        mapi2d f = zipWith (\y -> zipWith (\x e -> f e x y mat) [0..]) [0..] mat

-- UTILS ------------------------------
diagonals :: [[a]] -> [[a]]
diagonals [] = []
diagonals [row] = map (: []) row
diagonals (row : rows) = extendDiagonals row (diagonals rows)
  where
    extendDiagonals row diags = zipWith (:) row ([] : diags) ++ drop (length row - 1) diags

check :: Char -> Int -> Int -> [String] -> Int
check 'A' x y xss | all ((==True) . checkN) (neighbours x y xss) = 1
                  | otherwise = 0
check _ _ _ _ = 0

slice :: Int -> Int -> [a] -> [a]
slice from to xs = drop from $ take to xs

extractDiagonals :: String -> [(Char, Char)]
extractDiagonals str | length str == 9 = [firstPair, secondPair]
                     | otherwise = [('x','x')]
    where
        firstPair = (str !! 0, str !! 8)
        secondPair = (str !! 2, str !! 6)

neighbours :: Int -> Int -> [String] -> [(Char, Char)]
neighbours x y board = extractDiagonals sliced
    where
        sliced = slice (y-1) (y+2) board >>= slice (x-1) (x+2)

checkN :: (Char, Char) -> Bool
checkN ('M', 'S') = True
checkN ('S', 'M') = True
checkN (_, _) = False
