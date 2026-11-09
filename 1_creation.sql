
DROP DATABASE IF EXISTS AeroportBD;
CREATE DATABASE AeroportBD;
USE AeroportBD;

CREATE TABLE Equipage(
   Matricule VARCHAR(50),
   Numero_de_licence_du_pilote VARCHAR(50) NOT NULL,
   Nom_equipage VARCHAR(50) NOT NULL,
   Prenom_Equipage VARCHAR(50) NOT NULL,
   Fonction VARCHAR(50) NOT NULL,
   Matricule_1 VARCHAR(50) NOT NULL,
   PRIMARY KEY(Matricule),
   UNIQUE(Numero_de_licence_du_pilote),
   FOREIGN KEY(Matricule_1) REFERENCES Equipage(Matricule)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Passager(
   Passeport VARCHAR(50),
   Nom_passager VARCHAR(50) NOT NULL,
   Prenom_passager VARCHAR(50) NOT NULL,
   PRIMARY KEY(Passeport)
);

CREATE TABLE Ville(
   code_postal INT,
   nom_ville VARCHAR(50) NOT NULL,
   Pays TEXT NOT NULL,
   Fuseau_horaire TEXT NOT NULL,
   PRIMARY KEY(code_postal)
);

CREATE TABLE Modèle(
   nom_modèle VARCHAR(50),
   nombre_de_siège INT NOT NULL,
   PRIMARY KEY(nom_modèle)
);

CREATE TABLE Billet(
   num_billet VARCHAR(50),
   code_de_reservation VARCHAR(50) NOT NULL,
   clase_ VARCHAR(50) NOT NULL,
   numero_de_siège VARCHAR(50) NOT NULL,
   embarqué VARCHAR(50) NOT NULL,
   Passeport VARCHAR(50) NOT NULL,
   PRIMARY KEY(num_billet),
   UNIQUE(code_de_reservation),
   FOREIGN KEY(Passeport) REFERENCES Passager(Passeport)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Avion(
   Immatriculation_d_avion VARCHAR(50),
   Etat VARCHAR(50) NOT NULL,
   nom_modèle VARCHAR(50) NOT NULL,
   PRIMARY KEY(Immatriculation_d_avion),
   FOREIGN KEY(nom_modèle) REFERENCES Modèle(nom_modèle)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Aeroport(
   Code_IATA CHAR(3),
   Nom VARCHAR(50) NOT NULL,
   code_postal INT NOT NULL,
   PRIMARY KEY(Code_IATA),
   UNIQUE(Nom),
   FOREIGN KEY(code_postal) REFERENCES Ville(code_postal)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Vol(
   Numéro_de_vol VARCHAR(50),
   Date_depart_prevue DATETIME NOT NULL,
   Date_d_arrivé_prevue DATETIME NOT NULL,
   Date_depart_reelle DATETIME NOT NULL,
   Date_d_arrive_reelle DATETIME NOT NULL,
   Statut VARCHAR(50) NOT NULL,
   Motif_du_retard VARCHAR(50),
   Immatriculation_d_avion VARCHAR(50) NOT NULL,
   PRIMARY KEY(Numéro_de_vol),
   FOREIGN KEY(Immatriculation_d_avion) REFERENCES Avion(Immatriculation_d_avion)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Effectue(
   Numéro_de_vol VARCHAR(50),
   Matricule VARCHAR(50),
   Passeport VARCHAR(50),
   PRIMARY KEY(Numéro_de_vol, Matricule, Passeport),
   FOREIGN KEY(Numéro_de_vol) REFERENCES Vol(Numéro_de_vol)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY(Matricule) REFERENCES Equipage(Matricule)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY(Passeport) REFERENCES Passager(Passeport)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE Voyage(
   Code_IATA CHAR(3),
   Numéro_de_vol VARCHAR(50),
   Role VARCHAR(50) NOT NULL,
   PRIMARY KEY(Code_IATA, Numéro_de_vol),
   FOREIGN KEY(Code_IATA) REFERENCES Aeroport(Code_IATA)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY(Numéro_de_vol) REFERENCES Vol(Numéro_de_vol)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
