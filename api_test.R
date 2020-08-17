
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
colnames(dataset)<-c("��¥","����","�ð�","����","����","�ŷ���")
datasetframe<-as.data.frame(dataset)
datasetframe$��¥ <- as.Date(as.character(datasetframe$��¥),"%Y.%m.%d")
datasetframe$���� <- as.numeric(as.character(datasetframe$����))
datasetframe$�ð� <- as.numeric(as.character(datasetframe$�ð�))
datasetframe$���� <- as.numeric(as.character(datasetframe$����))
datasetframe$���� <- as.numeric(as.character(datasetframe$����))
datasetframe$�ŷ��� <- as.numeric(as.character(datasetframe$�ŷ���))
datasetframe

  
b<-ggplot(datasetframe, aes(x=��¥) )+
  geom_line(aes(y=����,colour="green"))+
  geom_line(aes(y=�ð�,colour="red"))+
  geom_line(aes(y=����,colour="yellow"))+
  geom_line(aes(y=����,colour="black"))+
  scale_color_discrete(name="�ŷ���",labels = c("1","2","3","4"))+
  ggtitle("�ŷ���")+
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