export class TicketsCliente {
    ticl_ID!: number;
    tckt_ID!: number;
    tckt_Nombre!: string;
    clie_ID!: number;
    clie_Nombres!: string;
    ticl_Cantidad!: number;
    pago_ID!: number;
    pago_Nombre!: String;        
    ticl_FechaCompra!: Date;
    ticl_FechaUso!: Date;
    ticl_Habilitado!: number;
    ticl_Estado!: number;
    ticl_UsuarioCreador!: number;
    usu_Crea!: string;
    ticl_FechaCreacion!: Date;
    ticl_UsuarioModificador!: number;
    usu_Modifica!: string;
    ticl_FechaModificacion!: number;
    empl_crea!: string;
    empl_Modifica!: string
}