import math
import random

# functii de testat
def rast_function(parameters = []):
    nr_parameters = len(parameters)
    s = 0
    for number in parameters:
        s = s + (pow(number,2) - 10 * math.cos(2 * math.pi * number))

    return 10 * nr_parameters + s
def griew_function(valori_individ = []):
    fr = 4000
    s = 0
    p = 1
    for number in valori_individ:
        s = s + pow(number,2)
    for i in range(1, len(valori_individ)):
        p = p * math.cos(valori_individ[i] / math.sqrt(i))
    return s / fr - p + 1

def six_function (parameters = []):
    for number in parameters:
        return (4 - 2.1 * pow(number, 2) + float((number ** 4)/3)) * pow(number,2) + number * number + (-4 + 4 * pow(number, 2)) * pow(number, 2)

def rosen_function (parameters = []):
    s = 0
    for i in range(len(parameters)-1):
        x = parameters[i] * parameters[i] - parameters[i+1]
        #print("x-ul", x)
        s = s + 100 * pow(x, 2) + pow(parameters[i]-1, 2)
        #print("s-ul", s)
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
        sir = sir + str(i)
    return sir

# Determinare numere reale
def X_real(numar, a, b, n, precizie):
    nr_real = a + (numar * (b-a) / (2 ** n - 1))
    return round(nr_real,precizie)

#............NEW STUFF.............
# Valori individ function
def valori_individ_function(pozitie_individ, nr_valori_individ ,parameters = []):
    valori_individ = []
    for i in range(nr_valori_individ):
        valori_individ.append(parameters[pozitie_individ*nr_valori_individ+i])
    return valori_individ

# Functia pentru mutatie
def mutatie (generatie= []):
    for i in range(len(generatie)):
        for j in range(len(generatie[i])):
            sansa_mutatie = random.uniform(0, 1)
            # AICI SCHIMBAM SANSA MUTATIEI
            if(sansa_mutatie < 0.3):
                if generatie[i][j] == 0:
                    generatie[i][j] = 1
                else:
                    generatie[i][j] = 0
    return generatie

# Functia pentru incrucisare
def incrucisare (nr_biti, generatie = []):
    dublura_al_doilea_individ = []
    dublura_primul_individ = []

    for i in range(len(generatie)):
        sansa_incrucisare = random.uniform(0, 1)
        print("Sansa incrucisare: ", sansa_incrucisare)
        # AICI SCHIMBAM SANSA DE INCRUCISARE
        if(sansa_incrucisare < 0.3):
            primul_individ = generatie[i]
            print("Primul individ", primul_individ)

            pozitie_al_doilea_individ = random.randint(0, len(generatie)-1)
            print("Pozitie al doilea individ: ", pozitie_al_doilea_individ)
            al_doilea_individ = generatie[pozitie_al_doilea_individ]
            print("Al doile individ", al_doilea_individ)

            pozitie_de_incrucisare = random.randint(0, nr_biti)
            print("Pozitie incrucisare", pozitie_de_incrucisare)

            for j in range(pozitie_de_incrucisare):
                dublura_primul_individ.append(primul_individ[j])
                dublura_al_doilea_individ.append(al_doilea_individ[j])
            print(dublura_primul_individ)
            print(dublura_al_doilea_individ)
            for j in range(pozitie_de_incrucisare, len(generatie[i])):
                dublura_primul_individ.append(al_doilea_individ[j])
                dublura_al_doilea_individ.append(primul_individ[j])
            print(dublura_primul_individ)
            print(dublura_al_doilea_individ)
            generatie[i] = dublura_primul_individ
            generatie[pozitie_al_doilea_individ] = dublura_al_doilea_individ

            # Resetam listele
            dublura_primul_individ = []
            dublura_al_doilea_individ = []
    return generatie


