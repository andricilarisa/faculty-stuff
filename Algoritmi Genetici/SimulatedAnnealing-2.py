import math
import random

# functii de testat

def rast_function(parameters = []):
    nr_parameters = len(parameters)
    s = 0
    for number in parameters:
        s = s + (pow(number,2) - 10 * math.cos(2 * math.pi * number))

    return 10 * nr_parameters + s

def griew_function(parameters = []):
    nr_parameters = len(parameters)
    fr = 4000
    s = 0
    p = 1
    for number in parameters:
        s = s + pow(number,2)
    for i in range(1,len(parameters)):
        p = p * math.cos(parameters[i] / math.sqrt(i))

    return s / fr - p + 1

def six_function (parameters = []):
    for number in parameters:
        return (4 - 2.1 * pow(number, 2) + float((number ** 4)/3)) * pow(number,2) + number * number + (-4 + 4 * pow(number, 2)) * pow(number, 2)

def rosen_function (parameters = []):
    s = 0
    for i in range(len(parameters)-1):
        x = parameters[i] * parameters[i] - parameters[i+1]
        print("x-ul", x)
        s = s + 100 * pow(x, 2) + pow(parameters[i]-1, 2)
        print("s-ul", s)
    return s

# Generare numar random binar

def random_bytes_string(lungime):
    bytes=[0,1]
    rezultat=[]
    for i in range(lungime):
        rezultat.append(random.choice(bytes))
    return rezultat

# Conversie in nr. zecimal

def conversie(bytesString=[]):
    sir=""
    for i in bytesString:
        sir=sir+str(i)
    return sir

# vecini
def vecini(vector_biti= []):
    b = len(vector_biti)
    matrice = []
    for i in range(b):
        aux = []
        for j in range(b):
            aux.append(1)
        matrice.append(aux)

    for i in range(b):
        for j in range(b):
            if i == j and vector_biti[j] == 1:
                matrice[i][j] = 0
            else:
                if i == j and vector_biti[j] == 0:
                    matrice[i][j] = 1
                else:
                    matrice[i][j] = vector_biti[j]
    return matrice

# Determinare numere reale
def X_real(numar,a,b,n,precizie):
    nr_real = a + ( numar * (b-a) / (2 ** n - 1) )
    return round(nr_real,precizie)

def probabilitateAcceptare(bestVechi, bestNou, temperatura):
    if bestNou < bestVechi:
        return 1.0;
    return math.exp(-abs(bestVechi - bestNou) / temperatura)


# MAIN
def tema1 ():
    # Initializari:
    t = 0
    oprire = 0
    pas = 1

    # Citire
    a = -10 #float(input("Minim interval: "))
    b = 10 #float(input("Maxim interval: "))
    precizie = 12 #int(input("Precizie: "))

    # Reprezentarea solutiilor
    numere_in_interval = b-a
    N = numere_in_interval * 10 ** precizie
    n = math.ceil(math.log(N, 2))
    valoare_initiala = random_bytes_string(n)

    # Initializare best
    x = X_real(int(conversie(valoare_initiala),2), a, b, n, precizie)
    vector_best = [1]
    vector_best[0] = x
    best = rast_function(vector_best)
    # MAI SUS SCHIMBAM FUNCTIA
    print(best)

    #Salvam valoare minima cea mai buna impreuna cu pozitia sa
    marsBest = 10000
    marsBestPosition = 123


    # Conditii Simulated Annealing
    numar_random = random.uniform(0,1)
    temperatura = 10000
    temperaturaMinima = 1000
    conditie = pas / temperatura

    # SIMULATED ANNEALING
    while temperatura > temperaturaMinima:
        rep = 1
        while rep <= 100:
            print("Repetitia: ", t)
            # Determinare vecini
            vecini_biti = vecini(valoare_initiala)
            vecini_zecimali = [0 for x in range(n)]
            for i in range(n):
                aux = []
                for j in range(n):
                    aux.append(vecini_biti[i][j])
                    vecini_zecimali[i] = int(conversie(aux),2)

            # Calcul X
            vector_X = [0 for x in range(n+1)]
            vector_X[0] = X_real(int(conversie(valoare_initiala),2), a, b, n, precizie)
            for i in range(1, n+1):
                vector_X[i] = X_real(vecini_zecimali[i-1], a, b, n, precizie)

            # Rezultate
            lista_rezultate = []

            for number in vector_X:
                list_number = []
                list_number.append(number)
                lista_rezultate.append(rast_function(list_number))

            # MAI SUS SCHIMBAM FUNCTIA

            # Determinare solutiei minime
            print("Vecini biti: ", vecini_biti)
            print("Vecini zecimali: ", vecini_zecimali)
            print("Vector X: ", vector_X)
            print("Lista rezultate:", lista_rezultate)

            minim = min(lista_rezultate)

            #Decidem daca sa acceptam minimul (pentru variante mai slabe decat best)
            if probabilitateAcceptare(minim, best, temperatura) > random.uniform(0, 1):
                best = minim

            #salvam cea mai buna solutie
            if best < marsBest:
                #adaugare chestii care ne interesaza
                #precum: stare curenta pentru mars best... + restu
                marsBest = best
                marsBestRepetition = t

            pozitie = 0
            for i in range(n+1):
                if minim == lista_rezultate[i]:
                    pozitie = i
            print("Pozitie valoare minima: ", pozitie)

            for i in range(n):
                valoare_initiala[i] = vecini_biti[pozitie-1][i]

            # Incrementam pasul
            t = t + 1
            print("Solutie optima la repetitia ", t, " : ", best, "\n")
            pas = pas +1
            temperatura -= 10

            rep += 1
        valoare_initiala = random_bytes_string(n)
        print("Noua valoare numerica pe biti random: ",valoare_initiala)
        print("Temperatura: ", temperatura)
        print("Numar random intre 0 si 1: ", numar_random)
        conditie = pas / temperatura
        print("Valoarea conditiei: ", conditie)
        numar_random = random.uniform(0,1)
        conditie = pas / temperatura

    print(pas)

    print(marsBest)
    print(marsBestRepetition)

tema1()

