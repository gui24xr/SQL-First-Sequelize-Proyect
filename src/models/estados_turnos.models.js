/*
CREATE TABLE estados_turnos (
    id_estado_turno INT AUTO_INCREMENT,
    estado_turno VARCHAR(30),
    PRIMARY KEY (id_estado_turno)
);
*/
import { myDB } from "../connection.js";
import { DataTypes } from "sequelize";

export const EstadosTurnosModel = myDB.define('estados_turnos',{
    id_estado_turno : {
        type: DataTypes.INTEGER,
        autoIncrement:true,
        primaryKey: true,
        allowNull:false,
    },
    estado_turno :{
        type: DataTypes.STRING(30),
        allowNull: false
        
    }
},{tableName:'estados_turnos',timestamps: false})