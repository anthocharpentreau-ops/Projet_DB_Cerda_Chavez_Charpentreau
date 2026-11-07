USE AeroportBD;

-- Le code postal est un nombre positif.
ALTER TABLE Ville ADD CONSTRAINT ck_ville_code_postal CHECK (code_postal > 0);

-- Le fuseau horaire est au format UTC+HH:MM ou UTC-HH:MM
ALTER TABLE Ville ADD CONSTRAINT ck_ville_fuseau CHECK (Fuseau_horaire LIKE 'UTC+__:__' OR Fuseau_horaire LIKE 'UTC-__:__');

-- Chaque aéroport est identifié par son code à trois lettres.
ALTER TABLE Aeroport ADD CONSTRAINT ck_aeroport_iata CHECK (LENGTH(Code_IATA) = 3);

-- Le nombre de sièges a 3 chiffres au maximum (dictionnaire). Le plus gros avion commercial (A380) peut transporter au maximum 853 passagers.
ALTER TABLE Modèle ADD CONSTRAINT ck_modele_sieges CHECK (nombre_de_siège BETWEEN 1 AND 853);

-- Un avion a un état en service, en maintenance ou retiré.
ALTER TABLE Avion ADD CONSTRAINT ck_avion_etat CHECK (Etat IN ('En service', 'En maintenance', 'Retiré'));

-- Un nouvel avion est en service par défaut.
ALTER TABLE Avion ALTER Etat SET DEFAULT 'En service';

-- Immatriculation: préfixe du pays (1 ou 2 caractères), un tiret, puis au moins 3 caractères (F-HTYA, A6-EEA, PT-XTA, CC-BGA).
ALTER TABLE Avion ADD CONSTRAINT ck_avion_immatriculation CHECK (Immatriculation_d_avion LIKE '_-___%' OR Immatriculation_d_avion LIKE '__-___%');

-- Fonction : commandant de bord, copilote ou personnel de cabine
ALTER TABLE Equipage ADD CONSTRAINT ck_equipage_fonction CHECK (Fonction IN ('Commandant de bord', 'Copilote', 'Chef de cabine', 'Personnel de cabine'));

-- Matricule : code de la compagnie (AF, EK ou LA) suivi de 5 chiffres.
ALTER TABLE Equipage ADD CONSTRAINT ck_equipage_matricule CHECK (Matricule LIKE 'AF_____' OR Matricule LIKE 'EK_____' OR Matricule LIKE 'LA_____');

-- Les pilotes ont en plus un numéro de licence, un commandant ou un copilote a une licence de pilote (FCL, ATPL ou PLA dans le numéro).
-- Le personnel de cabine a un certificat de cabine, pas une licence de pilote.
ALTER TABLE Equipage ADD CONSTRAINT ck_equipage_licence
   CHECK (
      (Fonction IN ('Commandant de bord', 'Copilote')
         AND (Numero_de_licence_du_pilote LIKE '%FCL%'
           OR Numero_de_licence_du_pilote LIKE '%ATPL%'
           OR Numero_de_licence_du_pilote LIKE '%PLA%'))
      OR
      (Fonction IN ('Chef de cabine', 'Personnel de cabine')
         AND Numero_de_licence_du_pilote NOT LIKE '%FCL%'
         AND Numero_de_licence_du_pilote NOT LIKE '%ATPL%'
         AND Numero_de_licence_du_pilote NOT LIKE '%PLA%')
   );

-- Le nom et le prénom ne sont pas vides.
ALTER TABLE Equipage ADD CONSTRAINT ck_equipage_nom CHECK (Nom_equipage <> '' AND Prenom_Equipage <> '');

-- Passeport ou pièce d'identité entre 6 et 15 caractères.
ALTER TABLE Passager ADD CONSTRAINT ck_passager_passeport CHECK (LENGTH(Passeport) BETWEEN 6 AND 15);
ALTER TABLE Passager ADD CONSTRAINT ck_passager_nom CHECK (Nom_passager <> '' AND Prenom_passager <> '');

