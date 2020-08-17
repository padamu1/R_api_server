
rm(list=ls())
library(plumber)
library(stringr)
library(ggplot2)
require(graphics)
#* ploting
#* @png
#* @get /plot
function(){
setwd("C:/Users/padam/Desktop/")
myfile <- read.csv("my-file.csv",header=FALSE,
                  stringsAsFactors = FALSE,fileEncoding="UCS-2LE")


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
colnames(dataset)<-c("날짜","종가","시가","고가","저가","거래량")
datasetframe<-as.data.frame(dataset)
datasetframe$날짜 <- as.Date(as.character(datasetframe$날짜),"%Y.%m.%d")
datasetframe$종가 <- as.numeric(as.character(datasetframe$종가))
datasetframe$시가 <- as.numeric(as.character(datasetframe$시가))
datasetframe$고가 <- as.numeric(as.character(datasetframe$고가))
datasetframe$저가 <- as.numeric(as.character(datasetframe$저가))
datasetframe$거래량 <- as.numeric(as.character(datasetframe$거래량))
datasetframe

  
b<-ggplot(datasetframe, aes(x=날짜) )+
  geom_line(aes(y=종가,colour="green"))+
  geom_line(aes(y=시가,colour="red"))+
  geom_line(aes(y=고가,colour="yellow"))+
  geom_line(aes(y=저가,colour="black"))+
  scale_color_discrete(name="거래가",labels = c("1","2","3","4"))+
  ggtitle("거래가")+
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