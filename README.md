# Projet BD : compagnie aérienne (AeroportBD)  
- Walter Cerda Chavez
- Anthony Charpentreau

## Étape 1 : 

### PROMT UTILISÉ:  
Tu travailles dans le domaine de l’aviation. Ton entreprise a comme activité de transporter des personnes en avion d’un aéroport à un autre. C’est une compagnie aérienne comme Air France, Latam Airlines ou Fly Emirates. On veut collecter des données comme le numéro d’avion, numéro du vol, modèle de l’avion, nombre de passagers, aéroport de départ et d’arrivée, nom des pilotes, date et heure de départ et d’arrivée à l’heure local, temps de vol, etc… Inspire-toi des sites web des compagnies aérienne Air France, Latam Airlines et Fly Emirates.

Ta compagnie aérienne veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données. 

D’abord, établis les règles de gestions des données de ta compagnie, sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information.

Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
Fournis donc les règles de gestion et le dictionnaire de données.

### RÉPONSE CLAUDE (IA):
#### Analyse des besoins : compagnie aérienne (démarche MERISE)

### Règles de gestion

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

### Dictionnaire de données brutes (30 données)

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
| 15 | Nombre de passagers embarqués | Numérique | 3 |
| 16 | Statut du vol (programmé, embarquement, en vol, arrivé, retardé, annulé) | Alphabétique | 12 |
| 17 | Motif du retard ou de l'annulation | Alphanumérique | 100 |
| 18 | Matricule du membre d'équipage | Alphanumérique | 8 |
| 19 | Nom du membre d'équipage | Alphabétique | 30 |
| 20 | Prénom du membre d'équipage | Alphabétique | 30 |
| 21 | Fonction du membre d'équipage (commandant, copilote, cabine) | Alphabétique | 15 |
| 22 | Numéro de licence du pilote | Alphanumérique | 15 |
| 23 | Numéro de passeport ou de pièce d'identité du passager | Alphanumérique | 15 |
| 24 | Nom du passager | Alphabétique | 30 |
| 25 | Prénom du passager | Alphabétique | 30 |
| 26 | Code de réservation | Alphanumérique | 6 |
| 27 | Numéro de billet | Numérique | 13 |
| 28 | Classe de voyage (Economy, Premium Economy, Business, First) | Alphabétique | 15 |
| 29 | Numéro de siège attribué (ex. 34K) | Alphanumérique | 4 |

**Remarques pour l'étudiant :**
- La taille indiquée est un maximum. Les dates sont au format AAAAMMJJ et les heures au format HHMM.
- La durée de vol et le nombre de passagers embarqués apparaissent ici parce que la compagnie souhaite les consulter. Ils peuvent se déduire d'autres données (heures réelles et fuseaux, billets enregistrés). À toi de décider, lors de la modélisation, de les conserver ou de les calculer.
- Les règles de gestion et le dictionnaire couvrent le même périmètre. Si tu as besoin d'informations supplémentaires, n'hésite pas à me les demander.

## Étape 2 : 

### IMAGE MCD:
<img width="1387" height="663" alt="Capture d’écran 2026-09-29 à 11 49 21" src="https://github.com/user-attachments/assets/38ac54c8-53b6-40aa-be85-a31693505c57" />

## Étape 3 :

### IMAGE MLD :
<img width="2690" height="1248" alt="image" src="https://github.com/user-attachments/assets/9aa26560-7586-487a-b2ae-12af5b11bd10" />

MLD textuel :

