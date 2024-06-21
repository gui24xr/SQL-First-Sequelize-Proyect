/*
TABLA: roles_empleados

Contiene los tipos de Roles de Empleados que existen en el consultorio en las distintas areas 
con lo cual mas adelante cruzaremos informacion y a cada empleado segun su rol vamos a darle 
un distinto tipo de usuario para el sistema.

CREATE TABLE roles_empleados(
    id_funcion INT AUTO_INCREMENT,
    funcion VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_funcion)
);


*/

import { myDB } from "../connection.js"
import { DataTypes } from "sequelize"


export const RolesEmpleadosModel = myDB.define('Roles_empleados',{
    id_funcion:{
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey:true
    },
    funcion:{
        type:DataTypes.STRING(30),
        allowNull : false
    }
},{
    tableName: 'roles_empleados', // Nombre de la tabla en la base de datos
    timestamps: false, // Opcional: deshabilita los campos de timestamps automáticos (createdAt y updatedAt)
})