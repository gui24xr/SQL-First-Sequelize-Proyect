
import { myDB } from "./connection.js"
import { 
    RolesUsuarioSistemaModel,
    RolesEmpleadosModel,
    EstadosTurnosModel,
    PrestacionesModel,
    ConsultoriosModel,
    EspecialidadesMedicasModels
} from "./models/models.js"

import { 
    rolesUsuarioData,
    rolesEmpleadosData,
    estadosTurnosData,
    prestacionesData,
    consultoriosData,
    especialidadesMedicasData,

 } from "./data/data.js"

/*
let responseQuery = await myDB.query("SHOW TABLES",{type: myDB.QueryTypes.SHOWTABLES})
console.log(responseQuery)
*/

/*
const user = await UsuariosSistema.create({
    dni: '31823844', // Ejemplo de dni
    email: 'usuario@example.com',
    contraseña: 'password123',
    rol: 1, // Ejemplo de id de rol
    habilitado: true
})
*/

//----------------------------------------------------------------------
async function seedTable1(){
    //POBLAR TABLA roles_usuario_sistema.
    const records_rolesUsuario = rolesUsuarioData.map(item => ({rol:item})) 
    await RolesUsuarioSistemaModel.bulkCreate(records_rolesUsuario)
    //POBLAR TABLA roles_empleados.
    const records_rolesEmpleados = rolesEmpleadosData.map(item => ({funcion:item}))
    await RolesEmpleadosModel.bulkCreate(records_rolesEmpleados)
    //POBLAR TABLA estados_turnos
    const records_estadosTurnos = estadosTurnosData.map( item => ({estado_turno : item}))
    await EstadosTurnosModel.bulkCreate(records_estadosTurnos)
    //POBLAR TABLA prestaciones
    await PrestacionesModel.bulkCreate(prestacionesData)
    //Poblar TABLA consultorios
    await ConsultoriosModel.bulkCreate(consultoriosData)
    //Poblar Tabla especialidades_medicas
    const records_especialidadesMedicas = especialidadesMedicasData.map(item => ({ nombre:item}))
    await EspecialidadesMedicasModels.bulkCreate(records_especialidadesMedicas)
}


async function seedTable2(){

}

//await seedTable1()
//awaot seedTable2()