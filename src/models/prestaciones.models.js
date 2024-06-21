/*
TABLA: prestaciones

Contiene los tipos de prestaciones de obra social y planes que estaran disponibles. 
De este modo podremos alimentar desde nuestro backend a nuestro frontend para que el usuario del sistema elija la 
prestacion con la cual se llevara a cabo la atencion por parte del medico. Si bien es cierto que podriamos tener 
aparte una tabla obras sociales es practico por el momento manejarlo de esta manera ya que de otra forma habria 
que trabajar con APIS de obras sociales y por el momento no es suficiente trabajar con este metodo. 
Tambien contiene esta tabla un campo llamado -activa- que es un boolean que indicara si en 
el momento de otorgar el turno o hacer la prestacion la misma se encuentra activa.

-- Tabla de Prestaciones
CREATE TABLE prestaciones (
    id_prestacion INT AUTO_INCREMENT,
    obra_social VARCHAR(255),
    plan VARCHAR(255),
    activa BOOLEAN,
    PRIMARY KEY (id_prestacion)
);

*/

import { myDB } from "../connection.js";
import { DataTypes } from "sequelize";

export const PrestacionesModel = myDB.define('prestaciones',{
id_prestacion:{
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true
},
obra_social:{
    type: DataTypes.STRING(255),
    allowNull: false
},
plan:{
    type: DataTypes.STRING(255),
    allowNull: false
},
activa:{
    type: DataTypes.BOOLEAN,
    allowNull:false
}



},
{tableName:'prestaciones',timestamps:false})