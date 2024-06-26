connection: "ligo_lake"

 # include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
  include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore:  cash_out_ligo_evolutivo {
  join:promedio_periodo_cash_out_ligo_bancos {
    relationship: one_to_one
    sql_on: ${cash_out_ligo_evolutivo.banco} = ${promedio_periodo_cash_out_ligo_bancos.banco} ;;
  }
  }

explore: promedio_periodo_cash_out_ligo_bancos  {

  }

explore: max_promedios_soles_cash_out  {

}
explore: max_prom_dolares_cash_out  {

}
explore: prom_4_semanas_cashout_soles  {

}
explore: prom_4semanas_cashout_dolares {

}
explore: cash_out_prom_max_anual {

}


#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
