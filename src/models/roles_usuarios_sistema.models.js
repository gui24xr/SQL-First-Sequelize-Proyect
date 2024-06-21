import { myDB } from "../connection.js";
import { DataTypes } from "sequelize";

/*
CREATE TABLE roles_usuario_sistema(
    id_user_rol INT AUTO_INCREMENT,
    rol VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_user_rol)
);
*/

export const RolesUsuarioSistemaModel = myDB.define('Roles_usuario_sistema',{
    id_user_rol:{
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey:true
    },
    rol:{
        type: DataTypes.STRING(30),
        allowNull: false
    }

    }

,{
    tableName: 'roles_usuario_sistema', // Nombre de la tabla en la base de datos
    timestamps: false, // Opcional: deshabilita los campos de timestamps automáticos (createdAt y updatedAt)
})
