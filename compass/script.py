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
        "gross": columns[5]
    }
    actors.append(actor)

with open("etapa_1.txt", "w") as etapa1:
    actor_most_films = max(actors, key=lambda actor: actor["number_of_movies"])
    etapa1.write(f"{actor_most_films['name']}, {actor_most_films['number_of_movies']}")



'''
for i, p in enumerate(actors):
    print(f"{i} - {p['name']}, {p['total_gross']}, {p['number_of_movies']}")
'''
