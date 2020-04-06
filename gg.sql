CREATE DATABASE libreria_cf; -- CREAMOS LA BASE DE DATOS USANDO EL COMANDO "CREATE DATABASE NOMBRE_BD;"

USE libreria_cf; --  DECLARAMOS QUE USAREMOS LA BASE DE DATOS CON EL COMANDO " USE NOMBRE-BD;"


CREATE TABLE IF NOT EXISTS AUTORES
(                                                             -- IF NO EXIST NOS PERMITE CREAR LA TABLA CADA VEZ QUE SEA NECESARIO PERO NO EXISTA
    AUTOR_ID         INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- LA LLAVE PRIMARIA SE DEFINE MEDIANTE EL COMANDO  "PRIMARY KEY" LAS LLAVES POR LO GENERAL SON DE TIPO DE DATO ENTERO "INT" AUTO_INCREMENT NOS PERMITE QUE SE ASIGENE AUTOMATICAMENTE UN DATO COMO ID QE AUMENTA EN 1 CADA VEZ QUE SE AÑADE UN NUEVO DATO
    NOMBRE           VARCHAR(25) NOT NULL,
    APELLIDO         VARCHAR(25) NOT NULL,
    SEUDONIMO        VARCHAR(50) UNICODE,
    GENERO           ENUM ('M', 'F'),                         -- ENUM NOS PERMITE DEFINIR LOS UNICOS DATOS PERMITDOS O SEA M Y F
    FECHA_NACIMIENTO DATE        NOT NULL,
    PAIS_ORIGEN      VARCHAR(40) NOT NULL,
    FECHA_CREACION   DATETIME DEFAULT CURRENT_TIMESTAMP,      -- CURRENT_TIMESTAMP NSO PERMITE TOMAR LA FECHA Y HORA DEL SISTEMA
    CONSTRAINT UNIQUE_COMBINATION UNIQUE (NOMBRE, APELLIDO)   -- CONSTRAINT UNIQUE_COMBINATION UNIQUE (NOMBRE_CAMPO1, NOMBRE_CAMPO2) NOS PERMITE DEFINIR UNICOS VARIOS CAMPOS DE UNA TABLA
);

CREATE TABLE IF NOT EXISTS LIBROS
(

    LIBRO_ID          INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    AUTOR_ID          INT UNSIGNED NOT NULL,
    TITULO            VARCHAR(50)  NOT NULL,
    DESCRIPCION       VARCHAR(250),
    PAGINAS           INTEGER UNSIGNED,
    FECHA_PUBLICACION DATE         NOT NULL,
    FECHA_CREACION    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AUTOR_ID) REFERENCES AUTORES (AUTOR_ID) ON DELETE CASCADE

);

desc LIBROS;

/* INSERTAMOS LOS DATOS EN AUTORES DONDE SOLO UNO PODRÍA SER NULO EL CUAL ES EL SEUDONIMO PERO NO LO HEMOS DEJADO NULO */

INSERT INTO AUTORES (NOMBRE, APELLIDO, SEUDONIMO, GENERO, FECHA_NACIMIENTO, PAIS_ORIGEN) -- EL AUTOR ID NO SE HA PUESTO YA QUE ESTE SI RECORDAMOS LO COLOCAMOS COMO AUTO_INCREMENT
VALUES ('Stephen Edwin', 'King', 'Richard Bachman', 'M', '1947-09-27', 'USA'),
       ('Joanne', 'Rowling', 'J.R Rowling', 'F', '1947-09-27', 'Reino undido'),
       ('John Ronald Reuel ', 'Tolkien', NULL, 'M', '1892-01-03', 'UK'),
       ('Adolft', 'hitlee', 'el lobo', 'M', '1974-02-23', 'Alemania'),
       ('hugo', 'chavez', 'el bruto', 'm', '1980-09-08', 'Venelezuela');

