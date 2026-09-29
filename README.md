PROMT UTILISÉ:  
Tu travailles dans le domaine de l’aviation. Ton entreprise a comme activité de transporter des personnes en avion d’un aéroport à un autre. C’est une compagnie aérienne comme Air France, Latam Airlines ou Fly Emirates. On veut collecter des données comme le numéro d’avion, numéro du vol, modèle de l’avion, nombre de passagers, aéroport de départ et d’arrivée, nom des pilotes, date et heure de départ et d’arrivée à l’heure local, temps de vol, etc… Inspire-toi des sites web des compagnies aérienne Air France, Latam Airlines et Fly Emirates.

Ta compagnie aérienne veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données. 

D’abord, établis les règles de gestions des données de ta compagnie, sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information.

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
Fournis donc les règles de gestion et le dictionnaire de données.

Réponse de Claude (IA):
# Analyse des besoins : compagnie aérienne (démarche MERISE)

## Partie 1 : Règles de gestion

**Flotte et avions**
- Notre compagnie possède une flotte d'avions. Chaque avion est identifié par son immatriculation (par exemple F-GKXA), qui ne change jamais tant qu'il est dans la compagnie.
- Chaque avion appartient à un seul modèle (par exemple Airbus A350-900 ou Boeing 777-300ER). Un même modèle est utilisé par plusieurs avions de la flotte.
- Pour chaque modèle, on connaît son nom et son nombre total de sièges.
- Un avion a un état à tout moment : en service, en maintenance ou retiré.

**Aéroports**
- Nous desservons des aéroports dans le monde entier. Chaque aéroport est identifié par son code à trois lettres (CDG, GRU, DXB).
- Pour chaque aéroport, on connaît le nom, la ville, le pays et le fuseau horaire, car toutes les heures affichées aux passagers sont des heures locales.

**Vols et programmation**
- Un vol est une liaison commerciale régulière, identifiée par un numéro de vol (par exemple AF218). Il relie un aéroport de départ à un aéroport d'arrivée, toujours les mêmes.
- Un même numéro de vol est exploité plusieurs jours ou plusieurs fois par semaine. Chaque exploitation à une date donnée est une « opération de vol ». C'est elle qui est effectuée concrètement, avec un avion, un équipage et des passagers.
- Pour chaque opération de vol, on enregistre la date et l'heure de départ et d'arrivée prévues, puis les heures réelles une fois le vol effectué. Toutes ces heures sont en heure locale de l'aéroport concerné.
- Une fois le vol terminé, on conserve sa durée de vol, calculée en tenant compte des fuseaux horaires.
- Chaque opération de vol est effectuée par un seul avion. Un avion enchaîne plusieurs opérations dans le temps, mais jamais deux en même temps.
- Une opération de vol a un statut : programmé, embarquement, en vol, arrivé, retardé ou annulé. En cas de retard ou d'annulation, on note le motif.
- On veut connaître, pour chaque opération de vol, le nombre de passagers embarqués. Il ne peut pas dépasser le nombre de sièges du modèle de l'avion.

**Équipage**
- Chaque opération de vol est assurée par un équipage : au minimum un commandant de bord et un copilote, plus le personnel de cabine.
- Chaque membre d'équipage (pilote ou personnel de cabine) est identifié par un matricule. On connaît son nom, son prénom et sa fonction (commandant, copilote, cabine).
- Les pilotes ont en plus un numéro de licence. Chaque pilote est qualifié sur un ou plusieurs modèles d'avion et ne peut piloter que ceux-là.
- Un membre d'équipage participe à de nombreuses opérations de vol, mais jamais à deux vols qui se chevauchent.

**Passagers, réservations et billets**
- Un passager est identifié par le numéro de son passeport ou de sa pièce d'identité. On conserve aussi son nom et son prénom.
- Une réservation est identifiée par un code de six caractères. Elle est faite par un passager et peut concerner un ou plusieurs voyageurs.
- Pour chaque voyageur et chaque opération de vol réservée, la compagnie émet un billet portant un numéro unique. Le billet précise la classe de voyage : Economy, Premium Economy, Business ou First. Selon le modèle d'avion, toutes les classes ne sont pas proposées.
- À l'enregistrement, un siège (par exemple 34K) est attribué au passager. Deux passagers ne peuvent pas avoir le même siège sur une même opération de vol.

## Partie 2 : Dictionnaire de données brutes (30 données)

| N° | Signification de la donnée | Type | Taille |
|---|---|---|---|
| 1 | Immatriculation de l'avion | Alphanumérique | 6 |
| 2 | État de l'avion (en service, en maintenance, retiré) | Alphabétique | 14 |
| 3 | Nom du modèle d'avion | Alphanumérique | 30 |
| 4 | Nombre total de sièges du modèle | Numérique | 3 |
| 5 | Code IATA de l'aéroport | Alphabétique | 3 |
| 6 | Nom de l'aéroport | Alphanumérique | 60 |
| 7 | Ville de l'aéroport | Alphabétique | 40 |
| 8 | Pays de l'aéroport | Alphabétique | 40 |
| 9 | Fuseau horaire de l'aéroport (ex. Europe/Paris) | Alphanumérique | 30 |
| 10 | Numéro de vol (ex. AF218) | Alphanumérique | 6 |
| 11 | Date et heure de départ prévues (heure locale) | Date-heure | 12 (AAAAMMJJHHMM) |
| 12 | Date et heure d'arrivée prévues (heure locale) | Date-heure | 12 (AAAAMMJJHHMM) |
| 13 | Date et heure de départ réelles (heure locale) | Date-heure | 12 (AAAAMMJJHHMM) |
| 14 | Date et heure d'arrivée réelles (heure locale) | Date-heure | 12 (AAAAMMJJHHMM) |
| 15 | Durée de vol (en minutes) | Numérique | 4 |
| 16 | Nombre de passagers embarqués | Numérique | 3 |
| 17 | Statut du vol (programmé, embarquement, en vol, arrivé, retardé, annulé) | Alphabétique | 12 |
| 18 | Motif du retard ou de l'annulation | Alphanumérique | 100 |
| 19 | Matricule du membre d'équipage | Alphanumérique | 8 |
| 20 | Nom du membre d'équipage | Alphabétique | 30 |
| 21 | Prénom du membre d'équipage | Alphabétique | 30 |
| 22 | Fonction du membre d'équipage (commandant, copilote, cabine) | Alphabétique | 15 |
| 23 | Numéro de licence du pilote | Alphanumérique | 15 |
| 24 | Numéro de passeport ou de pièce d'identité du passager | Alphanumérique | 15 |
| 25 | Nom du passager | Alphabétique | 30 |
| 26 | Prénom du passager | Alphabétique | 30 |
| 27 | Code de réservation | Alphanumérique | 6 |
| 28 | Numéro de billet | Numérique | 13 |
| 29 | Classe de voyage (Economy, Premium Economy, Business, First) | Alphabétique | 15 |
| 30 | Numéro de siège attribué (ex. 34K) | Alphanumérique | 4 |

**Remarques pour l'étudiant :**
- La taille indiquée est un maximum. Les dates sont au format AAAAMMJJ et les heures au format HHMM.
- La durée de vol et le nombre de passagers embarqués apparaissent ici parce que la compagnie souhaite les consulter. Ils peuvent se déduire d'autres données (heures réelles et fuseaux, billets enregistrés). À toi de décider, lors de la modélisation, de les conserver ou de les calculer.
- Les règles de gestion et le dictionnaire couvrent le même périmètre. Si tu as besoin d'informations supplémentaires, n'hésite pas à me les demander.
