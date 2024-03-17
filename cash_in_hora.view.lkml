
view: cash_in_hora {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'cash_in_command.fecha_final'


      SELECT
          (DATE(cash_in_command.Fecha_final )) AS cash_in_command_fecha_final,
          cash_in_command.Hora  AS cash_in_command_hora,
          COUNT(DISTINCT cash_in_command.Nuevo_id ) AS count_of_nuevo_id
      FROM `ligocloudplatform.app_lake.cash_in_command`  AS cash_in_command
      WHERE DATE_DIFF(CURRENT_DATE(),DATE(cash_in_command.Fecha_final ),DAY)<=7
      and name not in ('Cash Out - BBVA - Devoluciones','Cash Out - Interbank - Devoluciones','Cash Out - Scotiabank - Devoluciones'
      ,'Referidos TC','Referidos PP','Referidos Compras')
      GROUP BY
          1,
          2 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cash_in_command_fecha_final {
    type: date
    datatype: date
    sql: ${TABLE}.cash_in_command_fecha_final ;;
  }

  dimension: cash_in_command_hora {
    type: string
    sql: ${TABLE}.cash_in_command_hora ;;
  }

  dimension: count_of_nuevo_id {
    type: number
    sql: ${TABLE}.count_of_nuevo_id ;;
  }

  set: detail {
    fields: [
        cash_in_command_fecha_final,
  cash_in_command_hora,
  count_of_nuevo_id
    ]
  }
}