INSERT INTO AUTORES(NOMBRE, APELLIDO, SEUDONIMO, GENERO, FECHA_NACIMIENTO, PAIS_ORIGEN) -- ESTO ES UNA PRUEBA PARA VER QUE NO SE PODRÀ INGRESAR DATOS DUPLICADOS EN CUANTO AL NOMBRE Y APPELIDO DE UN AUTOR
VALUES ('Stephen Edwin', 'King', 'Richard Bachman', 'M', '1947-09-27', 'USA');


/* INSERTAMOS DATOS EN LA TABALA DE LIBROS */

INSERT INTO LIBROS (AUTOR_ID, TITULO, FECHA_PUBLICACION)
VALUES (1, 'CARRIE', '1974-01-01'),
       (1, 'El misterio de salmes lot', '1975-01-01'),
       (2, 'HarryPotter y la piedra filosofal', '1997-09-30'),
       (2, 'HarryPotter y la camara secreta', '1998-07-2'),
       (3, 'el hobbit', '1892-02-22'),
       (4, 'mi lucha', '1890-02-23'),
       (5, 'mi lucha', '1997-05-15');

insert into LIBROS(AUTOR_ID, TITULO, DESCRIPCION, PAGINAS, FECHA_PUBLICACION, VENTAS)
VALUES (3, 'El Señor De Los Anillos', Null, 10, '1972-05-20', 0);



/* MODIFICADOR DE TABLAS */ -- LOS MODIFICADORES DE TABLA NOS PERMITEN MODIFICAR, AGREGAR Y ELIMINAR YA SEAN DATOS, TABLAS O COLUMNAS

ALTER TABLE LIBROS
    ADD VENTAS INT UNSIGNED NOT NULL; -- AGREGAREMOS UN COLUMNA A NUESTRA TABLA LIBROS LA CUAL NO RECIBIRA DATOS NEGATIVOS NI NULOS

SELECT *
FROM LIBROS; -- AL VISUALIZAR VEREMOS QUE LA NUEVA COLUMNA VENTAS TENDRA VALOR DE 0 Y ESTO SE DEBE A QUE DECLARAMOS QUE NO TENNDRÍA VALORES NULOS ASÍ QUE ASIGNA UN VALOR DE CERO


ALTER TABLE LIBROS
    ADD STOCK INT UNSIGNED NOT NULL DEFAULT 10; -- TAMBIEN PODREMOS DEFINIR EL VALOR POR DEFAULT QUE TENDRA UNA COLUMNA QUE ACABAMOS DE AÑADIR

SELECT *
FROM LIBROS;
-- AL VISUALIZAR LA TABALA VEREMOS QUE POR DEFECTO STOCK TIENE EL VALOR DE 10


/* SI QUISIERAMOS ELIMINAR UNA COLUMNA TENDRIAMOS */

ALTER TABLE LIBROS
    DROP COLUMN STOCK; -- HEMOS ELIMINAOD LA COLUMNA STOCK DE LA TABLA LIBROS

DESC LIBROS; -- AL MIRAR LA DESCRIPCION DE LA TABLA VEREMOS QUE NO EXISTE YA ESA COLUMNA / DESC NOS DESCRIBE LA TRABLA CON SUS COLUMNAS Y TIPOS DE DATOS

ALTER TABLE LIBROS RENAME BOOKS; -- PARA CAMBIAR EL NOMBRE DE LA TABLA LIBROS A BOOKS

ALTER TABLE LIBROS
    MODIFY TITULO VARCHAR(40);
-- ESTE COMANDO PODREMOS CAMBIAR EL TIPO DE DATO O LA LONGITUD DE ESTE DE UNA COLUMNA


/* CONSULTA MEDIANTE CONDICIONES */

SELECT *
FROM LIBROS; -- SOLICITAMOS TODOS LOS DATOS DE LA TABLA LIBROS

SELECT LIBRO_ID, TITULO
FROM LIBROS; -- SOLICITAMOS COLUMNAS ESPEFICICAS

SELECT *
FROM LIBROS
WHERE TITULO = 'carrie';
-- SOLICITAMOS A LA TABLA LIBRO QUE NOS MUESTRE UN REGISTRO DONDE EL TITULO DE ALGUN DE SUS LIBROS SEA 'CARRIE'


