import { Sequelize } from "sequelize";

//Creo la conexion a la base de datos.
const DB_NAME = 'administracionconsultorios'
const DB_USER = 'root'//'gui24'
const DB_PASSWORD = 'CBR2485giant#'
const CONNECTION_VALUES = {host:'localhost',port:'3307',dialect:'mysql',  dialectOptions: {multipleStatements: true }}

//Creo la referencia a mi base de datos.
export const myDB = new Sequelize(DB_NAME,DB_USER,DB_PASSWORD,CONNECTION_VALUES)
//Inicio sesion en ella.
myDB.authenticate()
.then(console.log('Conectado a la base de datos OK !!!',))
.catch(res => console.log('Falla al conectarse !!!', res))