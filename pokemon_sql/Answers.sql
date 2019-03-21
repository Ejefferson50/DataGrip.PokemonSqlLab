-- What are all the types of pokemon that a pokemon can have?
SELECT name
FROM Pokemon.types;

-- What is the name of the pokemon with id 45?
SELECT name
FROM Pokemon.pokemons
WHERE id = 45;

-- How many pokemon are there?
SELECT COUNT(*)
FROM Pokemon.pokemons;

-- How many types are there?
SELECT COUNT(*)
FROM Pokemon.types;

-- How many pokemon have a secondary type?
SELECT COUNT(Pokemon.pokemons.secondary_type)
FROM Pokemon.pokemons;

# What is each pokemon's primary type?
SELECT p.name, t.name
FROM Pokemon.pokemons p
       INNER JOIN Pokemon.types t
                  ON t.id = p.primary_type;

# What is Rufflet's secondary type?
SELECT t.name AS 'Secondary Type'
FROM Pokemon.types t
       INNER JOIN Pokemon.pokemons p
                  ON t.id = p.secondary_type
WHERE p.name = 'Rufflet';

# What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT name AS 'Pokemon Belonging To Trainer 303'
FROM Pokemon.pokemons p
       INNER JOIN Pokemon.pokemon_trainer pt
                  ON p.id = pt.pokemon_id
WHERE pt.trainerID = 303;

# How many pokemon have a secondary type Poison?
SELECT COUNT(secondary_type) AS 'Number Of Poison Pokemon'
FROM Pokemon.pokemons p
       INNER JOIN Pokemon.types t
                  ON p.secondary_type = t.id
WHERE t.name = 'Poison';

# What are all the primary types and how many pokemon have that type?
SELECT t.name AS 'Primary Types', COUNT(p.primary_type) AS 'Pokemon With Type As Primary'
FROM Pokemon.pokemons p
       INNER JOIN Pokemon.types t
                  ON p.primary_type = t.id
GROUP BY t.name;

# How many pokemon at level 100 does each trainer with at least one level 100 pokemon have? (Hint: your query should not display a trainer
SELECT pt.trainerID, COUNT(pokelevel)
FROM Pokemon.pokemon_trainer pt
WHERE pokelevel = 100
GROUP BY pt.trainerID;

# How many pokemon only belong to one trainer and no other?
SELECT COUNT(*)
FROM (
       SELECT COUNT(pokemon_id)
       FROM Pokemon.pokemon_trainer pt
       GROUP BY pokemon_id
       HAVING COUNT(*) = 1) as d;

# Final Report
#Below shows my query for Cooltrainer♀ Moden. She is my choice for strongest pokemon trainer.
#She has all level 100 pokemon, 2 of which are legendary steel
# type pokemon(list shows for but think that is due to data
#entry error as each trainer can only carry a team of 6). I originally had the list
#sorted by pokemon level descending and while doing so I seen that Moden had 2 legendary
#Steel types and steel type pokemon have the strongest defense as there are
#10 different types that are not very effective against them. From there I grabbed
#only Moden's pokemon to see the rest of her team and realized her types have a pretty decent
#balance. For example, Steel is actually weak against Fire but Moden also has a Water
#type in Milotic which is strong against Fire. Below Moden's query I included the shorted
#Trainer list from pokemon lvl 100 to lvl 1.

#Moden's Query
SELECT tr.trainername AS 'Trainer Name',
       p.name         AS 'Pokemon Name',
       pt.pokelevel   AS 'Pokemon Level',
       types1.name    AS 'Primary Type',
       types2.name    AS 'Secondary Type'
FROM Pokemon.pokemon_trainer pt
       LEFT OUTER JOIN Pokemon.trainers tr
                       ON pt.trainerID = tr.trainerID
       LEFT OUTER JOIN Pokemon.pokemons p
                       ON pt.pokemon_id = p.id
       LEFT OUTER JOIN Pokemon.types AS types1
                       ON types1.id = p.primary_type
       LEFT OUTER JOIN Pokemon.types AS types2
                       ON types2.id = p.secondary_type
WHERE tr.trainername = 'Cooltrainer♀ Moden'
ORDER BY pt.pokelevel DESC ;


#Trainer Sort
SELECT tr.trainername AS 'Trainer Name',
       p.name         AS 'Pokemon Name',
       pt.pokelevel   AS 'Pokemon Level',
       types1.name    AS 'Primary Type',
       types2.name    AS 'Secondary Type'
FROM Pokemon.pokemon_trainer pt
       LEFT OUTER JOIN Pokemon.trainers tr
                       ON pt.trainerID = tr.trainerID
       LEFT OUTER JOIN Pokemon.pokemons p
                       ON pt.pokemon_id = p.id
       LEFT OUTER JOIN Pokemon.types AS types1
                       ON types1.id = p.primary_type
       LEFT OUTER JOIN Pokemon.types AS types2
                       ON types2.id = p.secondary_type
ORDER BY pt.pokelevel DESC ;







