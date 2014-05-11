# Load in data from the dataset pertaining only to the entries 
# between 2007-02-01 and 2007-02-02 (yyyy-mm-dd)
# IMPORTANT: dates are in the form dd/mm/yyyy

# Uses R's 'pipe' method to connect with the file and limit the loaded data via egrep
electricity = read.csv(file = pipe('egrep \'^Date|^[1-2]/2/2007\' ./data//household_power_consumption.txt'),
                       header=T,
                       sep = ";"
)

# Convert the Date and Time variables to Date/Time 
# classes in R using the strptime() and as.Date() functions.

electricity$Date = as.Date(electricity$Date, format="%d/%m/%Y")

# Times are trickier. To format a column of time objects,, we'll have to convert it to a datetime object by 
# merging electricity$Date and electricity$Time, and then using strptime
convertedTimes = paste(electricity$Date, electricity$Time)
times = strptime(convertedTimes, format="%Y-%m-%d %H:%M:%S")
electricity$Time = times

str(electricity)




####### Plot 2 - Daily Global Active Power levels, line ######

png("plot2.png")
plot(x = electricity$Time,
     y = electricity$Global_active_power,
     type="l"
)
dev.off()







