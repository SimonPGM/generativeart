library(caret)

# Usando knn con interpolacion

df1 <- expand.grid(x = 1:200, y = 1:200) 
df1$z <- runif(nrow(df1)) #Se crea el df

grid1 <- expand.grid(k=200)
mod1 <- train(z~., data = df1, method="knn", tuneGrid=grid1) #Ajustando knn con k = 200 para obtener "cumulos" 

ggplot(df1, aes(x, y, fill = fitted(mod1))) +
  geom_raster(interpolate = T) + #Se interpola para suavizar la graficacion
  xlim(c(0, 200 + 1)) +
  ylim(c(0, 200 + 1)) +
  scale_fill_gradient(low="gold", high="white")+
  theme(axis.title = element_blank(),
        axis.text =  element_blank(), 
        axis.ticks = element_blank(), 
        axis.line =  element_blank(), 
        legend.position = "none", 
        plot.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid = element_blank(), 
        plot.margin = unit(rep(0,4), "lines"), 
        strip.background = element_blank(), 
        strip.text = element_blank()) #Los colores dorado y blanco dan efecto de luz
ggsave("knnsmoothART.png", width = 500, height = 500, units = "px")

#Usando rf

df2 <- data.frame(x = runif(1000,0,200), #Se crea el df
                  y = runif(1000,0,200),
                  z = factor(sample(c("white","black"), 1000, replace = TRUE)))

library(randomForest)

mod2 <- randomForest(z~.,data = df2) #Ajustando un bosque aleatorio sin tunear paraetros (no es de interés)

seq2 <- seq(0, 200, by = 1)
dfpred2 <- expand.grid(seq2, seq2)
colnames(dfpred2) <- c("x", "y")
z <- predict(mod2, newdata = dfpred2)
entpred2 <- data.frame(x = dfpred2$x, y = dfpred2$y, z = z) #Se prepara un df con predicciones

ggplot(entpred2, aes(x = x, y = y, fill = z)) +
  geom_raster(interpolate = T) + #Se interpola el resultado para obtener el efecto de "pincelazo"
  xlim(c(-1, 200 + 1)) +
  ylim(c(-1, 200 + 1)) +
  scale_fill_manual(values = c("white","black"))+
  theme(axis.title = element_blank(),
        axis.text =  element_blank(), 
        axis.ticks = element_blank(), 
        axis.line =  element_blank(), 
        legend.position = "none", 
        plot.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid = element_blank(), 
        plot.margin = unit(rep(0,4), "lines"), 
        strip.background = element_blank(), 
        strip.text = element_blank()) #Los colores blanco y negro dan el toque indsutrial a la obra
ggsave("rfART.png", width = 500, height = 500, units = "px")

#Usando knn sin interpolacion

df3 <- data.frame(x = runif(1000, 0, 200),
                  y = runif(1000, 0, 200),
                  z = factor(sample(c("#ccb77c",
                                      "#523402",
                                      "#f2f2eb",
                                      "#000000"), 1000, replace = TRUE))) #Se crea un df con los codigos de colores para facilitar la graficacion

mod3 <- train(z ~ ., data = df3, method="knn") #Se entrena el knn, en este caso no interesa modificar k

seq3 <- seq(0, 200, by = 1)
dfpred3 <- expand.grid(seq3, seq3)
colnames(dfpred3) <- c("x", "y")
z <- predict(mod3, newdata = dfpred3)
entpred3 <- data.frame(x = dfpred3$x, y = dfpred3$y, z = z) #Se prepara el df con predicciones hechas por el modelo

ggplot(entpred3, aes(x = x, y = y, fill = z)) +
  geom_raster(interpolate = T) + #Aunque se interpole, se siguen obteniendo "salpicaduras" bien diferenciadas gracias a la naturaleza de los datos 
  xlim(c(-1, 200 + 1)) +
  ylim(c(-1, 200 + 1)) +
  scale_fill_manual(values = c("#ccb77c","#523402","#f2f2eb","#000000"))+
  theme(axis.title = element_blank(),
        axis.text =  element_blank(), 
        axis.ticks = element_blank(), 
        axis.line =  element_blank(), 
        legend.position = "none", 
        plot.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid = element_blank(), 
        plot.margin = unit(rep(0,4), "lines"), 
        strip.background = element_blank(), 
        strip.text = element_blank()) #Paleta de colores "tierra"
ggsave("knnsplatterART.png", width = 500, height = 500, units = "px")

#Usando bagging

df4 <- data.frame(x = runif(1000, 0, 200),
                  y = runif(1000, 0, 200),
                  z = factor(sample(c("#F98404",
                                      "#FC5404",
                                      "#F9B208",
                                      "#F7FD04"), 1000, replace = TRUE))) #Se crea el df con la misma estructura y colores deseados


mod4 <- train(z ~ ., data = df4, method="treebag") #Modelo de empaquetado para arboles de clasificacion

seq4 <- seq(0, 200, by = 1)
dfpred4 <- expand.grid(seq4, seq4)
colnames(dfpred4) <- c("x", "y")
z <- predict(mod4, newdata = dfpred4)
entpred4 <- data.frame(x = dfpred4$x, y = dfpred4$y, z = z)

ggplot(entpred4, aes(x = x, y = y, fill = z)) +
  geom_raster(interpolate = F) + #No se interpola para obtener regiones bien diferenciadad
  xlim(c(-1, 200 + 1)) +
  ylim(c(-1, 200 + 1)) +
  scale_fill_manual(values = c("#F98404","#FC5404","#F9B208","#F7FD04"))+
  theme(axis.title = element_blank(),
        axis.text =  element_blank(), 
        axis.ticks = element_blank(), 
        axis.line =  element_blank(), 
        legend.position = "none", 
        plot.background = element_blank(), 
        panel.border = element_blank(), 
        panel.grid = element_blank(), 
        plot.margin = unit(rep(0,4), "lines"), 
        strip.background = element_blank(), 
        strip.text = element_blank())
ggsave("BaggingART.png", width = 500, height = 500, units = "px")
#Notese que la imagen que se obtiene son lineas horizontales, lo que indica que el modelo predice los mismo valores
#Para cualquier valor de Y, puede que este ajuste sea malo en, pero en terminos graficos, es muy atractivo.



