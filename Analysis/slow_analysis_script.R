

#this is a slower analysis script
#if you're interested, this is an extremely non-optimised version of Conway's Game of Life

library(here)
library(animation)

data = matrix(rbinom(200*200, 1, 0.5), nrow = 200)
data[1,] = data[,1] = data[200,] = data[,250] = 0

plot(which(data == 1, arr.ind = T)[,"col"], which(data == 1, arr.ind = T)[,"row"],
     ylim = c(0,200), xlim = c(0,200), type = "p", pch = 15, cex = 0.4,
     xaxt = "n", yaxt = "n", ylab = "", xlab = "")

filename = gsub(c(" "), "_", format(as.POSIXct(Sys.time()), tz = "Europe/London", usetz = TRUE))
filename = gsub(":", "-", filename)
filename = paste0(filename, "_game_of_life.gif")

saveGIF({
  for(iter in 1:120){
    
    cat("\nIteration", iter)
    
    new_data = data
    
    for(i in 2:199){
      for(j in 2:199){
        
        sum_neighbours = sum(data[c((i-1):(i+1)), c((j-1):(j+1))])
        
        if(data[i,j] == 1 && !(sum_neighbours %in% c(3,4))){
          
          new_data[i,j] = 0
          
        }
        
        if(data[i,j] == 0 && sum_neighbours == 3){
          
          new_data[i,j] = 1
          
        }
      }
    }
    
    data = new_data
    
    plot(which(data == 1, arr.ind = T)[,"col"], which(data == 1, arr.ind = T)[,"row"],
         ylim = c(0,200), xlim = c(0,200), type = "p", pch = 15, cex = 0.4,
         xaxt = "n", yaxt = "n", ylab = "", xlab = "")
    
  }
}, movie.name = here::here("Results", filename), interval = 0.01,
ani.width = 800, ani.height = 800)

