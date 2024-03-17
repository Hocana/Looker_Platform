view: dim_dash_resumen_producto_grafico {
  sql_table_name: `ligocloudplatform.app_lake.dim_dash_resumen_producto_grafico` ;;

  dimension: card_id {
    type: number
    sql: ${TABLE}.card_id ;;
  }
  dimension: card_number {
    type: string
    sql: ${TABLE}.card_number ;;
  }
  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }
  dimension: document_number {
    type: string
    sql: ${TABLE}.document_number ;;
  }
  dimension_group: fecha {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Fecha ;;
  }
  dimension: mercado {
    type: string
    sql: ${TABLE}.Mercado ;;
  }
  dimension: tipo {
    type: string
    sql: ${TABLE}.tipo ;;
  }
  dimension: tipo_transaccion {
    type: string
    sql: ${TABLE}.tipo_transaccion ;;
  }
  dimension: transaction_id {
    type: number
    sql: ${TABLE}.transaction_id ;;
  }
  dimension: volumen {
    type: number
    sql: ${TABLE}.Volumen ;;
  }
  measure: count {
    type: count
  }
}
