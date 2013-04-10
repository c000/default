
mu = 4e-7 * pi

val1 = (1/2) * (sum d)
  where
    d = [ 2.9
        , 8.7 * 2
        , 7.5 * 2
        , 7.5 * 2
        , 10  * 2
        , 10  * 2
        , 8.1 * 2
        , 6.8 * 2
        , 6.7
        ]

val2 = (1/2) * (-1) * (sum d)
  where
    d = [ (-1) * 9.0
        , (-2) * 6.7
        , (-2) * 3.7
        , (-2) * 2.4
        , (-1) * 1.4
        ]

val3 = 2.5 * (-1.4) * (-1)

val4 = (1/2) * (sum d)
  where
    d = [ 52.9
        , 43.0 * 2
        , 34.0 * 2
        , 26.0 * 2
        , 19.0
        ]

val5 = 2.5 * 52.9

main = do
  putStr "1 is: "
  print val1
  putStr "2 is: "
  print val2
  putStr "3 is: "
  print val3
  putStr "4 is: "
  print val4
  putStr "5 is: "
  print val5
  putStr "Ans is:"
  print (2 * val2 + val3 + 2 * val4 + val5 + 2 * val1)
  putStr "NuI is:"
  print (100 * 5 * mu * 100 * 10000)
