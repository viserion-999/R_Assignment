
numerical_histogram <- function(input, x){
 
  temp = input$input_axis
  print("temp is:")
  print(temp)
  hist(x[,temp], main = "Histogram", 
       xlab = temp, ylab = "Frequency", col = "lightgreen", border=F)
}

numerical_boxplot <- function(input,x){
  temp = input$input_axis
  
  boxplot(x[,temp], main = "Boxplot",
          ylab = temp, col = "maroon", border = "grey5", horizontal = T)
  
}


categorical_piechart <- function(input,x){
  temp = input$axis
  
  x[,temp]=as.factor(x[,temp])
  slices <- as.numeric(unname(table(x[,temp])))
  #print("slices are:")
  #print(slices)
  lbls <- names(table(x[,temp]))
  #print("labels are:")
  #print(lbls)
  
  pie(slices,labels = lbls, col=rainbow(length(lbls)),
      main = "PieChart")
  
  
}

categorical_barplot <- function(input,x){
  temp = input$axis
  x[,temp]=as.factor(x[,temp])
  
  barplot(table(x[,temp]),freq=T,main = paste("Barplot"),
          xlab = temp,
          ylab = "Frequency",
          col = "darkred",
          border = "black",
          horizontal = T)
  
  
  
}
