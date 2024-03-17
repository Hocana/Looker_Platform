view: monitoreo_cashin_web_operaciones {
  sql_table_name: `ligocloudplatform.lake.monitoreo_cashin_web_operaciones` ;;

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
  dimension: estado {
    type: string
    sql: ${TABLE}.Estado ;;
  }
  dimension: fecha {
    type: string
    sql: ${TABLE}.Fecha ;;
  }
  dimension: fecha_recarga {
    type: string
    sql: ${TABLE}.Fecha_Recarga ;;
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
  dimension: monto_payoneer {
    type: string
    sql: ${TABLE}.Monto_Payoneer ;;
  }
  dimension: monto_paypal {
    type: string
    sql: ${TABLE}.Monto_Paypal ;;
  }
  dimension: numero_tarjeta {
    type: string
    sql: ${TABLE}.Numero_Tarjeta ;;
  }
  measure: count {
    type: count
  }
}