-- Numéro de billet sur 13 chiffres (dictionnaire).
ALTER TABLE Billet ADD CONSTRAINT ck_billet_numero CHECK (LENGTH(num_billet) = 13);

-- Une réservation est identifiée par un code de six caractères
ALTER TABLE Billet ADD CONSTRAINT ck_billet_reservation CHECK (LENGTH(code_de_reservation) = 6);

-- Classe de voyage Economy, Premium Economy, Business ou First
ALTER TABLE Billet ADD CONSTRAINT ck_billet_classe CHECK (clase_ IN ('Economy', 'Premium Economy', 'Business', 'First'));

-- Siège 2 ou 3 caractères.
ALTER TABLE Billet ADD CONSTRAINT ck_billet_siege CHECK (LENGTH(numero_de_siège) BETWEEN 2 AND 3);

-- Embarqué : Oui ou Non. Un billet qui vient d'être émis n'est pas embarqué
ALTER TABLE Billet ADD CONSTRAINT ck_billet_embarque CHECK (embarqué IN ('Oui', 'Non'));
ALTER TABLE Billet ALTER embarqué SET DEFAULT 'Non';

-- Le motif fait 100 caractères au dictionnaire on agrandit la colonne.
ALTER TABLE Vol MODIFY Motif_du_retard VARCHAR(100);

-- Numéro de vol code de la compagnie (AF, EK ou LA) + 4 chiffres.
ALTER TABLE Vol ADD CONSTRAINT ck_vol_numero
   CHECK (Numéro_de_vol LIKE 'AF____'
       OR Numéro_de_vol LIKE 'EK____'
       OR Numéro_de_vol LIKE 'LA____');

-- Statut programmé, embarquement, en vol, arrivé, retardé ou annulé
ALTER TABLE Vol ADD CONSTRAINT ck_vol_statut CHECK (Statut IN ('Programmé', 'Embarquement', 'En vol', 'Arrivé', 'Retardé', 'Annulé'));

-- Un nouveau vol est programmé par défaut.
ALTER TABLE Vol ALTER Statut SET DEFAULT 'Programmé';

-- L'arrivée a lieu après le départ (dates prévues et dates réelles).
ALTER TABLE Vol ADD CONSTRAINT ck_vol_dates_prevues CHECK (Date_d_arrivé_prevue > Date_depart_prevue);
ALTER TABLE Vol ADD CONSTRAINT ck_vol_dates_reelles CHECK (Date_d_arrive_reelle > Date_depart_reelle);

-- En cas de retard ou d'annulation, on note le motif. Un vol sans problème n'a pas de motif.
ALTER TABLE Vol ADD CONSTRAINT ck_vol_motif
   CHECK (
      (Statut IN ('Retardé', 'Annulé') AND Motif_du_retard IS NOT NULL)
      OR
      (Statut NOT IN ('Retardé', 'Annulé') AND Motif_du_retard IS NULL)
   );

-- Un vol retardé part réellement après l'heure prévue.
ALTER TABLE Vol ADD CONSTRAINT ck_vol_retard CHECK (Statut <> 'Retardé' OR Date_depart_reelle > Date_depart_prevue);

-- Un vol annulé n'a pas eu lieu ses dates réelles (NOT NULL dans le MLD) sont égales aux dates prévues.
ALTER TABLE Vol ADD CONSTRAINT ck_vol_annule
   CHECK (Statut <> 'Annulé'
          OR (Date_depart_reelle = Date_depart_prevue
              AND Date_d_arrive_reelle = Date_d_arrivé_prevue));

-- L'aéroport est soit l'aéroport de départ, soit celui d'arrivée du vol.
ALTER TABLE Voyage ADD CONSTRAINT ck_voyage_role CHECK (Role IN ('Départ', 'Arrivée'));

-- Un vol relie UN aéroport de départ à un aéroport d'arrivée, pour un même vol, chaque rôle n'apparaît qu'une fois.
ALTER TABLE Voyage ADD CONSTRAINT uq_voyage_vol_role UNIQUE (Numéro_de_vol, Role);
