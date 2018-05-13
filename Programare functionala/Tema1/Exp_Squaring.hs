exp_squaring x n = if n<0 then exp_squaring (1/x) (-n) else
                   if n==0 then 1 else
                   if (n==1) then x else
                   if n `mod` 2 == 0 then exp_squaring (x*x) (n/2) else
                   if n `mod` 2 == 1 then exp_squaring x*x ((n-1)/2) else