-- SCÉNARIO D'UTILISATION
-- La responsable des opérations de la compagnie prépare le bilan des vols
-- du 20 octobre au 7 novembre 2026 : vols, avions, équipages et passagers.

USE AeroportBD;

-- PARTIE A : PROJECTIONS ET SÉLECTIONS
-- A1. Les vols retardés ou annulés avec leur motif, triés par date de départ.
SELECT Numéro_de_vol, Date_depart_prevue, Statut, Motif_du_retard FROM Vol WHERE Statut IN ('Retardé', 'Annulé') ORDER BY Date_depart_prevue;

-- A2. Les pays desservis par la compagnie (sans doublon).
SELECT DISTINCT Pays FROM Ville ORDER BY Pays;

-- A3. Les vols prévus entre le 26 octobre et le 1er novembre 2026.
SELECT Numéro_de_vol, Date_depart_prevue, Immatriculation_d_avion FROM Vol WHERE Date_depart_prevue BETWEEN '2026-10-26 00:00:00' AND '2026-11-01 23:59:59' ORDER BY Date_depart_prevue;

-- A4. Les avions Airbus qui ne sont pas en service.
SELECT Immatriculation_d_avion, nom_modèle, Etat FROM Avion WHERE nom_modèle LIKE 'Airbus%' AND Etat <> 'En service';

-- A5. Les billets Business ou First dont le passager n'a pas embarqué.
SELECT num_billet, clase_, Passeport FROM Billet WHERE clase_ IN ('Business', 'First') AND embarqué = 'Non';

-- PARTIE B : FONCTIONS D'AGRÉGATION (GROUP BY, HAVING)
-- B1. Le nombre de vols pour chaque statut (arrivé, retardé, annulé).
SELECT Statut, COUNT(*) AS 'Nombre de vols' FROM Vol GROUP BY Statut;

-- B2. Les avions qui ont fait au moins 2 vols.
SELECT Immatriculation_d_avion, COUNT(*) AS 'Nombre de vols' FROM Vol GROUP BY Immatriculation_d_avion HAVING COUNT(*) >= 2 ORDER BY COUNT(*) DESC;

-- B3. Les modèles d'avion présents à au moins 3 exemplaires dans la flotte.
SELECT nom_modèle, COUNT(*) AS 'Nombre d''avions' FROM Avion GROUP BY nom_modèle HAVING COUNT(*) >= 3;

-- B4. Le nombre de billets vendus dans chaque classe.
SELECT clase_, COUNT(*) AS 'Nombre de billets' FROM Billet GROUP BY clase_ ORDER BY COUNT(*) DESC;

-- B5. Le nombre total et la moyenne de sièges des avions, selon leur état, pour les états qui totalisent plus de 1000 sièges.
SELECT a.Etat, SUM(m.nombre_de_siège) AS 'Total sièges', AVG(m.nombre_de_siège) AS 'Moyenne sièges' FROM Avion a JOIN Modèle m ON m.nom_modèle = a.nom_modèle
GROUP BY a.Etat HAVING SUM(m.nombre_de_siège) > 1000;

-- PARTIE C : JOINTURES
-- C1. Chaque vol avec son aéroport de départ.  (jointure interne simple)
SELECT v.Numéro_de_vol, vo.Code_IATA AS 'Aéroport de départ', v.Date_depart_prevue FROM Vol v
JOIN Voyage vo ON vo.Numéro_de_vol = v.Numéro_de_vol WHERE vo.Role = 'Départ';

-- C2. Chaque vol avec le modèle de l'avion et son nombre de sièges. (jointure sur 3 tables)
SELECT v.Numéro_de_vol, a.Immatriculation_d_avion, m.nom_modèle, m.nombre_de_siège FROM Vol v
JOIN Avion a  ON a.Immatriculation_d_avion = v.Immatriculation_d_avion JOIN Modèle m ON m.nom_modèle = a.nom_modèle;

-- C3. Tous les avions avec leur nombre de vols, même ceux qui n'ont pas volé. (jointure externe gauche)
SELECT a.Immatriculation_d_avion, COUNT(v.Numéro_de_vol) AS 'Nombre de vols' FROM Avion a LEFT JOIN Vol v ON v.Immatriculation_d_avion = a.Immatriculation_d_avion GROUP BY a.Immatriculation_d_avion;

-- C4. Chaque membre d'équipage avec le nom de son responsable.  (auto-jointure)
SELECT e.Matricule, e.Nom_equipage, e.Fonction, r.Nom_equipage AS 'Responsable' FROM Equipage e JOIN Equipage r ON r.Matricule = e.Matricule_1;

-- C5. L'équipage du vol AF0006 avec la fonction de chacun.
SELECT DISTINCT eq.Matricule, eq.Nom_equipage, eq.Prenom_Equipage, eq.Fonction FROM Effectue ef JOIN Equipage eq ON eq.Matricule = ef.Matricule WHERE ef.Numéro_de_vol = 'AF0006';

-- PARTIE D : REQUÊTES IMBRIQUÉES
-- D1. Les passagers qui ont un billet mais qui n'ont fait aucun vol.  (IN, NOT IN)
SELECT Passeport, Nom_passager, Prenom_passager FROM Passager WHERE Passeport IN (SELECT Passeport FROM Billet) AND Passeport NOT IN (SELECT Passeport FROM Effectue);

-- D2. Les avions qui ont eu au moins un vol retardé.  (EXISTS)
SELECT a.Immatriculation_d_avion, a.nom_modèle FROM Avion a WHERE EXISTS (
SELECT * FROM Vol v WHERE v.Immatriculation_d_avion = a.Immatriculation_d_avion AND v.Statut = 'Retardé');

-- D3. Les avions en service qui n'ont fait aucun vol (disponibles).  (NOT EXISTS)
SELECT a.Immatriculation_d_avion, a.nom_modèle FROM Avion a WHERE a.Etat = 'En service' AND NOT EXISTS (
SELECT * FROM Vol v WHERE v.Immatriculation_d_avion = a.Immatriculation_d_avion);

-- D4. Le modèle qui a le plus de sièges.  (ALL)
SELECT nom_modèle, nombre_de_siège FROM Modèle WHERE nombre_de_siège >= ALL (
SELECT nombre_de_siège FROM Modèle);

-- D5. Les modèles Airbus qui ont plus de sièges qu'au moins un modèle Boeing.  (ANY)
SELECT nom_modèle, nombre_de_siège FROM Modèle WHERE nom_modèle LIKE 'Airbus%' AND nombre_de_siège > ANY (
SELECT nombre_de_siège FROM Modèle WHERE nom_modèle LIKE 'Boeing%');

-- REQUÊTE ÉTUDIÉE DANS LE README (plans d'exécution)
-- Les avions de plus de 250 sièges qui ont eu au moins un vol retardé.
SELECT DISTINCT a.Immatriculation_d_avion, a.nom_modèle
FROM Vol v
JOIN Avion a  ON a.Immatriculation_d_avion = v.Immatriculation_d_avion
JOIN Modèle m ON m.nom_modèle = a.nom_modèle
WHERE v.Statut = 'Retardé'
  AND m.nombre_de_siège > 250;
