view: analisis_transacciones_operaciones {
  sql_table_name: `ligocloudplatform.app_lake.analisis_transacciones_operaciones` ;;

  dimension: ayer {
    type: yesno
    sql: ${TABLE}.Ayer ;;
  }
  dimension: bin {
    type: string
    sql: ${TABLE}.Bin ;;
  }
  dimension: canal {
    type: string
    sql: ${TABLE}.Canal ;;
  }
  dimension: codigo_seguimiento {
    type: string
    sql: ${TABLE}.Codigo_Seguimiento ;;
  }
  dimension: comision_payoneer {
    type: string
    sql: ${TABLE}.Comision_Payoneer ;;
  }
  dimension: comision_paypal {
    type: string
    sql: ${TABLE}.Comision_Paypal ;;
  }
  dimension: created_at {
    type: string
    sql: ${TABLE}.createdAt ;;
  }
  dimension: dia_semana {
    type: string
    sql: ${TABLE}.Dia_Semana ;;
  }
  dimension: dia_semana_fecha {
    type: string
    sql: ${TABLE}.Dia_semana_fecha ;;
  }
  dimension: estado {
    type: string
    sql: ${TABLE}.Estado ;;
  }
  dimension_group: fec_registro {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Fec_Registro ;;
  }
  dimension: fecha {
    type: string
    sql: ${TABLE}.Fecha ;;
  }
  dimension: fecha_final {
    type: string
    sql: ${TABLE}.Fecha_final ;;
  }
  dimension: fecha_recarga {
    type: string
    sql: ${TABLE}.Fecha_Recarga ;;
  }
  dimension: hora {
    type: number
    sql: ${TABLE}.Hora ;;
  }
  dimension: hoy {
    type: yesno
    sql: ${TABLE}.Hoy ;;
  }
  dimension: id_bancos {
    type: string
    sql: ${TABLE}.id_bancos ;;
  }
  dimension: id_paypal {
    type: string
    sql: ${TABLE}.Id_Paypal ;;
  }
  dimension: llave_conciliacion {
    type: string
    sql: ${TABLE}.Llave_Conciliacion ;;
  }
  dimension: moneda {
    type: string
    sql: ${TABLE}.Moneda ;;
  }
  dimension: moneda_descripcion {
    type: string
    sql: ${TABLE}.moneda_descripcion ;;
  }
  dimension: moneda_pay_pal {
    type: string
    sql: ${TABLE}.Moneda_PayPal ;;
  }
  dimension: moneda_payoneer {
    type: string
    sql: ${TABLE}.Moneda_Payoneer ;;
  }
  dimension: monto {
    type: string
    sql: ${TABLE}.monto ;;
  }
  dimension: monto_final {
    type: number
    sql: ${TABLE}.Monto_Final ;;
  }
  dimension: monto_payoneer {
    type: string
    sql: ${TABLE}.Monto_Payoneer ;;
  }
  dimension: monto_paypal {
    type: string
    sql: ${TABLE}.Monto_Paypal ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: nuevo_id {
    type: string
    sql: ${TABLE}.Nuevo_id ;;
  }
  dimension: numero_documento {
    type: string
    sql: ${TABLE}.Numero_Documento ;;
  }
  dimension: numero_tarjeta {
    type: string
    sql: ${TABLE}.Numero_Tarjeta ;;
  }
  dimension: tarjeta {
    type: string
    sql: ${TABLE}.Tarjeta ;;
  }
  dimension: ultimos_30_dias {
    type: yesno
    sql: ${TABLE}.Ultimos_30_dias ;;
  }
  dimension: ultimos_7_dias {
    type: yesno
    sql: ${TABLE}.Ultimos_7_dias ;;
  }
  measure: count {
    type: count
    drill_fields: [name]
  }
}
