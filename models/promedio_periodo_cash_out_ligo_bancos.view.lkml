
view: promedio_periodo_cash_out_ligo_bancos {
  derived_table: {
    sql: select D.*
      ,L.Promedio_Lunes
      ,SD.Promedio_SD
      from
      (Select S.Banco
      ,substr(Fecha,1,4) as Anio
      ,Semana
      ,avg(Monto) Promedio_diario
      from
      (select DISTINCT  CONCAT(Clase_Txn,Codigo_Txn) as codigo,Descripcion_Txn,
      CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as Fecha  ,CASE 
        when dtim.day_name_of_week in ('Sunday') then ('7. Domingo')
        when dtim.day_name_of_week in ('Saturday') then ('6. Sabado')
        when dtim.day_name_of_week in ('Friday') then ('5. Viernes')
        when dtim.day_name_of_week in ('Thursday') then ('4. Jueves')
        when dtim.day_name_of_week in ('Wednesday') then ('3. Miercoles')
        when dtim.day_name_of_week in ('Tuesday') then ('2. Martes')
        when dtim.day_name_of_week in ('Monday') then ('1. Lunes')
      END Dia
      ,EXTRACT(ISOWEEK from dtim.date) as Semana
      ,CASE 
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5961') then ('Interbank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5957') then ('Scotiabank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5953') then ('BBVA')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5949') then ('BCP')
      END as Banco,cte.Numero_Tarjeta,CASE 
        when left(cte.Numero_Tarjeta,4) in ('4100') then 'Dolares' else 'Soles'
      END as Moneda,cte.Id_CtaCte,cte.Cargo as Monto
      from ligocloudplatform.lake.rw_log_movimientos_cte cte
      left join ligocloudplatform.app_lake.dim_time dtim on cast(CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as date) =dtim.`date` 
      where CONCAT(Clase_Txn,Codigo_Txn) in ('5953','5949','5961','5957')
      )S
      --where Moneda='Soles'
      group by 1,2,3
      )D
      left join 
      (Select S.Banco
      ,substr(Fecha,1,4) as Anio
      ,Semana
      ,avg(Monto) Promedio_Lunes
      from
      (select DISTINCT  CONCAT(Clase_Txn,Codigo_Txn) as codigo,Descripcion_Txn,
      CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as Fecha  ,CASE 
        when dtim.day_name_of_week in ('Sunday') then ('7. Domingo')
        when dtim.day_name_of_week in ('Saturday') then ('6. Sabado')
        when dtim.day_name_of_week in ('Friday') then ('5. Viernes')
        when dtim.day_name_of_week in ('Thursday') then ('4. Jueves')
        when dtim.day_name_of_week in ('Wednesday') then ('3. Miercoles')
        when dtim.day_name_of_week in ('Tuesday') then ('2. Martes')
        when dtim.day_name_of_week in ('Monday') then ('1. Lunes')
      END Dia
      ,EXTRACT(ISOWEEK from dtim.date) as Semana
      ,CASE 
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5961') then ('Interbank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5957') then ('Scotiabank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5953') then ('BBVA')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5949') then ('BCP')
      END as Banco,cte.Numero_Tarjeta,CASE 
        when left(cte.Numero_Tarjeta,4) in ('4100') then 'Dolares' else 'Soles'
      END as Moneda,cte.Id_CtaCte,cte.Cargo as Monto
      from ligocloudplatform.lake.rw_log_movimientos_cte cte
      left join ligocloudplatform.app_lake.dim_time dtim on cast(CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as date) =dtim.`date` 
      where CONCAT(Clase_Txn,Codigo_Txn) in ('5953','5949','5961','5957')
      )S
      where
      -- Moneda='Soles' and 
      Dia='1. Lunes'
      group by 1,2,3
      )L
      on L.Banco=D.Banco and L.Anio=D.Anio
      and L.Semana=D.Semana
      left join 
      (Select S.Banco
      ,substr(Fecha,1,4) as Anio
      ,Semana
      ,avg(Monto) Promedio_SD
      from
      (select DISTINCT  CONCAT(Clase_Txn,Codigo_Txn) as codigo,Descripcion_Txn,
      CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as Fecha  ,CASE 
        when dtim.day_name_of_week in ('Sunday') then ('7. Domingo')
        when dtim.day_name_of_week in ('Saturday') then ('6. Sabado')
        when dtim.day_name_of_week in ('Friday') then ('5. Viernes')
        when dtim.day_name_of_week in ('Thursday') then ('4. Jueves')
        when dtim.day_name_of_week in ('Wednesday') then ('3. Miercoles')
        when dtim.day_name_of_week in ('Tuesday') then ('2. Martes')
        when dtim.day_name_of_week in ('Monday') then ('1. Lunes')
      END Dia
      ,EXTRACT(ISOWEEK from dtim.date) as Semana
      ,CASE 
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5961') then ('Interbank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5957') then ('Scotiabank')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5953') then ('BBVA')
        when CONCAT(Clase_Txn,Codigo_Txn) in ('5949') then ('BCP')
      END as Banco,cte.Numero_Tarjeta,CASE 
        when left(cte.Numero_Tarjeta,4) in ('4100') then 'Dolares' else 'Soles'
      END as Moneda,cte.Id_CtaCte,cte.Cargo as Monto
      from ligocloudplatform.lake.rw_log_movimientos_cte cte
      left join ligocloudplatform.app_lake.dim_time dtim on cast(CONCAT(Anio_Txn,'-',Mes_Txn,'-',Dia_Txn) as date) =dtim.`date` 
      where CONCAT(Clase_Txn,Codigo_Txn) in ('5953','5949','5961','5957')
      )S
      where 
      --Moneda='Soles' and 
      Dia in ('6. Sabado','7. Domingo')
      group by 1,2,3
      )SD
      on L.Banco=SD.Banco and L.Anio=SD.Anio
      and L.Semana=SD.Semana ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: banco {
    type: string
    sql: ${TABLE}.Banco ;;
  }

  dimension: anio {
    type: string
    sql: ${TABLE}.Anio ;;
  }

  dimension: semana {
    type: number
    sql: ${TABLE}.Semana ;;
  }

  dimension: promedio_diario {
    type: number
    sql: ${TABLE}.Promedio_diario ;;
  }

  dimension: promedio_lunes {
    type: number
    sql: ${TABLE}.Promedio_Lunes ;;
  }

  dimension: promedio_sd {
    type: number
    sql: ${TABLE}.Promedio_SD ;;
  }

  set: detail {
    fields: [
        banco,
	anio,
	semana,
	promedio_diario,
	promedio_lunes,
	promedio_sd
    ]
  }
}
