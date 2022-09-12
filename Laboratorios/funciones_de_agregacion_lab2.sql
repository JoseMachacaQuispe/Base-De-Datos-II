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
#19 Funcion para mostrar el id_estudiante mayor (nombres y apellidos)

CREATE OR REPLACE FUNCTION id_est_max()
RETURNS INTEGER
    BEGIN
        return(
           SELECT MAX(est.id_est)
           FROM estudiantes AS est
            );
    end;
SELECT id_est_max();

SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE est.id_est = id_est_max ();


#20 Mostrar todos los registros de la tabla estudiantes (nombres y apellidos)
# si la suma de las edades de los estudiantes masculino/femenino sea par.

CREATE FUNCTION suma_edades_masculino()
RETURNS INTEGER
BEGIN
    return(
        SELECT SUM(est.edad)
        FROM estudiantes AS est
        WHERE est.genero ='masculino'

        );
end;

SELECT suma_edades_masculino();

SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE suma_edades_masculino() %2 =0;

#21 Mostrar todos los registros de la tabla estudiantes (nombres y apellidos)
# si la suma de las edades de las estudiantes femeninos sea par.

CREATE FUNCTION suma_edades_femenino()
RETURNS INTEGER
BEGIN
    return(
        SELECT SUM(est.edad)
        FROM estudiantes AS est
        WHERE est.genero ='femenino'

        );
end;

SELECT suma_edades_femenino();

SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE suma_edades_femenino() %2 =0;

#Volver parametrizable la anterior funcion v1
CREATE FUNCTION suma_edades_v1(genero_valor varchar(10))
RETURNS INTEGER
BEGIN
    RETURN (
        SELECT  SUM(est.edad)
        FROM estudiantes AS est
        WHERE est.genero = genero_valor
        );
end;

SELECT suma_edades_v1('masculino');
SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE suma_edades_v1('masculino') %2 =0;


#Volver parametrizable la anterior funcion v2
CREATE FUNCTION suma_edades_v2(genero varchar(10))
RETURNS INTEGER
BEGIN
    DECLARE sumaEdad INTEGER DEFAULT 0;
    SELECT SUM(est.edad) INTO sumaEdad
    FROM estudiantes AS est
    WHERE  est.genero = genero;
    RETURN sumaEdad;
end;

SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE suma_edades_v2('masculino') %2 =0;

CREATE OR REPLACE FUNCTION get_prom_edad()
RETURNS INTEGER
    BEGIN
        return(

           SELECT AVG(est.edad)
           FROM estudiantes AS est
           WHERE est.genero = 'masculino'
            );
    end;
SELECT get_prom_edad();

#********************************************************************************

#Promedio de edades de forma parametrizado

CREATE OR REPLACE FUNCTION get_prom_v2(genero varchar(10))
RETURNS INTEGER
    BEGIN
        DECLARE promEdad REAL DEFAULT 0;
        SELECT AVG(est.edad) INTO promEdad
        FROM estudiantes AS est
        WHERE  est.genero = genero;
        RETURN promEdad;

    end;

SELECT get_prom_v2('masculino');
SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE get_prom_v2('masculino') %2 =0;


#Crear una función que permita concatenar dos columnas.
#Concatena el nombre y apellidos de la tabla estudiante.
#El nombre de la función deberá ser getNombreCompleto
#La función deberá recibir 2 parámetros (nombre y apellidos)

SELECT CONCAT('William ', 'Barra');

SELECT CONCAT('DBA II', ' ', '2022') AS CONCATENA;
SELECT CONCAT('DBA II', ' ', '2022', ' ', 'Semestre 3') AS CONCATENA;

CREATE OR REPLACE FUNCTION getNombreCompleto(par1 VARCHAR(25), par2 VARCHAR(25))
RETURNS VARCHAR(50)
BEGIN
    DECLARE concatenado VARCHAR(50) DEFAULT '';
    SET concatenado = CONCAT(par1, ' - ', par2);
    RETURN concatenado;
end;

