library(MASS)
setwd("C:/Users/galaxyan/Dropbox/dataMining")
trainning<-read.csv("trainning.csv")
fit<-rpart(trainning$price ~ trainning$ema+trainning$rsi+trainning$macd+trainning$adx+trainning$volume,data = trainning)
test.data<-test.data[50:len,1:7]
test<-matrix(data=0.0,222,6)
profit<-numeric(1000)
len<-222

for(j in 1: 1000){
  
  test.data<-test.data[sample(1:len),1:7]
  rm(i)
  for(i in 11:220){
    #price
    test[i,6]<- (test.data[i+2,1]/test.data[i,1])-1 
    
    
    #ema
    test[i,1]<- (test.data[i,4]/test.data[i,5])-1
    
    #rsi
    test[i,2]<- test.data[i,6]
    
    #macd
    test[i,3]<- test.data[i,3]
    
    #adx
    test[i,4]<- test.data[i,7]
    
    #volume 
    test[i,5]<-(test.data[i,2]/(sum(test.data[(i-11):(i-1),2])/10))-1
    
  }
  
  colnames(test)<-c("ema","rsi","macd","adx","volume","price")
  
  
  test<-data.frame(test)
  pred<-predict(fit,newdata=test)
  
  
  
  portfolio<-matrix(data=0.0,len,4)
  portfolio[1,4]<-0
  holding <-0
  # using predict to trade
  rm(i)
  for(i in 1:(len-1)){
    if(pred[i+1] > 0.02 && holding <= 0){
      portfolio[i,1]<-i
      portfolio[i,2]<- test.data[i,1]
      portfolio[i,3]<-1
      holding<- 1 
    }
    else if( pred[i+1] < 0 && holding >=0){
      
      portfolio[i,1]<-i
      portfolio[i,2]<- test.data[i,1]
      portfolio[i,3]<- -1
      holding<- -1
    }
    #record portfoilo change
    if(holding > 0 ){
      portfolio[i+1,4]<-portfolio[i,4]+(test.data[i+1,1]-test.data[i,1])
    }
    else if(holding < 0){
      portfolio[i+1,4]<-portfolio[i,4]+(test.data[i,1]-test.data[i+1,1])
    }
    else{
      portfolio[i+1,4]<-portfolio[i,4]
    }
  }
  
  # reduce position to zore at the end of time  
  if(holding > 0){
    portfolio[len,1]<-len
    portfolio[len,2]<- test.data[len,1]
    portfolio[len,3]<- -1
    holding<- 0
  }
  if(holding < 0){
    portfolio[len,1]<-len
    portfolio[len,2]<- test.data[len,1]
    portfolio[len,3]<- 1
    holding<- 0
  }
   
  profit[j]<-portfolio[len,4]
  cat("looping",j,"\n")
}

hist(profit)



t.test(profit,mu=0,alternative="great")

write.csv(portfolio,file="port.csv")
