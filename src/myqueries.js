import { myDB } from "./connection.js";
import { readSqlFile, getScriptPath } from "./helpers/readsqlfile.js"; //Funcion para convertir el script sql en string.

console.log('MyQuerys Esta Rodando !!')


const createDbAndTablesScript = await readSqlFile(getScriptPath('./mysql_scripts/script_creacion_tablas.sql'))
const viewTablesScript = await readSqlFile(getScriptPath('./mysql_scripts/viewtables.sql'))
const randomTests = await readSqlFile(getScriptPath('./mysql_scripts/randomtests.sql'))


console.log(randomTests)
const [results,metadata] = await myDB.query(randomTests);

        // Mostrar los resultados en forma de tabla
        //console.log(results);
results.forEach(item => console.table(item))