/*OPERADORES LOGICOS */

SELECT *
FROM LIBROS
WHERE TITULO = 'CARRIE'
  AND LIBRO_ID = 1
  AND VENTAS = 0; -- AL USAR EL OPERADOR AND AMBAS CONDICIONES TIENEN QUE SER VERDADERAS

SELECT *
FROM LIBROS
WHERE TITULO = 'CARRIE'
   OR LIBRO_ID = 1
   OR LIBROS.VENTAS = 0; -- AL UTILIZAR EL OPERADOR OR SE NOS MUESTRA VARIOS REGISTROS YA QUE CUALQUIERA DE LAS CONDICIONES PUEDE SER FALSA O VERDADERA

SELECT *
FROM LIBROS
WHERE (AUTOR_ID = 1 AND TITULO = 'CARRIE')
   OR (AUTOR_ID = 2 AND TITULO = 'HarryPotter y la piedra filosofal');
-- ESTAMOS CONSULTANDO DOS CONDICIONES DONDE UNA ES VERDADERA Y LA OTRA ES FALSA. SI COLCAMOS QUE EL AUTOR_ID ES 5 NO VISUALIZAREMOS ESA PARTE DE LA CONSULTA


/* HACER CONSULTA PARA VALORES NULOS  */

SELECT TITULO
FROM LIBROS;


SELECT *
FROM AUTORES
WHERE SEUDONIMO IS NULL; -- ESTAMOS CONSULTANDO A LOS AUTORES QUE NO TIENE UN SEUDONIMO ES DECIR QUE SU SEUDONIMO SEA NULL

SELECT *
FROM AUTORES
WHERE SEUDONIMO IS NOT NULL; -- ESTAMOS CONSULTANDO A LOS AUTORES QUE SI CUENTEN CON UN SEUDONIMO

SELECT *
FROM AUTORES
WHERE SEUDONIMO <=> NULL;
-- OTRA FORMA DE


/* HACER CONSULTA DE REGISTRO MEDIANTE RANGOS */

SELECT TITULO
FROM LIBROS
WHERE FECHA_PUBLICACION BETWEEN '1892-01-03' AND '1975-01-01';
-- TAMBIEN PODEMOS HACER CONSULTAS NO SOLO POR RANGO DE FECHA


/* HACER CONSULTA DE REGISTROS UNICOS */

SELECT DISTINCT TITULO
FROM LIBROS;
-- EN NUESTRA BASE DE DATOS HAY UN TITULO REPETIDO QUE PERTENCE A AUTORES DIFERENTES Y AL MOMENTO DE NOSOTROS CONSULTAR LOS TITULOS NOS SALDRA REPETIDO
-- ASI QUE USAREMOS LA CLAUSULA DISTINCT QUE NOS MOSTRARA SOLO UNA VEZ DICIENDO ASÍ QUE NOS MUESTRE UN DATO UNICO


/*ACTUALIZAR REGISTROS*/



UPDATE LIBROS
SET TITULO = 'Mi lucha veneca'
WHERE LIBRO_ID = 21; -- UPDATE NOS PERMITE ACTUALIZAR UN CAMPO DE UN REGISTRO Y SET ESTABLECER EL NUEVO CONTENIDO DEL CAMPO

UPDATE LIBROS
SET TITULO = ' Un libro comun '; -- ¡CUIDADO! UTILIZAR EL UPDATE Y EL SET SIN UTILIZAR UN WHERE ESTABLECERA EL VALOR PARA TODA LA TABLA SIN RESTRICCIONES

UPDATE AUTORES
SET APELLIDO = 'Hitler'
WHERE AUTOR_ID = 4;
SELECT *
FROM AUTORES;

/*ELIMINAR UN REGISTRO*/

DELETE
FROM LIBROS
WHERE AUTOR_ID = 5;
-- DELETE nos permite eliminar un registro y con la condicion WHERE escogerems que borrar
-- En este caso la sentencia eliminara todos los libros cuyo autor sea 5

