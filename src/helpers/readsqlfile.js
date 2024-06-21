import { promises as fs } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';




export function getScriptPath(pathString){
    // Obtener el nombre del archivo y el directorio actual
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);

    // Ruta al archivo .sql
    return path.join('src', pathString);

}


// Leer el archivo .sql
export async function readSqlFile(filePath) {
    try {
        const data = await fs.readFile(filePath, 'utf8');
        // Eliminar completamente los saltos de línea
        const sqlString = data.replace(/\r?\n/g, '');
        //console.log('Contenido del archivo .sql como string:');
        //console.log(sqlString);
        return sqlString;
    } catch (err) {
        console.error('Error al leer el archivo:', err);
        throw err; // Importante para manejar el error en la llamada a la función
    }
}