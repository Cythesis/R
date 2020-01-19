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
