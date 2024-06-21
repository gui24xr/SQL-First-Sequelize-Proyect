/*
Contiene el listado de consultorios existentes y la informacion de si 
estan disponibles o no en el momento que se necesite tener esa informacion cuando ingresa un 
medico y necesita se le asigne su lugar de trabajo del dia.

-- Tabla de Consultorios
CREATE TABLE consultorios (
    numero_consultorio INT,
    en_servicio BOOLEAN,
    PRIMARY KEY (numero_consultorio)
);
*/

import { myDB } from "../connection.js";
import { DataTypes } from "sequelize";

export const ConsultoriosModel = myDB.define('consultorios',{
    numero_consultorio:{
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement:false,
    },
    en_servicio:{
        type: DataTypes.BOOLEAN,
        allowNull: false
    }

},{tableName:'consultorios',timestamps:false})