import AOCUtils (run)
import Text.Parsec
import Text.Parsec.String (Parser)
import Data.Char
import Data.Maybe (catMaybes)

inputFiles1 = ["test", "3_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    run inputFiles2 parseInput2 solve2 2

-- DATA TYPES / CLASSES --------------
data Instr = Mul Int Int | Do | Dont deriving (Show, Eq)

-- PARSING ----------------------------
-- parseInput :: Parser String
-- parseInput = many anyChar

numberP :: Parser Int
numberP = read <$> many1 digit

parseMul = do
    string "mul("
    x <- numberP
    char ','
    y <- numberP
    char ')'
    return (x,y)

mulOrCharP = try (Just <$> parseMul) <|> (anyChar >> return Nothing)

parseInput = do
    maybePairs <- many mulOrCharP
    return $ catMaybes maybePairs

parseDo = string "do()" >> return Do
parseDont = string "don't()" >> return Dont

try' instr = try (Just <$> instr)

instrP = try' (uncurry Mul <$> parseMul) <|> try' parseDo <|> try' parseDont <|> (anyChar >> return Nothing)

parseInput2 = catMaybes <$> many instrP

-- SOLUTION 1 -------------------------
solve1 :: [(Int, Int)] -> Int
solve1 = foldr (\c acc -> acc + uncurry (*) c) 0
-- SOLUTION 2 -------------------------
solve2 :: [Instr] -> Int
solve2 = snd . foldl eval (True, 0)

eval :: (Bool, Int) -> Instr -> (Bool, Int)
eval (_, sum) Do = (True, sum)
eval (_, sum) Dont = (False, sum)
eval (False, sum) (Mul _ _) = (False, sum)
eval (True, sum) (Mul x y) = (True, sum + (x * y))

-- NOT WORKING SOLUTION ---------------
-- Doesn't work for some edge cases
-- scan :: String -> [String] -> String -> [String]
-- scan [] res curr = res
-- scan ('m':'u':'l':'(':xs) res _ = scan xs res "mul("
-- scan (c:xs) res curr
--     | null curr = scan xs res ""
--     | '(' == last curr && isDigit c = scan xs res (curr ++ [c])
--     | ',' == last curr && isDigit c = scan xs res (curr ++ [c])
--     | isDigit (last curr) && isDigit c = scan xs res (curr ++ [c])
--     | c == ',' && isDigit (last curr) = scan xs res (curr ++ [c])
--     | c == ')' && isDigit (last curr) = scan xs (res ++ [curr ++ [c]]) ""
--     | otherwise = scan xs res ""

-- split' :: (Char -> Bool) -> String -> [String]
-- split' p s =  case dropWhile p s of
--                       "" -> []
--                       s' -> w : split' p s''
--                             where (w, s'') = break p s'

-- extract :: String -> [Int]
-- extract xs = map read $ concatMap (split' (==',')) $ rmBrackets $ rmMul xs
--     where
--         rmBrackets xs = split' (=='(') $ concat $ split' (==')') xs
--         rmMul = filter (not . (`elem` "mul"))

-- mul :: [Int] -> Int
-- mul [] = 0                    
-- mul [x] = x 
-- mul (x:y:xs) = (x * y) + mul xs 

-- solve1 :: String -> Int
-- solve1 input = mul $ extract $ concat $ scan input [""] ""