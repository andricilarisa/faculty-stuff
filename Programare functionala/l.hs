data Zi = Luni | Marti | Miercuri | Joi | Vineri | Sambata | Duminica deriving Eq

instance Eq Zi where
(==) Luni Luni = True
(==) Marti Marti = True
(==) Miercuri Miercuri = True
(==) Joi Joi = True
(==) Vineri Vineri = True
(==) Sambata Sambata = True
(==) Duminica Duminica = True
(==) Luni Marti = False
(==) Luni Miercuri = False
(/=) Luni Luni = True 

suma x y = x + y