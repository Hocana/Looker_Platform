connection: "ligo_lake"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: dim_dash_resumen_producto {
  join:dim_dash_resumen_producto_grafico {
    relationship: many_to_many
    sql_on: ${dim_dash_resumen_producto.fecha_date} = ${dim_dash_resumen_producto_grafico.fecha_date} ;;
  }
  }
explore: dim_dash_resumen_producto_grafico {  }
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
 #}
