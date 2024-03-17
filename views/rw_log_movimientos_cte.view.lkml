view: rw_log_movimientos_cte {
  sql_table_name: `ligocloudplatform.lake.rw_log_movimientos_cte` ;;

  dimension: abono {
    type: number
    sql: ${TABLE}.Abono ;;
  }
  dimension: anio_txn {
    type: string
    sql: ${TABLE}.Anio_Txn ;;
  }
  dimension: bia {
    type: string
    sql: ${TABLE}.bia ;;
  }
  dimension: cargo {
    type: number
    sql: ${TABLE}.Cargo ;;
  }
  dimension: clase_txn {
    type: number
    sql: ${TABLE}.Clase_Txn ;;
  }
  dimension: codigo_autorizacion {
    type: string
    sql: ${TABLE}.Codigo_Autorizacion ;;
  }
  dimension: codigo_establecimiento {
    type: string
    sql: ${TABLE}.Codigo_Establecimiento ;;
  }
  dimension: codigo_institucion {
    type: string
    sql: ${TABLE}.Codigo_Institucion ;;
  }
  dimension: codigo_txn {
    type: number
    sql: ${TABLE}.Codigo_Txn ;;
  }
  dimension: com_auto_inter {
    type: number
    sql: ${TABLE}.Com_AutoInter ;;
  }
  dimension: com_merchant {
    type: number
    sql: ${TABLE}.Com_Merchant ;;
  }
  dimension: com_residencia {
    type: number
    sql: ${TABLE}.Com_Residencia ;;
  }
  dimension: com_retiro_inter {
    type: number
    sql: ${TABLE}.Com_RetiroInter ;;
  }
  dimension: com_total {
    type: number
    sql: ${TABLE}.Com_Total ;;
  }
  dimension: com_tpp {
    type: number
    sql: ${TABLE}.Com_TPP ;;
  }
  dimension: com_txn_visa {
    type: number
    sql: ${TABLE}.Com_TxnVISA ;;
  }
  dimension: com_uba {
    type: number
    sql: ${TABLE}.Com_UBA ;;
  }
  dimension: com_visa_1 {
    type: number
    sql: ${TABLE}.Com_Visa_1 ;;
  }
  dimension: com_visa_2 {
    type: number
    sql: ${TABLE}.Com_Visa_2 ;;
  }
  dimension: com_visa_prepago {
    type: number
    sql: ${TABLE}.Com_VisaPrepago ;;
  }
  dimension: com_vva {
    type: number
    sql: ${TABLE}.Com_VVA ;;
  }
  dimension: comision_foranea {
    type: number
    sql: ${TABLE}.Comision_Foranea ;;
  }
  dimension: comision_fx {
    type: string
    sql: ${TABLE}.Comision_FX ;;
  }
  dimension: descripcion_extra_1 {
    type: string
    sql: ${TABLE}.Descripcion_Extra_1 ;;
  }
  dimension: descripcion_institucion {
    type: string
    sql: ${TABLE}.Descripcion_Institucion ;;
  }
  dimension: descripcion_txn {
    type: string
    sql: ${TABLE}.Descripcion_Txn ;;
  }
  dimension: dia_txn {
    type: string
    sql: ${TABLE}.Dia_Txn ;;
  }
  dimension_group: fecha_creacion {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.fecha_creacion ;;
  }
  dimension: fecha_proceso {
    type: string
    sql: ${TABLE}.Fecha_Proceso ;;
  }
  dimension: fecha_txn {
    type: string
    sql: ${TABLE}.Fecha_Txn ;;
  }
  dimension: hora_txn {
    type: string
    sql: ${TABLE}.Hora_Txn ;;
  }
  dimension: id_cta_cte {
    type: number
    sql: ${TABLE}.Id_CtaCte ;;
  }
  dimension: id_db {
    type: string
    sql: ${TABLE}.id_db ;;
  }
  dimension: identificador_terminal {
    type: string
    sql: ${TABLE}.Identificador_Terminal ;;
  }
  dimension: mes_txn {
    type: string
    sql: ${TABLE}.Mes_Txn ;;
  }
  dimension: nombre_tarjetahabiente {
    type: string
    sql: ${TABLE}.Nombre_Tarjetahabiente ;;
  }
  dimension: numero_tarjeta {
    type: string
    sql: ${TABLE}.Numero_Tarjeta ;;
  }
  dimension: numero_tarjeta_destino {
    type: string
    sql: ${TABLE}.Numero_Tarjeta_Destino ;;
  }
  dimension: procesado {
    type: string
    sql: ${TABLE}.Procesado ;;
  }
  dimension: registro_inter_bines {
    type: string
    sql: ${TABLE}.registro_inter_bines ;;
  }
  dimension: saldo {
    type: number
    sql: ${TABLE}.Saldo ;;
  }
  dimension: secuencia_transaccion {
    type: string
    sql: ${TABLE}.Secuencia_Transaccion ;;
  }
  dimension: sucursal {
    type: string
    sql: ${TABLE}.Sucursal ;;
  }
  dimension: tipo_cambio {
    type: number
    sql: ${TABLE}.Tipo_Cambio ;;
  }
  dimension: trace {
    type: string
    sql: ${TABLE}.Trace ;;
  }
  dimension: usuario_creacion {
    type: string
    sql: ${TABLE}.usuario_creacion ;;
  }
  dimension: utilidad_total {
    type: number
    sql: ${TABLE}.Utilidad_Total ;;
  }
  dimension: valor_dolares {
    type: number
    sql: ${TABLE}.Valor_Dolares ;;
  }
  dimension: vista {
    type: string
    sql: ${TABLE}.vista ;;
  }
  measure: count {
    type: count
  }
}
