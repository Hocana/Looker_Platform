
view: prom_4semanas_cashout_dolares {
  derived_table: {
    sql: select T.Banco
      ,T.Anio
      ,T.Semana 
      ,case when T2.Promedio_diario is null then T.Promedio_diario
      when (T2.Promedio_diario is not null and T3.Promedio_diario is null) then (T.Promedio_diario+T2.Promedio_diario)/2
      when (T2.Promedio_diario is not null and T3.Promedio_diario is not null and T4.Promedio_diario is null) then (T.Promedio_diario+T2.Promedio_diario + T3.Promedio_diario)/3
      else (T.Promedio_diario+T2.Promedio_diario + T3.Promedio_diario + T4.Promedio_diario)/4 end as Promedio_4semanas_Diario
      ,case when T2.Promedio_Lunes is null then T.Promedio_Lunes
      when (T2.Promedio_Lunes is not null and T3.Promedio_Lunes is null) then (T.Promedio_Lunes+T2.Promedio_Lunes)/2
      when (T2.Promedio_Lunes is not null and T3.Promedio_Lunes is not null and T4.Promedio_Lunes is null) then (T.Promedio_Lunes+T2.Promedio_Lunes + T3.Promedio_Lunes)/3
      else (T.Promedio_Lunes+T2.Promedio_Lunes + T3.Promedio_Lunes + T4.Promedio_Lunes)/4 end as Promedio_4semanas_Lunes
      ,case when T2.Promedio_SD is null then T.Promedio_SD
      when (T2.Promedio_SD is not null and T3.Promedio_SD is null) then (T.Promedio_SD+T2.Promedio_SD)/2
      when (T2.Promedio_SD is not null and T3.Promedio_SD is not null and T4.Promedio_SD is null) then (T.Promedio_SD+T2.Promedio_SD + T3.Promedio_SD)/3
      else (T.Promedio_SD+T2.Promedio_SD + T3.Promedio_SD + T4.Promedio_SD)/4 end as Promedio_4semanas_SD
      ,case when T2.Promedio_Viernes is null then T.Promedio_Viernes
      when (T2.Promedio_Viernes is not null and T3.Promedio_Viernes is null) then (T.Promedio_Viernes+T2.Promedio_Viernes)/2
      when (T2.Promedio_Viernes is not null and T3.Promedio_Viernes is not null and T4.Promedio_Viernes is null) then (T.Promedio_Viernes+T2.Promedio_Viernes + T3.Promedio_Viernes)/3
      else (T.Promedio_Viernes+T2.Promedio_Viernes + T3.Promedio_Viernes + T4.Promedio_Viernes)/4 end as Promedio_4semanas_Viernes
      
      from
      ---semana 4----
      (select D.*
            ,ifnull(L.Promedio_Lunes,0) Promedio_Lunes
            ,ifnull(SD.Promedio_SD,0) Promedio_SD
            ,ifnull(V.Promedio_V,0) Promedio_Viernes
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
       ---semana 3----
      left join 
      (select D.*
            ,ifnull(L.Promedio_Lunes,0) Promedio_Lunes
            ,ifnull(SD.Promedio_SD,0) Promedio_SD
            ,ifnull(V.Promedio_V,0) Promedio_Viernes
            from
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto)/7 Promedio_diario
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
            where D.Anio='2024' )T2
            on T.Banco=T2.Banco
            and T.Semana=T2.Semana + 1
      ---semana 2----
      left join 
      (select D.*
            ,ifnull(L.Promedio_Lunes,0) Promedio_Lunes
            ,ifnull(SD.Promedio_SD,0) Promedio_SD
            ,ifnull(V.Promedio_V,0) Promedio_Viernes
            from
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto)/7 Promedio_diario
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
            where D.Anio='2024' )T3
            on T.Banco=T3.Banco
            and T.Semana=T3.Semana + 2
      ---semana 1----
      left join 
      (select D.*
            ,ifnull(L.Promedio_Lunes,0) Promedio_Lunes
            ,ifnull(SD.Promedio_SD,0) Promedio_SD
            ,ifnull(V.Promedio_V,0) Promedio_Viernes
            from
            (Select S.Banco
            ,substr(Fecha,1,4) as Anio
            ,Semana
            ,sum(Monto)/7 Promedio_diario
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
            where D.Anio='2024' )T4
            on T.Banco=T4.Banco
            and T.Semana=T4.Semana + 3 ;;
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

  dimension: promedio_4semanas_diario {
    type: number
    sql: ${TABLE}.Promedio_4semanas_Diario ;;
  }

  dimension: promedio_4semanas_lunes {
    type: number
    sql: ${TABLE}.Promedio_4semanas_Lunes ;;
  }

  dimension: promedio_4semanas_sd {
    type: number
    sql: ${TABLE}.Promedio_4semanas_SD ;;
  }

  dimension: promedio_4semanas_viernes {
    type: number
    sql: ${TABLE}.Promedio_4semanas_Viernes ;;
  }

  set: detail {
    fields: [
        banco,
	anio,
	semana,
	promedio_4semanas_diario,
	promedio_4semanas_lunes,
	promedio_4semanas_sd,
	promedio_4semanas_viernes
    ]
  }
}
