suma n = if n==1 then 1 else 
         if n `mod` 2 == 1 then n + suma (n-1) 
         else suma (n-1)