# Variables #
totaldates = 25913      # Without leap dates
year_shifted = 12
no_till_leap_year = 4 - year_shifted%%4   # If starting year is leap year, var = 0

# Constant Variables #
skip = 0
no_date_shifted = year_shifted * 365
dates4 = NULL
del_row = NULL
if (no_till_leap_year == 4) {no_till_leap_year = 0}

# Main Function #
cat("\014") 
print("[###-----------------]")
# Read table
setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
a = read.table("52003_SILO_Rain.csv", fill=TRUE, sep = ",")
a = a[2:nrow(a),1:2]
cat("\014") 
print("[######--------------]")

# Delete all leap dates
for (i in 1:totaldates) {
  date = a[i,1]
  date = substr(date, start = 1, stop = 5)
  if (date == "29/02") {
    del_row = append(del_row,i)
  }
}
a = a[-del_row,]

cat("\014") 
print("[#########-----------]")

# Shifting year
max_year = as.integer(substr(a[nrow(a),1],start = 7, stop = 10))

data = a[,2]
data = as.data.frame(data)

dates = a[,1]
dates = dates[(no_date_shifted+1):length(dates)]
dates = as.data.frame(dates)
dates2 = as.data.frame(dates[1:365,])

dates4 = NULL
for (i in 1:year_shifted) {
  dates3 = data.frame(lapply(dates2, function(x) {gsub(sprintf("%04d",year_shifted), sprintf("%04d",(max_year+i)), x)}))
  dates4 = rbind(dates4,dates3)
}

cat("\014") 
print("[#########-----------]")

names(dates4) = "dates"
dates = rbind(dates,dates4)
output = cbind(dates,data)


# Leap date correction
for (i in 1:nrow(output)){
  if (skip == 1) {
    skip = 0
    next
  }
  date = output[i,1]
  date = substr(date, start = 1, stop = 5)
  year = substr(output[i,1], start = 7, stop = 10)
  if (date == "28/02") {
    if (no_till_leap_year == 0) {
      x = data.frame("dates" = paste("29/02/",year,sep = ""),"data" = output[i,2])
      output = rbind(output[1:i,],x,output[(i+1):nrow(output),])
      no_till_leap_year = 3
      skip = 1
    } else {
      no_till_leap_year = no_till_leap_year - 1
    }
  }
}
cat("\014") 
print("[################----]")
# Save output
setwd("C:/Users/dungd/OneDrive/Desktop/python_ws/WaterSecurity")
write.csv(output, file = "output_4.csv", )

cat("\014") 
print("[####################] - Done")