DELETE
FROM LIBROS;
-- ¡ALERTA! NO SE USA EL WHERE BORRAREMOS TODA LA TABLA


/*ELIMINACION EN CASCADA

  nos permite eliminar datos que se encuentren referenciados en otra tabla es decir datos que sean llaves foraneas
  en otra tabla pero para ello debemos modificar la tabla original o sea de donde proviene ese dato (si es que tenemos ya la tabla con datos añadidos)
*/


SHOW CREATE TABLE LIBROS; -- PEDIMOS EUE NOS MUESTR TODA LA INFORMACIÓN DE LA CRAECION DE LA TABLA Y BUSCAMOS EL NOMBRE_CONSTRAINT

ALTER TABLE LIBROS
    DROP FOREIGN KEY LIBROS_ibfk_1; -- Primero eliminamos la llave foranea de la tabla libros que es donde esta referenciada

ALTER TABLE LIBROS
    ADD FOREIGN KEY (AUTOR_ID) REFERENCES AUTORES (AUTOR_ID) ON DELETE CASCADE;
-- luego añadimos de nuevo la llave foranea solo que con un cambio ON DELETE CASCADE; que nos permite eliminar directamente el autor asi este referenciada

DELETE
FROM AUTORES
WHERE AUTOR_ID = 5; -- procedemos a eliminar el autor con id 5 y no nos arrojara un error de identidad referncial porque donde se hace la referencia tiene el ON DELETE CASCADE

desc LIBROS;

-- SI VISUALIZAMOS VEREMOS QUE EL REGISTRO DEL AUTOR NO SE ENCUENTRA Y POR LO TANTO NINGUN LIBRO REGISTRADO QUE LE CORRESPONDA

SELECT *
FROM AUTORES;
SELECT *
FROM LIBROS;


/* PARA LA ELIMINACION DE LOS DATOS INCERTADOS EN UNA TABLA */

TRUNCATE TABLE LIBROS;
-- A DIFERENCIA DE USAR UN DELETE SIN UN WHERE EL TRUNCATE BORRA TODOS LOS METADATOS ES DECIR NO SE CONTAMINA LA TABLA DE METADATOS ANTIGUOS


/* FUNCIONES SOBRE STRINGS */

-- las funciones sobre strings son varias pero tocaremos las más importantes

SELECT CONCAT(NOMBRE, ' ', APELLIDO) as nombre_completo
FROM AUTORES;
-- concat nos permite concatenar dos columnas en este caso cuando queremos visualziar el nombre completo de un autor asi que concatenamos nombre y apellido

SELECT LENGTH('caracteres'); -- Length nos retorna la cantidad de caracteres que posee un string contando espacios

SELECT *
FROM AUTORES
WHERE LENGTH(NOMBRE) > 7; -- tambien podemos usar lenght para hacer consultas con una condicion especifica

SELECT UPPER(NOMBRE), LOWER(NOMBRE)
FROM AUTORES; -- upper y lower son funciones pensadas para el formato con upper veremos el string en mayuscula y con lower en miniscula

SELECT TRIM(NOMBRE)
FROM AUTORES; -- TRIM nos permite eliminar los prefijos y sufijos de un string por default serán los espacios del inicio y el final

SELECT LEFT('Esta es una cadena de caracteres', 5)   as substring_isquierdo,
       RIGHT('Esta es una cadena de caracteres', 10) as substring_derecho;

/*Left y right estas funciones reciben un string y un entero. Las funciones retornan
  la cantidad de caracteres que se indican en el entero left contando de isquierda a derecha y right de derecha a isquierda
 */


SELECT *
FROM LIBROS
WHERE LEFT(TITULO, (LENGTH('HarryPotter'))) = 'HarryPotter';
/*podemos usar estos para realizar consultas pedimos información de todos los libros que empiecen por harrypotter donde
  la izquierda del titulo (su inicio) cuente con la cantidad de caracteres sean las del titulo a consultar y que estan sean
  iguales al inicio del titulo que quermos consultar
 */


