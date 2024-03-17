view: cash_in_command {
  sql_table_name: `ligocloudplatform.app_lake.cash_in_command` ;;

  dimension: created_at {
    type: string
    sql: ${TABLE}.createdAt ;;
  }
  dimension: dia_semana {
    type: string
    sql: ${TABLE}.Dia_Semana ;;
  }
  dimension: estado {
    type: string
    sql: ${TABLE}.Estado ;;
  }
  dimension: fecha_final {
    type: date
    sql: ${TABLE}.Fecha_final ;;
  }
  dimension: hora {
    type: string
    sql: ${TABLE}.Hora ;;
  }
  dimension: moneda {
    type: string
    sql: ${TABLE}.Moneda ;;
  }
  dimension: monto_final {
    type: number
    sql: ${TABLE}.Monto_Final ;;
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
  measure: count {
    type: count
    drill_fields: [name]
  }
}
