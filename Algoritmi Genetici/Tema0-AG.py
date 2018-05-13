import math
import random
import time

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

def rosen_function (parameters = []):
    print(parameters)
    s = 0
    for i in range(len(parameters)-1):
        x = parameters[i] * parameters[i] - parameters[i+1]
        s = s + 100 * pow(x, 2) + pow(parameters[i]-1, 2)
    return s


def tema0 ():
    n = int(input("Introduceti nr. de parametri: "))
    a = float(input("Minim interval: "))
    b = float(input("Maxim interval: "))
    numar_rulari = 100000
    lista_rezultate = []
    start_time = time.time()

    for repetitie in range(numar_rulari):
        parameters = []
        for number in range(n):
            parameters.append(random.uniform(a, b))
        lista_rezultate.append(rast_function(parameters))
        # Mai sus schimbam functia folosita.

    print("Cea mai buna solutie: ", min(lista_rezultate))
    print("Cea mai rea solutie: ", max(lista_rezultate))
    print("Timp rulare: ", time.time()-start_time)
    print("media solutiilor: ", sum(lista_rezultate)/float(numar_rulari))

tema0()

