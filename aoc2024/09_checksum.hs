{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <&>" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import AOCUtils (run)
import Data.List
import Data.Char
import Text.Parsec
import Data.Function
import Text.Parsec.String (Parser)

inputFiles1 = ["test", "9_1"]
inputFiles2 = inputFiles1

main :: IO ()
main = do
    run inputFiles1 parseInput solve1 1
    -- run inputFiles2 parseInput solve2 2

-- DATA TYPES / CLASSES ---------------

-- PARSING ----------------------------
digitP :: Parser Int
digitP = digit >>= return . digitToInt

parseInput :: Parser [Int]
parseInput = many1 digitP

-- SOLUTION 1 -------------------------
solve1 :: [Int] -> Int
solve1 digits = compact indexed (reverse indexed) 0 0
    where
        indexed = zip [0..] digits
-- SOLUTION 2 -------------------------
-- solve2 :: [Int] -> Int
solve2 digits = files
    where
        files = [(idx, size) | (idx, size) <- reverse indexed, even idx]
        indexed = zip [0..] digits
-- UTILS ------------------------------
-- [(id for if it is odd/even, how big the block is)]
compact :: [(Int, Int)] -> [(Int, Int)] -> Int -> Int -> Int
compact ((_, 0) : rest) back idx checksum = compact rest back idx checksum
compact front ((_, 0) : rest) idx checksum = compact front rest idx checksum
compact f@((fid, fsize) : frest) b@((bid, bsize) : brest) idx checksum
    | fid == bid = foldr (\c acc -> acc + (idx + c)*(fid `div` 2)) checksum [0..min bsize fsize - 1]
    | odd bid = compact f brest idx checksum
    | odd fid = compact ((fid, fsize - 1) : frest) ((bid, bsize - 1) : brest) (idx + 1) (checksum' bid)
    | otherwise = compact ((fid, fsize - 1) : frest) b (idx + 1) (checksum' fid)
  where
    checksum' id = checksum + idx * (id `div` 2)

-- It's 1am and my brain is fried, I know what to do, but my brain doesn't want to
-- think in Haskell anymore :DD part 2 is in python :)
-- step [] _ acc = acc
-- step f@(block@(fid, fsize) : frest) files@((bid, bsize) : brest) acc
--     | even fid && notElem block files = step frest files acc
--     | even fid = step frest files acc++[(fid, fsize)]
--     | odd fid = undefined -- fit

-- fit hole@(fid, fsize) files@(file@(bid, bsize) : brest) notFitting
--     | fid == bid = notFitting++[file]
--     | bsize == fsize = 

-- test :: (Int, Int) -> [(Int, Int)] -> ([(Int, Int)], (Int, Int))
-- test (fid, fsize) [] = []
-- test (fid, fsize) (block@(bid, bsize) : brest) 
--         | fid == bid = []
--         | even bid && bsize <= fsize = 
--         | 