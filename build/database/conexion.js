"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppDataSource = void 0;
const typeorm_1 = require("typeorm");
const equipoModel_1 = require("../models/equipoModel");
const tipoEquipoModel_1 = require("../models/tipoEquipoModel");
const cuentaDanteModel_1 = require("../models/cuentaDanteModel");
const mantenimientoModel_1 = require("../models/mantenimientoModel");
const usuarioModel_1 = require("../models/usuarioModel");
const rolModel_1 = require("../models/rolModel");
const estadoModel_1 = require("../models/estadoModel");
const chequeoModel_1 = require("../models/chequeoModel");
const areaModel_1 = require("../models/areaModel");
const ChequeoMantenimiento_1 = require("../models/ChequeoMantenimiento");
const dotenv_1 = require("dotenv");
(0, dotenv_1.config)();
exports.AppDataSource = new typeorm_1.DataSource({
    type: "mysql",
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    logging: true,
    entities: [equipoModel_1.Equipo, tipoEquipoModel_1.TipoEquipo, cuentaDanteModel_1.CuentaDante, mantenimientoModel_1.Mantenimiento, usuarioModel_1.Usuario, rolModel_1.Rol, estadoModel_1.Estado, chequeoModel_1.Chequeo, areaModel_1.Area, ChequeoMantenimiento_1.ChequeoMantenimiento],
    synchronize: false
});
exports.AppDataSource.initialize()
    .then(() => {
    console.log('Data Source ha sido inicializada!');
})
    .catch((err) => {
    console.error('Ha ocurrido un error en la Data Source:', err);
});