import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.Char 

inputFiles1 = ["test", "3_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- PARSING ----------------------------
parseInput :: Parser String
parseInput = many anyChar

-- SOLUTION 1 -------------------------
scan :: String -> [String] -> String -> [String]
scan [] res curr = res
scan ('m':'u':'l':'(':xs) res _ = scan xs res "mul("
scan (c:xs) res curr
    | null curr = scan xs res ""
    | '(' == last curr && isDigit c = scan xs res (curr ++ [c])
    | ',' == last curr && isDigit c = scan xs res (curr ++ [c])
    | isDigit (last curr) && isDigit c = scan xs res (curr ++ [c])
    | c == ',' && isDigit (last curr) = scan xs res (curr ++ [c])
    | c == ')' && isDigit (last curr) = scan xs (res ++ [curr ++ [c]]) ""
    | otherwise = scan xs res ""

split' :: (Char -> Bool) -> String -> [String]
split' p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : split' p s''
                            where (w, s'') = break p s'

extract :: String -> [Int]
extract xs = map read $ concatMap (split' (==',')) $ rmBrackets $ rmMul xs
    where 
        rmBrackets xs = split' (=='(') $ concat $ split' (==')') xs
        rmMul = filter (not . (`elem` "mul"))

mul :: [Int] -> Int
mul [] = 0                    
mul [x] = x 
mul (x:y:xs) = (x * y) + mul xs 

-- solve1 :: String -> Int
solve1 input = mul $ extract $ concat $ scan input [""] ""
-- SOLUTION 2 -------------------------
-- solve2 :: [[Int]] -> Int

-- UTILS -------------------------
