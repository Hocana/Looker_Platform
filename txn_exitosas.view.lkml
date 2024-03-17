
view: txn_exitosas {
  derived_table: {
    sql: select 
      1- SUM(FLG_RECHAZO)/COUNT(name) ratio
      ,Fecha
      from
      (select 
      distinct LEFT(Fecha_final,10) as Fecha
      ,Hora
      ,name
      ,Estado
      ,case when Estado in ('E','B','A','failed','Fallido','blacklist') then 1 else 0
      end as FLG_RECHAZO
       from 
      (select 
      Fecha_final
      ,Hora
        ,name
      ,Estado
       from 
      ligocloudplatform.app_lake.analisis_transacciones_operaciones 
      UNION ALL
      select distinct
      LEFT(createdAt,10) AS Fecha
      ,LEFT(cast(Hora as string),2) Hora
      ,case when nameEvent='cashback_transaction_failed' then 'Cashback'
      when nameEvent='payoneer_transaction_failed' then 'Payoneer'
      when nameEvent='cashin_inapp_transaction_failed' then 'Izipay'
      when nameEvent='paypal_transaction_failed' then 'PayPal'
      end as name
      ,'Fallido' as Estado
      from 
      ligocloudplatform.lake.rw_tb_eventos 
      where nameEvent in ('cashback_transaction_failed','payoneer_transaction_failed','cashin_inapp_transaction_failed'
      ,'paypal_transaction_failed') 
      UNION ALL
      select 
      Fecha_f
      ,LEFT(Hora,2) as Hora
      ,Producto
      ,estado
       from 
      ligocloudplatform.app_lake.analisis_transacciones_cash_out
      where Producto in ('P2P')
      )
      where Estado not in ('Cash Out - BBVA - Devoluciones','Cash Out - Interbank - Devoluciones','Cash Out - Scotiabank - Devoluciones','Referidos TC',
      'Referidos PP','Referidos Compras')
      )A
      where DATE_DIFF(CURRENT_DATE(),CAST(Fecha as date),DAY)<=7
      group by 2
      order by 2 desc ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ratio {
    type: number
    sql: ${TABLE}.ratio ;;
  }

  dimension: fecha {
    type: string
    sql: ${TABLE}.Fecha ;;
  }

  set: detail {
    fields: [
        ratio,
	fecha
    ]
  }
}
