
view: max_prom_dolares_cash_out {
  derived_table: {
    sql: select max(Promedio_diario) Diario
      ,max(Promedio_Lunes) Lunes
      ,max(Promedio_SD) SD
      ,max(Promedio_V) Viernes
      ,Banco
      from
      (select D.*
            ,L.Promedio_Lunes
            ,SD.Promedio_SD
            ,V.Promedio_V
            from
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto)/count(distinct(Dia)) Promedio_diario
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
            where Moneda='Dolares'
            group by 1,2,3
            )D
            left join
            (select Banco
            ,Anio 
            ,Semana-1 as semana
            ,Promedio_Lunes 
            from 
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto) Promedio_Lunes
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
            Moneda='Dolares' and
            Dia='1. Lunes'
            group by 1,2,3
            )l
            )L
            on L.Banco=D.Banco and L.Anio=D.Anio
            and L.semana=D.Semana
            left join
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto) Promedio_SD
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
            Moneda='Dolares' and
            Dia in ('6. Sabado','7. Domingo')
            group by 1,2,3
            )SD
            on D.Banco=SD.Banco and D.Anio=SD.Anio
            and D.Semana=SD.Semana
            left join
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto) Promedio_V
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
            Moneda='Dolares' and
            Dia in ('5. Viernes')
            group by 1,2,3
            )V
              on D.Banco=V.Banco and D.Anio=V.Anio
            and D.Semana=V.Semana
            where D.Anio='2024' )T
            group by 5 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: diario {
    type: number
    sql: ${TABLE}.Diario ;;
  }

  dimension: lunes {
    type: number
    sql: ${TABLE}.Lunes ;;
  }

  dimension: sd {
    type: number
    sql: ${TABLE}.SD ;;
  }

  dimension: viernes {
    type: number
    sql: ${TABLE}.Viernes ;;
  }

  dimension: banco {
    type: string
    sql: ${TABLE}.Banco ;;
  }

  set: detail {
    fields: [
        diario,
	lunes,
	sd,
	viernes,
	banco
    ]
  }
}
