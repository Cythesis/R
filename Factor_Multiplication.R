# Read table
setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
input = read.csv("52003_SILO_Rain.csv", fill=TRUE, sep = ",")
input = input[2:nrow(input),]
output = input
factor = read.table("55003.FAC", fill = TRUE)
factor = factor[1:12]

for (i in 1:nrow(input)) {
  month = substr(input[i,1], start = 4, stop = 5)
  for (j in 1:12) {
    if (month == sprintf("%02d",j)){
      output[i,2] = (input[i,2])*(factor[[j]])
    }
  }
}

opstech = cbind(input,output)

