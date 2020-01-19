re = 1
# Main loop to run different scenarios
for (lir in 1892:2018) {
  # Handling file name
  name_b = "HuntPatW2014_FD0202.txt"
  file_name = paste(lir,name_b,sep="")
  
  # Ignore first loop
  if (lir > 1892) {
    # Reading csv file
    setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
    data = read.csv("output_1.csv", row.names = 1)
  }
  
  # Grab data
  setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity/input_data/Scenarios")
  a = read.table(file_name, fill=TRUE)
  matrix_a = NULL
  
  # Grab
  for (j in 1:nrow(a)) {
    current_date = a[j,1]
    current_date = substr(current_date, start = 1, stop = 5)
    if (current_date == "01/07") {
      matrix_a = rbind(matrix_a,a[j,])
    }
  }
  
  # Fixing row name
  matrix_a = matrix_a[1:2]
  matrix_b = matrix_a[,-1,drop=FALSE]
  
  rn_b = matrix_a[,1]
  rn_b = data.frame("data"=rn_b)
  rn_b$data = substr(rn_b$data,start = 7, stop = 10)
  rn_b = rn_b[,1]
  rownames(matrix_b) = rn_b
  colnames(matrix_b) = paste("S",re)
  print(paste("Year:",lir))
  # Ignore first loop, cbind data
  if (lir > 1892) {
    data = cbind(data,matrix_b)
  } else {
    data = matrix_b
  }
  re = re+1
  setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
  write.csv(data, file = "output_1.csv", )
}

data2 = NULL
data3 = NULL

setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
data = read.csv("output_1.csv", row.names = 1)

for (i in 1:ncol(data)) {
  data2 = cbind(data2,sort(data[,i],decreasing=TRUE))
}

# Percentage rowname
for (i in 1:45) {
  data3 = rbind(data3, round(i/45,digits = 3))
}

rownames(data2) = data3

setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
write.csv(data2, file = "output_2.csv", )

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

