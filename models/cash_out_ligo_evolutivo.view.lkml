
view: cash_out_ligo_evolutivo {
  derived_table: {
    sql: select DISTINCT  CONCAT(Clase_Txn,Codigo_Txn) as codigo,Descripcion_Txn,
      cast(CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as date) as Fecha  ,CASE 
        when dtim.day_name_of_week in ('Sunday') then ('7. Domingo')
        when dtim.day_name_of_week in ('Saturday') then ('6. Sabado')
        when dtim.day_name_of_week in ('Friday') then ('5. Viernes')
        when dtim.day_name_of_week in ('Thursday') then ('4. Jueves')
        when dtim.day_name_of_week in ('Wednesday') then ('3. Miercoles')
        when dtim.day_name_of_week in ('Tuesday') then ('2. Martes')
        when dtim.day_name_of_week in ('Monday') then ('1. Lunes')
      END Dia,CASE 
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5961') then ('Interbank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5957') then ('Scotiabank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5953') then ('BBVA')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5949') then ('BCP')
      END as Banco,cte.Numero_Tarjeta,CASE 
        when left(cte.Numero_Tarjeta,4) in ('4100') then 'Dolares' else 'Soles'
      END as Moneda,cte.Id_CtaCte,cte.Cargo as Monto
      from ligocloudplatform.lake.rw_log_movimientos_cte cte
      left join ligocloudplatform.app_lake.dim_time dtim on cast(CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as date) =dtim.`date` 
      where CONCAT(Clase_Txn,Codigo_Txn) in ('5953','5949','5961','5957') ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: codigo {
    type: string
    sql: ${TABLE}.codigo ;;
  }

  dimension: descripcion_txn {
    type: string
    sql: ${TABLE}.Descripcion_Txn ;;
  }

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.Fecha ;;
  }

  dimension: dia {
    type: string
    sql: ${TABLE}.Dia ;;
  }

  dimension: banco {
    type: string
    sql: ${TABLE}.Banco ;;
  }

  dimension: numero_tarjeta {
    type: string
    sql: ${TABLE}.Numero_Tarjeta ;;
  }

  dimension: moneda {
    type: string
    sql: ${TABLE}.Moneda ;;
  }

  dimension: id_cta_cte {
    type: number
    sql: ${TABLE}.Id_CtaCte ;;
  }

  dimension: monto {
    type: number
    sql: ${TABLE}.Monto ;;
  }

  set: detail {
    fields: [
        codigo,
	descripcion_txn,
	fecha,
	dia,
	banco,
	numero_tarjeta,
	moneda,
	id_cta_cte,
	monto
    ]
  }
}
