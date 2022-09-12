CREATE DATABASE function_aggregation;

USE function_aggregation;
CREATE TABLE estudiantes(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    edad INTEGER,
    gestion INTEGER,
    fono INTEGER,
    email VARCHAR(100),
    direccion VARCHAR(100),
    genero VARCHAR(10)
);

INSERT INTO estudiantes (nombres, apellidos, edad, gestion, email, direccion, genero)
VALUES
('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');



UPDATE estudiantes
SET gestion ='2022'
WHERE id_est >0;

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);
CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO materias (nombre_mat, cod_mat) VALUES
('Introduccion a la Arquitectura','ARQ-101'),
('Urbanismo y Diseno','ARQ-102'),
('Dibujo y Pintura Arquitectonico','ARQ-103'),
('Matematica discreta','ARQ-104'),
('Fisica Basica','ARQ-105');



INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
(1, 1, '1er Semestre', 2015),
(1, 2, '2do Semestre', 2015),
(2, 4, '1er Semestre', 2016),
(2, 3, '2do Semestre', 2016),
(3, 3, '2do Semestre', 2017),
(3, 1, '3er Semestre', 2017),
(4, 4, '4to Semestre', 2017),
(5, 5, '5to Semestre', 2017);



select *from estudiantes;
select *from inscripcion;
select*from materias;

#Mostrar los nombres y apellidos de los estudiantes inscritos en la materia ARQ-104
#adicionalmente mostrar el nombre el nombre de la materia.

SELECT est.nombres, est.apellidos, mat.nombre_mat
FROM inscripcion as ins
INNER JOIN estudiantes AS est ON ins.id_est = est.id_est
INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
WHERE mat.cod_mat = 'arq-104';


#Contar cuantos registros tiene la tabla estudiante
SELECT COUNT (est.id_est) AS 'Cantidad de estudiantes'
FROM estudiantes AS est;

#Mostrar el promedio de edad en la tabla estudiantes.
SELECT AVG(est.edad)
FROM estudiantes AS est;

#Mostrar la máxima edad que se tiene en la tabla estudiantes.
SELECT MAX(est.edad)
FROM estudiantes AS est;

#Mostrar la mínima edad que se tiene en la estudiantes.
SELECT MIN(est.edad)
FROM estudiantes AS est;


#Determinar la maxima edad de losm estudiantes
#cuyo genero se masculino/femenino
#y ademas la edad sea mayor a 20

SELECT MAX(est.edad)
FROM estudiantes AS est
WHERE est.genero > 20 ='femenino';

SELECT MAX(est.edad)
FROM estudiantes AS est
WHERE est.genero > 20 ='masculino';



CREATE OR REPLACE FUNCTION get_max_edad()
RETURNS VARCHAR(20)
    BEGIN
        RETURN 'William Barra';
    end;
SELECT get_max_edad();


#Funcion para el maximo edad
CREATE OR REPLACE FUNCTION get_max_edad()
RETURNS INTEGER
    BEGIN
        return(

            SELECT MAX(est.edad)
            FROM estudiantes AS est
            );
    end;
SELECT get_max_edad();

#16 Funcion minima edad de loos estudiantes
CREATE FUNCTION get_min_edad()
RETURNS INTEGER
    BEGIN
        return(

            SELECT MIN(est.edad)
            FROM estudiantes AS est
            );
    end;
SELECT get_min_edad();

#17 Promedio de edades
CREATE FUNCTION get_prom_edad()
RETURNS INTEGER
    BEGIN
        return(

           SELECT AVG(est.edad)
           FROM estudiantes AS est
            );
    end;
SELECT get_prom_edad();

# 18 Mayor edad de estudiantes femenino/masculino

CREATE FUNCTION get_mayor_edad()
RETURNS INTEGER
    BEGIN
        return(

           SELECT MAX(est.edad)
           FROM estudiantes AS est
           WHERE est.genero  ='masculino'
            );
    end;
SELECT get_mayor_edad();


#19 Funcion para mostrar el id_estudiante mayor

CREATE OR REPLACE FUNCTION id_est_max()
RETURNS INTEGER
    BEGIN
        return(
           SELECT MAX(est.id_est)
           FROM estudiantes AS est
            );
    end;
SELECT id_est_max();