/*FUNCIONES SOSBRE FECHA   */

SELECT *
FROM LIBROS
WHERE CONVERT(FECHA_CREACION, DATE) = '2020-03-27';
/*podemos realizar consultas filtrando por fechas en este caso por fecha de creación. Debemos tener en cuenta
 que el tipo de dato es diferente por lo tanto debemos usar connvert para que el retorno del valor al
  consultar puesto que colcamos un valor con tipo de dato DATE y fecha de creación esta con DATETIME
*/


/*FUNCIONES SOBRE CONDICIONALES*/

SELECT IF(10 > 9, 'es mayor', ' no es mayor');
-- Select if necesita 3 parametros la condicion y dos valores que retornara en caso de que sea verdadero o falso

-- Se modificará la tabla libros para realizar un ejemplo de ocnsulta con if

update LIBROS
SET PAGINAS = 0
WHERE LIBRO_ID BETWEEN 1 AND 4;

-- consulta

SELECT IF(PAGINAS > 0, PAGINAS, 'NO TIENE PAGINAS')
FROM LIBROS;

-- Realizamos una inserción más en la tabla autores para realizar otro ejemplo del if

INSERT INTO AUTORES(nombre, apellido, seudonimo, genero, fecha_nacimiento, pais_origen)
    VALUE (  'Alister', 'Crowli',NULL, 'M', '1872-05-23','UK'
    );

update AUTORES
set SEUDONIMO = 'El profeta'
where AUTOR_ID = 7;

SELECT IF(SEUDONIMO is null, ((CONCAT(NOMBRE, ' ', APELLIDO, ' Seudonimo: ', 'No tiene seudonimo'))),
          (concat(NOMBRE, ' ', APELLIDO, '  Seudonimo: ', SEUDONIMO))) AS NOMBRE_SEUDONIMO
FROM AUTORES;
-- Consultamos que autores no tiene seudonimo




/* BUSQUEDAS ATRAVEZ DE STRINGS */


/*Realizar una consulta de un substring mediante el uso de LIKE colocaremos el string a buscar con el signo % al inicio
  si deseamos que esa palabra este al final o al final si deseamos saber si esta al inicio. pero si no sabemos donde esta
  podremos colcar dos % tanto al inicio como al final
 */
SELECT *
FROM LIBROS
WHERE TITULO LIKE 'HarryPotter%';

SELECT *
FROM LIBROS
WHERE TITULO LIKE '%Anillos';

SELECT *
FROM LIBROS
WHERE TITULO LIKE '%De%';

SELECT * FROM LIBROS WHERE TITULO REGEXP '^[EH]';-- Si queremos consultar titulos que comiencen con una letra O con otra podremos usar REGEXP

/* ORDENAR REGISTROS */

/*Ordenar los registros es una manera de manejar un orden en las consultas al colcoar ORDER BY
  automaticamente al realizar la consulta por defecto este se manerjara de orden ascendente
  a menos que especifiquemos otro orden por ejemplo de manera descendente desc */

SELECT TITULO FROM LIBROS ORDER BY TITULO ;
SELECT TITULO FROM LIBROS ORDER BY TITULO desc ;

SELECT LIBRO_ID, TITULO FROM LIBROS ORDER BY LIBRO_ID AND TITULO; -- Tambien podemos ordenar por dos campos como en este caso

/* LIMITAR REGISTROS */

/* Con limit podremos limitar la cantidad de registros que queremos visualizar. Tambien la cantidad
   de registros pertenecientes a un id o cualquier condicion que establezcamos */

SELECT * FROM LIBROS LIMIT 2;

SELECT * FROM LIBROS WHERE AUTOR_ID = 2 ;

SELECT LIBRO_ID,TITULO,AUTOR_ID FROM LIBROS LIMIT 0, 5; -- Estamos limitando la consulta estableciendo desde cual id empezar hasta cual terminar


