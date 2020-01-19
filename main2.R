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
