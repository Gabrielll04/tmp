with open("actors.csv") as file:
    lines = file.readlines()

actors = []
for i in range(1, len(lines)):
    columns = lines[i].split(",")

    if len(columns) > 6: # implement this with for, sorry for the gambiarra
        columns[0] = f"{columns[0]} {columns[1]}"
        columns[1] = columns[2]
        columns[2] = columns[3]
        columns[4] = columns[5]
        columns[5] = columns[6]
        columns[6] = None

    actor = {
        "name": columns[0],
        "total_gross": columns[1],
        "number_of_movies": columns[2].strip(),
        "average_per_movie": columns[3],
        "#1_movie": columns[4],
        "gross": float(columns[5])
    }
    actors.append(actor)

with open("etapa-1.txt", "w") as etapa1:
    actor_most_films = max(actors, key=lambda actor: actor["number_of_movies"]) # functional programming in python is pretty bad
    etapa1.write(f"{actor_most_films['name']}, {actor_most_films['number_of_movies']}")

with open("etapa-2.txt", "w") as etapa2:
    gross_media = 0
    gross_media = sum(p["gross"] for p in actors) / len(actors) # thanks haskell for teaching me list comprehension
    etapa2.write(str(gross_media))

with open("etapa-3.txt", "w") as etapa3:
    actor_highest_average_gross = max(actors, key=lambda actor: actor["average_per_movie"])
    etapa3.write(f"{actor_highest_average_gross['name']}, {actor_highest_average_gross['average_per_movie']}")

with open("etapa-4.txt", "w") as etapa3:
    counter_movies = {}

    for actor in actors:
        if actor["#1_movie"] in counter_movies:
            counter_movies[actor["#1_movie"]] += 1
        else:
            counter_movies[actor["#1_movie"]] = 1
    films_occurrences = [(film, count) for film, count in counter_movies.items()]
    films_occurrences.sort(reverse=True, key=lambda x: x[1])

    for i, f in enumerate(films_occurrences):
        etapa3.write(f"{i} - O filme {f[0]} aparece {f[1]} vez(es) no dataset\n")

with open("etapa-5", "w") as etapa5:
    name = actor["name"]
    total_gross = actor["total_gross"]

    actor_dict = {"name": name, "total_gross": total_gross}

    actors_gross.append(actor_dict)
    for i, actor in enumerate(actors):
        actors_gross[i] = [(name, total_gross) for name, total_gross in {"name": actor["name"], "total_gross": actor["total_gross"]}.items()]

'''
for i, p in enumerate(actors):
    print(f"{i} - {p['name']}, {p['total_gross']}, {p['number_of_movies']}")
