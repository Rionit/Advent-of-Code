import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.List (transpose)
import Data.Either
import Data.Maybe (catMaybes)
import Data.Foldable (traverse_)

inputFiles1 = ["test", "4_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput2 solve2 2

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
solve2 = undefined

-- UTILS ------------------------------
diagonals :: [[a]] -> [[a]]
diagonals [] = []
diagonals [row] = map (: []) row
diagonals (row : rows) = extendDiagonals row (diagonals rows)
  where
    extendDiagonals row diags = zipWith (:) row ([] : diags) ++ drop (length row - 1) diags
