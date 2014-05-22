Title Basic Algo Trading Based On TA
========================================================


```r
library(quantmod)
```

```
## Loading required package: Defaults
## Loading required package: xts
## Loading required package: zoo
## 
## Attaching package: 'zoo'
## 
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
## 
## Loading required package: TTR
## Version 0.4-0 included new data defaults. See ?getSymbols.
```

```r
library(tseries)
library(TTR)
library(rpart)
library(mlr)
```

```
## Loading required package: ParamHelpers
```

```r

# set work space to trading comp setwd('~/Desktop/trading')
SYMs <- TTR::stockSymbols()
```

```
## Fetching AMEX symbols...
## Fetching NASDAQ symbols...
## Fetching NYSE symbols...
```

```r

start.time <- "2012-05-02"
end.time <- "2012-09-06"
# set the length of matrix
tmp <- get.hist.quote("aapl", start = start.time, end = end.time, quote = c("AdjClose"), 
    provider = "yahoo", compression = "d")

rlen <- length(tmp$AdjClose)
clen <- length(SYMs$Symbol)

# create a matrxi for strock price and volume
trainning.data.price <- matrix(data = 0, rlen, clen)
trainning.data.volume <- matrix(data = 0, rlen, clen)
# create the trainning indicators
trainning.data.macd <- matrix(data = 0, rlen, clen)
trainning.data.ema10 <- matrix(data = 0, rlen, clen)
trainning.data.ema50 <- matrix(data = 0, rlen, clen)
trainning.data.rsi <- matrix(data = 0, rlen, clen)
trainning.data.adx <- matrix(data = 0, rlen, clen)
trainning.data.atr <- matrix(data = 0, rlen, clen)
trainning.data.return <- matrix(data = 0, rlen, clen)
trainning <- matrix(data = 0, clen, 6)

# get data from yahoo
for (i in 1:clen) {
    tryCatch({
        # load the trainning data from yahoo
        data <- get.hist.quote(SYMs$Symbol[i], start = start.time, end = end.time, 
            quote = c("High", "Low", "Close", "AdjClose", "Volume"), provider = "yahoo", 
            compression = "d")
        
        if (length(data$AdjClose) < rlen) {
            next
        }
        trainning.data.price[, i] <- data$AdjClose
        trainning.data.volume[, i] <- data$Volume
        # calcluate the indictor
        tmp <- MACD(data$AdjClose)
        tmp <- (tmp[, 1]/tmp[, 2]) - 1
        trainning.data.macd[, i] <- tmp
        trainning.data.ema10[, i] <- EMA(trainning.data.price[, i], n = 10)
        trainning.data.ema50[, i] <- EMA(trainning.data.price[, i], n = 50)
        trainning.data.rsi[, i] <- RSI(trainning.data.price[, i])
        tmp <- data[, c("High", "Low", "Close")]
        tmp <- ADX(as.xts(tmp))
        trainning.data.adx[, i] <- tmp$ADX
    }, error = function(e) cat("skip loop ", i, "\n"))
}
```


```r



for (i in 1:clen) {
    # 1 stand for positive -1 stand for negitive 0 stand for hold price change
    if (is.nan(trainning.data.adx[rlen - 2, i])) {
        next
    }
    # price
    trainning[i, 6] <- (trainning.data.price[rlen, i]/trainning.data.price[rlen - 
        2, i]) - 1
    
    
    # ema
    trainning[i, 1] <- (trainning.data.ema10[rlen - 2, i]/trainning.data.ema50[rlen - 
        2, i]) - 1
    
    # rsi
    trainning[i, 2] <- trainning.data.rsi[rlen - 2, i]
    
    # macd
    trainning[i, 3] <- trainning.data.macd[rlen - 2, i]
    
    # adx
    trainning[i, 4] <- trainning.data.adx[rlen - 2, i]
    
    # volume
    trainning[i, 5] <- (trainning.data.volume[rlen - 2, i]/(sum(trainning.data.volume[(rlen - 
        13):(rlen - 2), i])/10)) - 1
    
}

colnames(trainning) <- c("ema", "rsi", "macd", "adx", "volume", "price")


trainning <- data.frame(trainning)
fit <- rpart(trainning$price ~ trainning$ema + trainning$rsi + trainning$macd + 
    trainning$adx + trainning$volume, data = trainning)
printcp(fit)
```

```
## 
## Regression tree:
## rpart(formula = trainning$price ~ trainning$ema + trainning$rsi + 
##     trainning$macd + trainning$adx + trainning$volume, data = trainning)
## 
## Variables actually used in tree construction:
## [1] trainning$ema    trainning$volume
## 
## Root node error: 8.8/5234 = 0.0017
## 
## n=5234 (1334 observations deleted due to missingness)
## 
##      CP nsplit rel error xerror xstd
## 1 0.021      0      1.00      1 0.26
## 2 0.010      3      0.94      1 0.26
```

```r
plot(fit)
text(fit)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

