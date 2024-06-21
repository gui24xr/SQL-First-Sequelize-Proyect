/*
TABLA: datos_personales
Esta tabla contiene los datos personales de todas las personas ya sea puedan operar o no en el sistema. 
Tiene los datos personales de pacientes, medicos, empleados, etc.

-- Tabla de Datos Personales
CREATE TABLE datos_personales (
    dni VARCHAR(30),
    nombre1 VARCHAR(255),
    nombre2 VARCHAR(255),
    apellido VARCHAR(255),
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    codigo_postal VARCHAR(10),
    telefono_contacto_1 VARCHAR(30),
    telefono_contacto_2 VARCHAR(30),
    telefono_contacto_urgencia VARCHAR(30),
    email_contacto VARCHAR(254),
    PRIMARY KEY (dni)
);
*/
import { myDB } from "../connection.js";
import { DataTypes } from "sequelize";

export const DatosPersonalesModel = myDB.define('datos_personales',{
    dni:{
        type: DataTypes.STRING(30),
    }

},{tableName:'datos_personales', timestamps: false})