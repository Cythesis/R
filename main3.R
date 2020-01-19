library(ggplot2)
data5 = NULL
dfresult = NULL
finalresult = NULL

setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
data = read.csv("output_2.csv", row.names = 1)

for (k in c(10,20,30,40,50,60,70,80,90,100)) {
  dfresult = NULL
  data3 = NULL
  
  # Percentage rowname
  for (h in 1:45) {
    data3 = rbind(data3, round(h/45,digits = 3))
  }
  
  for (j in 1:ncol(data)) {
    for (i in 1:nrow(data)) {
      if (k > data[i,j]) {
        intpl = c(data3[i],data[i,j],data3[i-1],data[i-1,j])
        result = (intpl[1]-intpl[3])/(intpl[2]-intpl[4])*(k-intpl[4])+intpl[3]
        dfresult = rbind(dfresult,result)
        print(intpl)
        break
      }
    }
  }
  
  for (i in 1:nrow(dfresult)) {
    data5 = rbind(data5,i)
  }
  
  finalresult = cbind(finalresult,dfresult)
  
  
  print(k)


}
data6 = NULL
for (i in 1892:2018) {
  data6 = rbind(data6,i)
}
rownames(finalresult) = data6
colnames(finalresult) = c("AAL10","AAL20","AAL30","AAL40","AAL50","AAL60","AAL70","AAL80","AAL90","AAL100")
colnames(data6) = "Year"
df = cbind(finalresult,data6)
df = as.data.frame(df)
ggplot() + geom_path(df,mapping = aes(Year,AAL10),color = rainbow(127)) + 
  geom_line(df,mapping = aes(Year,AAL50),color = rainbow(1)) + 
  geom_line(df,mapping = aes(Year,AAL100, color = "#F09123")) + 
  ylab("% time equalled or exceedance") +
  labs(title="Glennies Creek Dam Volume")+ theme(plot.title = element_text(hjust=0.5))+
  theme(plot.title = element_text(face = "bold"))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  theme_bw()+
  scale_colour_manual(" ",labels = c("Allocation 100%", "Allocation 50%"),values=c("blue","red"))+
  theme(
    legend.position = c(0.95,0.95),
    legend.justification = c("right", "top"))+
  theme(legend.title = element_blank()) +
  theme(
    legend.position = c(1, 1),
    legend.justification = c("right", "top"))+
  theme(legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid'))
  
  


setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
write.csv(finalresult, file = "output_3.csv", )

