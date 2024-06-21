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

export const prestacionesData = [
    { obra_social : 'PARTICULAR',plan:'S/N',activa:true},
    { obra_social : 'GALENO',plan:'S/N',activa:true},
    { obra_social : 'OSDE',plan:'S/N',activa:true},
    { obra_social : 'OSECACO',plan:'S/N',activa:true},
    { obra_social : 'MEDICSOC',plan:'S/N',activa:true},
    { obra_social : 'PLOMA',plan:'S/N',activa:true},
    { obra_social : 'MEDICPLAN',plan:'S/N',activa:true},
    { obra_social : 'MEDICUS',plan:'S/N',activa:true},
    { obra_social : 'SALUPLAN',plan:'S/N',activa:true},
]