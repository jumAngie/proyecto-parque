import { NgItemLabelDirective } from "@ng-select/ng-select";

export class VentasQuiosco
{
    vent_ID!: number;
    quio_ID!: number;
    quio_Nombre!: String;
    area_Nombre!: String;
    regi_Nombre!: String;
    quio_ReferenciaUbicacion!: String;
    quio_Imagen!: String;
    clie_ID!: number;
    clie_Nombres!: String;
    clie_Apellidos!: String;
    vent_ClienteNombreCompleto!: String;
    clie_DNI!: String;
    clie_Telefono!: String;
    pago_ID!: number;
    pago_Nombre!: String;
    vent_Habilitado!: number;
    vent_Estado!: number;
    empl_crea!: String;
    empl_modifica!: String;
    vent_UsuarioCreador!: number;
    vent_UsuarioCreador_Nombre!: String;
    vent_FechaCreacion!: String;
    vent_UsuarioModificador!: number;
    vent_UsuarioModificador_Nombre!: String;
    vent_FechaModificacion!: String;
    }