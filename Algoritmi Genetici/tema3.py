import random
import sys

def read_data(input_file):
    matrix = []
    data = open(input_file, 'r')
    for line in data:
        cost_list = line.split()
        cost_list = map(int, cost_list)
        matrix.append(cost_list)
    data.close()
    return matrix

def generate_permutation(chromosome_length):
    temp = range(0, chromosome_length)
    random.shuffle(temp)
    return temp

def compute_fitness(data, chromosome, chromosome_length):
    fitness = 0

    for i in range(chromosome_length - 1):
        fitness += data[chromosome[i]][chromosome[i+1]]

    fitness += data[chromosome[chromosome_length - 1]][chromosome[0]]

    return fitness

def perm_to_repr(population, chromosome_length):

    new_population = []

    for chromosome in population:
        new_chromosome = []
        base_chromosome = range(chromosome_length)
        for gene in chromosome:
            new_chromosome.append(base_chromosome.index(gene))
            base_chromosome.remove(gene)

        new_population.append(new_chromosome)

    return new_population

def repr_to_perm(population, chromosome_length):

    new_population = []

    for chromosome in population:
        new_chromosome = []
        base_chromosome = range(chromosome_length)

        for gene in chromosome:
            new_chromosome.append(base_chromosome[gene])
            base_chromosome.pop(gene)

        new_population.append(new_chromosome)

    return new_population

def select_population(population, curr_fitness, population_size):  # elite select
    last_elite = random.randrange(0, population_size)
    new_population = []

    for i in range(last_elite):
        best = min(curr_fitness)
        best_position = curr_fitness.index(best)
        new_population.append(population[best_position])
        curr_fitness[best_position] = sys.maxint

    for i in range(last_elite, population_size):
        selected_position = random.randrange(0, population_size)
        new_population.append(population[selected_position])

    return new_population

def mutation(population, prob_mutation, chromosome_length):
    new_population = []

    for chromosome in population:
        for j in range(chromosome_length):
            prob = random.random()
            if prob < prob_mutation:
                chromosome[j] = random.randrange(chromosome_length - j)
        new_population.append(chromosome)

    return new_population

def crossover(population, prob_crossover, chromosome_length, population_size):
    new_population = []
    selected = []

    for i in range(population_size):
        prob = random.random()
        if prob < prob_crossover:
            selected.append(i)
        else:
            new_population.append(population[i])

    if len(selected) % 2 != 0:
        new_population.append(population[selected.pop()])

    while len(selected) > 0:
        random.shuffle(selected)
        father = population[selected.pop()]
        mother = population[selected.pop()]
        son1 = []
        son2 = []

        # print "Father:", father
        # print "Mother:", mother

        position = random.randrange(chromosome_length)

        # print position

        for i in range(position):
            son1.append(father[i])
            son2.append(mother[i])

        for i in range(position, chromosome_length):
            son1.append(mother[i])
            son2.append(father[i])

        # print "Son1:", son1
        # print "Son2:", son2

        new_population.append(son1)
        new_population.append(son2)

    return new_population

def genetic_tsp(population_size, max_generation, prob_mutation, prob_crossover):
    generation = 0
    data = read_data('data.txt')
    chromosome_length = len(data)
    population = []
    next_fitnesses = []
    best_chromosome = []
    minimal_cost = sys.maxint

    "Cream o populatie initiala"
    for i in range(population_size):
        population.append(generate_permutation(chromosome_length))

    "Fitness populatie initiala"
    for chromosome in population:
        next_fitnesses.append(compute_fitness(data, chromosome, chromosome_length))
        if compute_fitness(data, chromosome, chromosome_length) < minimal_cost:
            minimal_cost = compute_fitness(data, chromosome, chromosome_length)
            best_chromosome = chromosome

    while 1:
        curr_fitnesses = []

        for i in range(population_size):
            curr_fitnesses.append(next_fitnesses[i])

        generation += 1

        population = select_population(population, curr_fitnesses, population_size)

        population = perm_to_repr(population, chromosome_length)

        population = mutation(population, prob_mutation, chromosome_length)

        population = crossover(population, prob_crossover, chromosome_length, population_size)

        population = repr_to_perm(population, chromosome_length)


        for chromosome in population:
            next_fitnesses.append(compute_fitness(data, chromosome, chromosome_length))
            if compute_fitness(data, chromosome, chromosome_length) < minimal_cost:
                minimal_cost = compute_fitness(data, chromosome, chromosome_length)
                best_chromosome = chromosome


        if generation == max_generation or min(next_fitnesses) >= min(curr_fitnesses):
            break

    print ("Cel mai bun cromozom descoperit este ", best_chromosome)
    print ("Costul minim corespunzator este ", minimal_cost)

genetic_tsp(45, 1000, 0.2, 0.45)