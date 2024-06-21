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

export const rolesEmpleadosData = [
    'limpieza',
    'administracion',
    'mantenimiento',
    'recepcion',
    'cocina',
    'enfermeria'
]