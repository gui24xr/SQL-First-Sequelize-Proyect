/*
CREATE TABLE estados_turnos (
    id_estado_turno INT,
    estado_turno VARCHAR(30),
    PRIMARY KEY (id_estado_turno)
);
*/

export const estadosTurnosData = [
    'pendiente',
    'confirmado',
    'anunciado',
    'consultorio',
    'finalizado',
    'cancelado',
    'reprogramado',
    'ausente'
]