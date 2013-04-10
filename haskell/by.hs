
mu = 4e-7 * pi

n = 100
r = 0.054
i = 5

calc :: Double -> Double
calc y = (mu / 2) * (1 / (r**2 + y**2)**(3/2)) * r**2 * n * i

tTog = (*) 10000

main = do
  contents <- getContents
  mapM_ (print.tTog.calc.read) $ words contents
