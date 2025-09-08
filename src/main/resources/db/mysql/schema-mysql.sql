DROP TABLE IF EXISTS vets;
DROP TABLE IF EXISTS specialties;
DROP TABLE IF EXISTS vet_specialties;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS visits;

CREATE TABLE vets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30),
  last_name VARCHAR(30)
);

CREATE TABLE specialties (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80)
);

CREATE TABLE vet_specialties (
  vet_id INT NOT NULL,
  specialty_id INT NOT NULL,
  FOREIGN KEY (vet_id) REFERENCES vets(id),
  FOREIGN KEY (specialty_id) REFERENCES specialties(id),
  UNIQUE (vet_id,specialty_id)
);

CREATE TABLE types (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(80)
);

CREATE TABLE owners (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  address VARCHAR(255),
  city VARCHAR(80),
  telephone VARCHAR(20)
);

CREATE TABLE pets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30),
  birth_date DATE,
  type_id INT,
  owner_id INT,
  FOREIGN KEY (type_id) REFERENCES types(id),
  FOREIGN KEY (owner_id) REFERENCES owners(id)
);

CREATE TABLE visits (
  id INT PRIMARY KEY AUTO_INCREMENT,
  pet_id INT,
  visit_date DATE,
  description VARCHAR(255),
  FOREIGN KEY (pet_id) REFERENCES pets(id)
);