# MAIN
def main():
    # Declarari si initializari
    generatie_initiala_biti = []
    generatie_initiala_valori_reale = []
    generatie_noua_biti = []
    rezultate = []
    rezultate_inversate = []
    probabilitate_individ = []
    total_fitness = 0
    total_fitness_nou = 0
    q = []
    best = 10000

    # Citire
    a = -5 # float(input("Minim interval: "))
    b = 5 # float(input("Maxim interval: "))
    precizie = 2 # int(input("Precizie: "))
    nr_valori_individ = 4
    populatie = 4
    nr_repetitii = 400

    # Reprezentarea solutiilor
    numere_in_interval = b-a
    N_subintervale = numere_in_interval * 10 ** precizie
    n_biti = math.ceil(math.log(N_subintervale, 2))
    for i in range(nr_valori_individ*populatie):
        vector_biti = random_bytes_string(n_biti)
        generatie_initiala_biti.append(vector_biti)
        print("Individul", i, ":", generatie_initiala_biti[i], "\n")

    for rep in range(nr_repetitii):
        # Transformare numere reale
        for i in range(nr_valori_individ*populatie):
            numar_real = X_real(int(conversie(generatie_initiala_biti[i]), 2), a, b, n_biti, precizie)
            generatie_initiala_valori_reale.append(numar_real)
            print("Individul", i, "(val. reale):", generatie_initiala_valori_reale[i])

        # ROATA NOROCULUI
        # Se calculeaza fitnesul fiecarui individ
        for j in range(populatie):
            valori_individ = valori_individ_function(j, nr_valori_individ, generatie_initiala_valori_reale)
            # AICI SCHIMBAM FUNCTIA FOLOSITA
            rezultate.append(six_function(valori_individ))
        print("Rezultate: ", rezultate)

        # Se calculeaza fitnesul total
        for number in rezultate:
            total_fitness = total_fitness + number
        print("Fitnessul total: ", total_fitness)

        # f(x) = g(x) + C (maximizarea a unei functii care nu este pozitiva)
        for j in range(populatie):
            rezultate_inversate.append(total_fitness + rezultate[j])
        print("Rezultate inversate:", rezultate_inversate)
        for number in rezultate_inversate:
            total_fitness_nou = total_fitness_nou + number
        print("Fitness total nou:", total_fitness_nou)

        # Se calculeaza probabilitatile de selectie individuale
        for i in range(populatie):
            probabilitate_individ.append(rezultate_inversate[i]/total_fitness_nou)
            print("Prob. individ", i, ":", probabilitate_individ[i])

        # Se calculeaza probabilitatile de selectie cumulate
        q.append(0)
        for i in range(populatie):
            q.append(q[i] + probabilitate_individ[i])
        print(q)

        # Selectia
        for i in range(populatie):
            numar_random = random.uniform(0, 1)
            # Cautam intervalul unde se afla numarul random
            for j in range(populatie):
                if q[j] < numar_random and q[j+1] >= numar_random:
                    # Atribuim la noua generatie valorile corespunzatoare
                    for k in range(nr_valori_individ):
                        generatie_noua_biti.append(generatie_initiala_biti[j*nr_valori_individ+k])

        print("Generatie noua: ", generatie_noua_biti)
        generatie_noua_biti = mutatie(generatie_noua_biti)
        print("Gener. mutatie: ", generatie_noua_biti)

        generatie_noua_biti = incrucisare(n_biti, generatie_noua_biti)
        print("Generatie noua dupa incrucisare: ", generatie_noua_biti)

        minim = min(rezultate)
        if minim < best:
            best = minim
        print("Best: %.50f" % best)

        # Adaugam noua generatie pentru urmatoarea repetitie
        generatie_initiala_biti = generatie_noua_biti

        # Re-initializari
        nr_repetitii += 1
        generatie_initiala_valori_reale = []
        generatie_noua_biti = []
        rezultate = []
        rezultate_inversate = []
        probabilitate_individ = []
        total_fitness = 0
        total_fitness_nou = 0
        q = []

    return 0

main()
