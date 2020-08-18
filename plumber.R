
rm(list=ls())
install.packages("stringr")
install.packages("ggplot2")
install.packages("jsonlite")
install.packages("Rook")
library(plumber)
library(stringr)
library(ggplot2)
require(graphics)
library(jsonlite)
library(Rook)

#* ploting 
#* @png
#* @get /plot
function(jsondata){
myfile=read.csv("http://blogattach.naver.net/36a32a9989dbd20e21cda293ad47304de8be45a504/20200818_62_blogfile/padamu1_1597746711297_i601Kr_csv/my-file.csv",header=FALSE,
                  stringsAsFactors = FALSE)
file<-myfile
file<-file[,-1]
dataset <- c(1,1,1,1,1,1)
strsplit(as.character(file[2,6]),split="\n")
for(x in 1:nrow(file)){
  for(y in 1:ncol(file)){
    temp<-strsplit(as.character(file[x,y]),split="\n")
    temp<-temp[[1]]

    if(gsub('\t','',temp[6])==""){
      dataset <- rbind(dataset,c(temp[1],gsub('\t','',temp[2]),gsub('\t','',temp[8]),gsub('\t','',temp[9]),gsub('\t','',temp[10]),gsub('\t','',temp[11]))) 
    }else{
      dataset <- rbind(dataset,c(temp[1],gsub('\t','',temp[2]),gsub('\t','',temp[6]),gsub('\t','',temp[7]),gsub('\t','',temp[8]),gsub('\t','',temp[9])))
    }
  }
}
dataset <- dataset[-1,]
colnames(dataset)<-c("date","top","now","high","low","many")
datasetframe<-as.data.frame(dataset)
datasetframe$date <- as.Date(as.character(datasetframe$date),"%Y.%m.%d")
datasetframe$top <- as.numeric(as.character(datasetframe$top))
datasetframe$now <- as.numeric(as.character(datasetframe$now))
datasetframe$high <- as.numeric(as.character(datasetframe$high))
datasetframe$low <- as.numeric(as.character(datasetframe$low))
datasetframe$many <- as.numeric(as.character(datasetframe$many))
datasetframe

  
b<-ggplot(datasetframe, aes(x=date) )+
  geom_line(aes(y=top,colour="green"))+
  geom_line(aes(y=now,colour="red"))+
  geom_line(aes(y=high,colour="yellow"))+
  geom_line(aes(y=low,colour="black"))+
  scale_color_discrete(name="much",labels = c("low","high","now","top"))+
  ggtitle("how much")+
  theme(plot.title=element_text(face="bold",hjust=0.5,size=15,color = "darkblue"),legend.position = "right")
print(b)
}


#* echo
#* @param msg the message to echo
#* @get /echo
function(msg=""){
  list(msg=paste0("thi message is:'",msg,"'"))
}

#* hist
#* @param spec If provided, filter the data to only this specis (e.g. 'setosa')
#* @png
#* @get /hist

function(spec){
  myData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }
  
  plot(myData$Sepal.Length, myData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length")
}




