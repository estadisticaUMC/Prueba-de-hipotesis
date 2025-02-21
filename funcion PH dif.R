rm(list = ls())

library(readxl)
library(writexl)
library(tidyverse)

# mostrar cifras significaticas (entero + decimal)
options(digits=8)

# ruta de trabajo
setwd('D:/fabio/pedido Luis funcion prueba hipotesis diferencias')

# abrir BD
data=read_xlsx('ejemplo.xlsx')

# calculo del pvalor
data=data%>%
  mutate(dif=por1-por2,
         zcal=dif/sqrt(ee2^2+ee1^2),
         pvalor=round(if_else(zcal<0,
                              2*pnorm(zcal),
                              2*(1-pnorm(zcal))),8),
         conclusion=if_else(pvalor<0.05,
                            'Rechaza H0. La diferencia es SIGNIFICATIVA',
                            'NO se rechaza H0. La diferencia NO ES SIGNIFICATIVA'),
         simbolo=if_else(pvalor<0.05, '*', ''))

# exportar
write_xlsx(data,'salida.xlsx')
