--cmmdc
cmmdc a b = if (a `mod` b /=0) then (cmmdc b (a `mod` b)) else b