/*

-- Tabla especialidades
CREATE TABLE especialidades (
    id_especialidad INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    PRIMARY KEY (id_especialidad)
);
*/

import { myDB } from "../connection.js"
import { DataTypes } from "sequelize"

export const EspecialidadesMedicasModels = myDB.define('especialidades_medicas',{
    id_especialidad:{
        type: DataTypes.INTEGER,
        autoIncrement:true,
        primaryKey: true
    },
    nombre:{
        type: DataTypes.STRING(100),
        allowNull: false
    }
},{tableName:'especialidades_medicas',timestamps:false})