- Ville = (**code_postal** INT, nom_ville VARCHAR(50), Pays TEXT, Fuseau_horaire TEXT)
- Aeroport = (**Code_IATA** CHAR(3), Nom VARCHAR(50), #code_postal)
- Modèle = (**nom_modèle** VARCHAR(50), nombre_de_siège INT)
- Avion = (**Immatriculation_d_avion** VARCHAR(50), Etat VARCHAR(50), #nom_modèle)
- Vol = (**Numéro_de_vol** VARCHAR(50), Date_depart_prevue DATETIME, Date_d_arrivé_prevue DATETIME, Date_depart_reelle DATETIME, Date_d_arrive_reelle DATETIME, Statut VARCHAR(50), Motif_du_retard VARCHAR(50), #Immatriculation_d_avion)
- Voyage = (**#Code_IATA, #Numéro_de_vol**, Role VARCHAR(50))
- Equipage = (**Matricule** VARCHAR(50), Numero_de_licence_du_pilote VARCHAR(50), Nom_equipage VARCHAR(50), Prenom_Equipage VARCHAR(50), Fonction VARCHAR(50), #Matricule_1)
- Passager = (**Passeport** VARCHAR(50), Nom_passager VARCHAR(50), Prenom_passager VARCHAR(50))
- Billet = (**num_billet** VARCHAR(50), code_de_reservation VARCHAR(50), clase_ VARCHAR(50), numero_de_siège VARCHAR(50), embarqué VARCHAR(50), #Passeport)
- Effectue = (**#Numéro_de_vol, #Matricule, #Passeport**)

## Étape 4 :
### PROMPT Insertion des données :
Contexte : projet MERISE pour une compagnie aérienne inspirée d'Air France, Emirates et LATAM. La base AeroportBD est déjà créée par le fichier 1_création_projet.sql, en s'appuyant sur le script MPD (fourni ci-joint) 

Tâche : génère un fichier 3_insertion_projet.sql qui remplit toutes les tables avec un volume conséquent de données réalistes, puis vérifie qu'il s'importe sans erreur dans MySQL/MariaDB.

Format du fichier :
- Uniquement des INSERT : ni DROP, ni CREATE DATABASE, ni CREATE TABLE.
- Le fichier commence par USE AeroportBD; et SET NAMES utf8mb4;.
- Les tables sont remplies dans l'ordre des clés étrangères. Pour une clé auto-référencée NOT NULL, insère d'abord une ligne racine qui se référence elle-même.
- Ajoute un commentaire en tête de chaque bloc, avec le nombre de lignes.

Données réelles quand c'est possible :
- Vrais aéroports, codes IATA, villes et pays.
- Fuseaux horaires au format UTC±HH:MM (décalage standard, hors heure d'été).
- Vrais modèles d'avions avec leur capacité typique en sièges.
- Immatriculations et numéros de vol au format réel des trois compagnies.
- Préfixes réels des numéros de billet.

Données fictives mais vraisemblables pour tout le reste : personnes, passeports (format selon la nationalité), licences, réservations, sièges, horaires et incidents d'exploitation.

Volumes visés : environ 25 villes et aéroports, 12 modèles, 40 avions, 100 membres d'équipage, 350 passagers, 50 vols, 450 billets.

Cohérence à respecter :
- Les heures sont en heure locale de chaque aéroport. Les arrivées sont calculées à partir de la durée de vol et du décalage horaire réellement en vigueur ce jour-là.
- Un avion ne fait jamais deux vols en même temps et repart de l'aéroport où il a atterri.
- Un membre d'équipage ne fait jamais deux vols qui se chevauchent.
- Chaque vol a au minimum un commandant, un copilote, un chef de cabine et du personnel de cabine.
- Les vols long-courriers ont un copilote de renfort.
- Les classes et sièges sont compatibles avec le modèle d'avion, et un siège n'est attribué qu'une fois par vol.
- Les avions retirés ne volent pas.
- Prévois quelques vols retardés et annulés, avec leur motif.

## Étape 5 :

### Scénario d'utilisation

**Qui utilise la base ?** La responsable des opérations de la compagnie aérienne.

**Pour quoi faire ?** Elle prépare le bilan des vols du 20 octobre au 7 novembre 2026 pour la direction. Elle a besoin de savoir quels vols ont posé problème, comment la flotte d'avions est utilisée, qui compose les équipages et quels passagers sont à recontacter.

Elle extrait les données suivantes, dans l'ordre des requêtes du fichier `4_interrogation.sql` :

**A. Premières recherches (projections et sélections)**

| N° | Donnée recherchée | Notions SQL |
|---|---|---|
| A1 | Les vols retardés ou annulés et leur motif | `IN`, `ORDER BY` |
| A2 | Les pays desservis par la compagnie | `DISTINCT` |
| A3 | Les vols de la semaine du 26 octobre au 1er novembre | `BETWEEN` |
| A4 | Les avions Airbus qui ne sont pas en service | `LIKE` |
| A5 | Les clients Business ou First qui n'ont pas embarqué | `IN`, `AND` |

**B. Statistiques (fonctions d'agrégation)**

| N° | Donnée recherchée | Notions SQL |
|---|---|---|
| B1 | Le nombre de vols arrivés, retardés et annulés | `COUNT`, `GROUP BY` |
| B2 | Les avions qui ont fait au moins 2 vols | `COUNT`, `GROUP BY`, `HAVING` |
| B3 | Les modèles présents à au moins 3 exemplaires dans la flotte | `COUNT`, `GROUP BY`, `HAVING` |
| B4 | Le nombre de billets vendus par classe | `COUNT`, `GROUP BY` |
| B5 | Le total et la moyenne de sièges des avions selon leur état | `SUM`, `AVG`, `GROUP BY`, `HAVING` |

**C. Croiser les informations (jointures)**

| N° | Donnée recherchée | Notions SQL |
|---|---|---|
| C1 | L'aéroport de départ de chaque vol | jointure interne |
| C2 | Le modèle d'avion et le nombre de sièges de chaque vol | jointure sur 3 tables |
| C3 | Le nombre de vols de chaque avion, même ceux qui n'ont pas volé | `LEFT JOIN` (jointure externe) |
| C4 | Le responsable de chaque membre d'équipage | auto-jointure |
| C5 | L'équipage du vol AF0006 | jointure, `DISTINCT` |

**D. Questions plus précises (requêtes imbriquées)**

| N° | Donnée recherchée | Notions SQL |
|---|---|---|
| D1 | Les passagers qui ont un billet mais qui n'ont pas volé (à rembourser) | `IN`, `NOT IN` |
| D2 | Les avions qui ont eu au moins un vol retardé | `EXISTS` |
| D3 | Les avions en service qui n'ont pas volé (disponibles en cas de panne) | `NOT EXISTS` |
| D4 | Le modèle d'avion qui a le plus de sièges | `ALL` |
| D5 | Les modèles Airbus plus grands qu'au moins un modèle Boeing | `ANY` |

Enfin, pour la maintenance, elle cherche **les avions de plus de 250 sièges qui ont eu un vol retardé**. C'est la requête dont les plans d'exécution sont étudiés ci-dessous.

### Étude des plans d'exécution

#### Requête étudiée

> Immatriculation et modèle des avions **gros-porteurs (plus de 250 sièges)** ayant effectué au moins un **vol retardé**.

En algèbre relationnelle, elle utilise trois opérateurs différents : la **sélection σ**, la **jointure ⋈** et la **projection π**.

π<sub>Immatriculation, nom_modèle</sub> ( σ<sub>Statut='Retardé' ∧ nombre_de_siège>250</sub> ( Vol ⋈ Avion ⋈ Modèle ) )

#### Cardinalités (mesurées sur la base remplie)

| Relation / résultat intermédiaire | Lignes |
|---|---|
| Vol | 53 |
| Avion | 44 |
| Modèle | 12 |
| σ<sub>Statut='Retardé'</sub>(Vol) | 7 |
| σ<sub>sièges>250</sub>(Modèle) | 4 |
| Vol ⋈ Avion | 53 |
| Vol ⋈ Avion ⋈ Modèle | 53 |
| Avion ⋈ σ<sub>sièges>250</sub>(Modèle) | 26 |
| σ<sub>Statut</sub>(Vol) ⋈ Avion | 7 |
| Résultat final | 4 |

#### Modèle de coût utilisé

- **Sélection** σ sur une relation de *n* lignes : *n* instructions (chaque ligne est testée une fois).
- **Produit cartésien / jointure** par boucles imbriquées entre *n* et *m* lignes : *n × m* instructions (chaque couple est comparé).
- **Projection** π sur *n* lignes : *n* instructions.

#### Plan A : plan canonique (produits cartésiens, puis sélection, puis projection)

C'est la traduction directe de la requête : on combine toutes les tables, puis on filtre.
<img width="894" height="1174" alt="image" src="https://github.com/user-attachments/assets/4acdea33-75f4-446b-8305-278c183453a9" />

| Étape | Calcul | Instructions |
|---|---|---|
| Vol × Avion | 53 × 44 | 2 332 |
| (Vol × Avion) × Modèle | 2 332 × 12 | 27 984 |
| σ (conditions de jointure + filtres) | 27 984 | 27 984 |
| π | 4 | 4 |
| **Total** | | **58 304** |

#### Plan B : jointures d'abord, sélections ensuite

<img width="894" height="1174" alt="image" src="https://github.com/user-attachments/assets/93b56d97-24e8-41e2-8ee8-b7f95ad3fe4f" />

| Étape | Calcul | Instructions |
|---|---|---|
| Vol ⋈ Avion | 53 × 44 | 2 332 |
| (Vol ⋈ Avion) ⋈ Modèle | 53 × 12 | 636 |
| σ Statut ∧ sièges | 53 | 53 |
| π | 4 | 4 |
| **Total** | | **3 025** |

#### Plan C : sélections descendues au plus près des tables (Vol ⋈ Avion d'abord)

<img width="1308" height="1274" alt="image" src="https://github.com/user-attachments/assets/64f03a95-a143-4c49-969b-0ca587f5f206" />

| Étape | Calcul | Instructions |
|---|---|---|
| σ Statut='Retardé' (Vol) | 53 | 53 |
| σ sièges>250 (Modèle) | 12 | 12 |
| σ(Vol) ⋈ Avion | 7 × 44 | 308 |
| (…) ⋈ σ(Modèle) | 7 × 4 | 28 |
| π | 4 | 4 |
| **Total** | | **405** |

#### Plan D : sélections descendues, mais Avion ⋈ Modèle d'abord

<img width="1308" height="1274" alt="image" src="https://github.com/user-attachments/assets/374d3840-ab6e-41ed-8214-c3d6fcf525ca" />

| Étape | Calcul | Instructions |
|---|---|---|
| σ sièges>250 (Modèle) | 12 | 12 |
| Avion ⋈ σ(Modèle) | 44 × 4 | 176 |
| σ Statut='Retardé' (Vol) | 53 | 53 |
| σ(Vol) ⋈ (Avion ⋈ σ(Modèle)) | 7 × 26 | 182 |
| π | 4 | 4 |
| **Total** | | **427** |

#### Conclusion

| Plan | Instructions |
|---|---|
| A : canonique (produits cartésiens) | 58 304 |
| B : jointures puis sélections | 3 025 |
| **C : sélections descendues, Vol ⋈ Avion d'abord** | **405** |
| D : sélections descendues, Avion ⋈ Modèle d'abord | 427 |

Le **plan C** est le plan optimisé : il fait environ 144 fois moins d'instructions que le plan canonique et 7,5 fois moins que le plan B. Il applique les deux règles d'optimisation vues en cours :

1. **Descendre les sélections** le plus bas possible dans l'arbre. Filtrer `Vol` (53 → 7 lignes) et `Modèle` (12 → 4 lignes) *avant* de joindre réduit fortement la taille des relations comparées.
2. **Commencer par la jointure qui produit le moins de lignes.** Le plan D descend aussi les sélections, mais sa première jointure `Avion ⋈ σ(Modèle)` produit 26 lignes, contre 7 pour `σ(Vol) ⋈ Avion` dans le plan C. Sa seconde jointure coûte donc 7 × 26 = 182 au lieu de 7 × 4 = 28.

On pourrait aussi descendre les projections (ne garder que les colonnes utiles avant chaque jointure). Cela réduit la mémoire utilisée, mais pas le nombre de lignes comparées.
