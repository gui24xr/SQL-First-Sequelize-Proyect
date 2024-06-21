import { myDB } from "../connection.js";
import { DataTypes } from "sequelize";

/*
CREATE TABLE usuarios_sistema (
    dni VARCHAR(30) NOT NULL,
    email VARCHAR(254),
    contraseña VARCHAR(24),
    rol INT,
    habilitado BOOLEAN,
    PRIMARY KEY (dni),
    FOREIGN KEY (dni) REFERENCES datos_personales(dni),
    FOREIGN KEY (rol) REFERENCES roles_usuario_sistema(id_user_rol)
);
*/

export const UsuariosSistemaModel = myDB.define('Usuarios_sistema',{
    dni:{
        type : DataTypes.STRING(30),
        primaryKey : true,
        allowNull : false,
        references : {
            model: 'datos_personales',
            key: 'dni'
        }
    },
    email:{
        type : DataTypes.STRING(254)
    },
    contraseña :{
        type: DataTypes.STRING(24)
    },
    rol : {
        type: DataTypes.INTEGER,
        references:{
            model: 'roles_usuario_sistema',
            key: 'id_user_rol'
        }
    },
    habilitado: {
        type : DataTypes.BOOLEAN
    }

},{
    tableName: 'usuarios_sistema', // Nombre de la tabla en la base de datos
    timestamps: false, // Opcional: deshabilita los campos de timestamps automáticos (createdAt y updatedAt)
})