SELECT getNombreCompleto('Pepito', 'Pep');

SELECT getNombreCompleto(est.nombres, est.apellidos) AS Fullname
FROM estudiantes AS est;



#***********************************************************************************

#Generar el siguiente formato de salida
#Concatenar nombres y apellidos de la siguiente forma: Nombres: William, Apellidos: Barra
#Concatenar gestion y edad


CREATE FUNCTION primeraFuncion (nombres VARCHAR(50), apellidos VARCHAR(50) )
RETURNS VARCHAR(100)
BEGIN
    DECLARE resultado VARCHAR(100) DEFAULT '';
    SET resultado = CONCAT('Nombres: ', nombres, ', Apellidos: ', apellidos);
    RETURN resultado;

END;

SELECT  primeraFuncion('William', 'Barra');
SELECT primeraFuncion(est.nombres, est.apellidos) AS FULLNAME
FROM estudiantes AS est;

CREATE FUNCTION output_age (gestion integer, edad integer )
RETURNS VARCHAR(100)
BEGIN
    DECLARE resultado VARCHAR(100) DEFAULT '';
    SET resultado = CONCAT('Gestion: ', gestion, ', - Edad( ', edad, ')');
    RETURN resultado;

END;

SELECT  output_age(2022, 32);

SELECT primeraFuncion(est.nombres, est.apellidos) AS FULLNAME,
       output_age(est.gestion, est.edad) GESTION_AGE
FROM estudiantes AS est;

#Realizarlo en sola una funcion el anterior ejercicio

CREATE OR REPLACE FUNCTION full_funtion (nombres VARCHAR(50), apellidos VARCHAR(50), gestion integer, edad integer)
RETURNS VARCHAR(100)
BEGIN
    DECLARE resultado VARCHAR(100) DEFAULT '';
    SET resultado = CONCAT('Nombres: ', nombres, ', Apellidos: ', apellidos, ' - Gestion: ', gestion, ', - Edad( ', edad, ')');
    RETURN resultado;

end;

SELECT full_funtion('Jose', 'Machaca', 2022, 20);

SELECT full_funtion(est.nombres, est.apellidos, est.gestion, est.edad) FUNCION_COMPLETA
FROM estudiantes AS est;

SELECT est.nombres, est.apellidos, ins.semestre
FROM estudiantes as est
INNER JOIN inscripcion as ins ON ins.id_est = est.id_est
WHERE ins.gestion = 2015;

SELECT est.nombres, est.apellidos, mat.nombre_mat
FROM inscripcion as ins
INNER JOIN estudiantes AS est ON ins.id_est = est.id_est
INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
WHERE mat.cod_mat = 'arq-101';

SELECT est.nombres, est.apellidos, ins. semestre, mat.nombre_mat
FROM inscripcion as ins
INNER JOIN estudiantes AS est ON ins.id_est = est.id_est
INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
WHERE ins.semestre = '5to Semestre';


SELECT est.nombres, est.apellidos, ins. semestre
FROM inscripcion as ins
INNER JOIN estudiantes AS est ON ins.id_est = est.id_est
WHERE ins.gestion = 2016 or 2017;
## EJERCICIO 13 DE LA PRACTICA

CREATE FUNCTION ins_est(cod_mat VARCHAR (50))
RETURNS INTEGER
BEGIN
    DECLARE parametro INTEGER DEFAULT 0;
    SELECT est.id_est INTO parametro
    FROM estudiantes AS est
    INNER JOIN inscripcion AS ins ON est.id_est =ins.id_est
    INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
    WHERE mat.cod_mat = cod_mat;
    RETURN parametro;

END;

SELECT est.id_est, est.nombres, est.apellidos, mat.nombre_mat, mat.cod_mat
FROM estudiantes AS est
INNER JOIN inscripcion AS ins ON est.id_est = ins.id_est
INNER JOIN materias AS mat ON ins.id_mat = mat.id_mat
WHERE ins_est('ARQ-105') = est.id_est;

# EJERCICIO 14 DE LA PRACTICA