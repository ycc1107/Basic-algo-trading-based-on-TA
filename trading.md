Title
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

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  8 
## skip loop  10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  26
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  42
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  49
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  61
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  81
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  85
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  88
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  94 
## skip loop  98
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  126 
## skip loop  132 
## time series starts 2012-05-31
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  149
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  151
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  161
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  167
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  175
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  176
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  180
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  181 
## time series starts 2012-06-08
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  198
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  207
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  219
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  231
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  238
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  243
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  252
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  253
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  254
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  257
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  281
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  284
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  287
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  288
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  313
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  314
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  315
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  318
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  319
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  320
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  321
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  322
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  323
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  325
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  337
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  339
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  349
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  359
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  360
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  361
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  362
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  371
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  374
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  394 
## skip loop  397
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  422
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  428
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  429
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  433
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  442
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  443
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  462
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  474
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  477 
## time series starts 2012-05-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  489
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  495
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  502
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  507
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  508
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  510
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  512
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  513
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  515
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  522
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  526
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  527
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  528
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  532
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  533
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  552
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  553
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  554
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  555
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  561
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  571
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  602
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  603
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  604
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  605
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  611
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  614
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  637
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  644
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  664 
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  696
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  700
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  737
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  738 
## time series starts 2012-08-08
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  760
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  761
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  762
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  763
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  769
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  770
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  785
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  794
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  827
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  828
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  829
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  831
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  838
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  839
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  840
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  844
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  855
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  860
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  872
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  875
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  885
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  900 
## time series starts 2012-05-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  910
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  930
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  931 
## time series starts 2012-07-24
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  937
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  944
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  945
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  946
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  952
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  953
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  954
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  957 
## skip loop  964
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  968
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  977
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  978
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  980
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  983
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  986
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  991
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  993
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1009
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1010
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1014
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1018 
## skip loop  1020
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1033
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1035
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1041
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1042 
## time series starts 2012-05-11
## time series starts 2012-05-30
## skip loop  1053
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1054
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1083
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1084
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1094 
## skip loop  1095
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1107
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1118 
## time series starts 2012-07-27
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1151
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1152
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1153
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1165
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1176
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1180 
## time series starts 2012-07-19
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1201
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1202
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1203
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1205
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1207
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1214
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1215
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1216
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1218
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1223
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1246
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1249
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1252
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1262
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1265
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1281
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1283
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1289 
## time series starts 2012-07-26
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1295
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1301
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1302
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1313
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1323
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1326 
## time series starts 2012-05-16
## time series starts 2012-06-28
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1345
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1349 
## time series starts 2012-05-18
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1371
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1380
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1396
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1400 
## time series starts 2012-07-19
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1402
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1411
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1413
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1417
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1422
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1436
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1437
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1447 
## time series starts 2012-07-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1451
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1453
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1460
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1462
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1463
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1464
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1467
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1469
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1471
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1476
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1478
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1493
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1501
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1510
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1522
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1526
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1530
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1531
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1533
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1536
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1537
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1539
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1544
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1550
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1552
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1557
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1587
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1594
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1597
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1598
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1605
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1611
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1612
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1613
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1614
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1620
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1622
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1637
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1644
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1651 
## time series starts 2012-08-03
## time series starts 2012-07-26
## time series starts 2012-07-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1676
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1681
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1691
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1692
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1693
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1703
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1706
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1709
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1710
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1714
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1761
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1770
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1781
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1784
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1785
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1790 
## time series starts 2012-05-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1809
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1818
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1819
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1820
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1833 
## time series starts 2012-05-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1849
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1851
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1861
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1863
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1871
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1879
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1880
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1885
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1888
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1889
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1896
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1907
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1908
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1911
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1912
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1913 
## skip loop  1915
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1917
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1918
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1928
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1938
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1939
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1942
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1947
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1958
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  1959 
## skip loop  1974 
## time series starts 2012-08-10
## time series starts 2012-08-17
## skip loop  1988
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2000
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2005
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2009 
## time series starts 2012-08-14
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2027
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2031
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2032
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2033
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2055
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2061
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2062
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2063
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2070
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2094
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2103
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2108
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2122
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2131
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2137
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2147
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2149
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2157
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2161
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2176
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2188
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2194
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2197
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2202
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2220
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2225
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2226
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2234
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2238
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2239
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2244
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2260
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2270
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2278
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2281
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2284
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2312
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2317
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2318 
## skip loop  2319
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2320
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2323
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2324
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2330
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2340
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2352 
## skip loop  2354
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2365
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2376 
## time series starts 2012-08-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2394
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2395
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2435
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2436
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2453 
## time series starts 2012-08-08
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2479
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2483
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2502
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2511
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2512 
## skip loop  2513
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2518
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2520
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2521
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2522
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2531
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2532
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2533
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2534
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2538
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2539
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2540
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2544
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2553
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2557
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2559
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2561
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2562
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2574
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2580
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2584
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2587
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2591
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2597
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2602
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2606 
## time series starts 2012-05-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2613
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2614 
## time series starts 2012-05-29
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2624
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2625
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2633
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2636
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2637
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2643
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2645 
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2649
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2655
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2657
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2674
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2678
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2689
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2691
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2699
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2701
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2704 
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2725
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2756
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2762
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2786
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2812
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2818
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2821
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2841
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2847 
## skip loop  2857 
## time series starts 2012-08-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2887 
## time series starts 2012-07-02
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2897
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2903
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2905
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2906 
## time series starts 2012-08-14
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2919
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2927 
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2936
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2937
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2950
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2951
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2954 
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2959
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2970 
## time series starts 2012-05-30
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2977
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## skip loop  2981
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2982
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  2984 
## time series starts 2012-06-28
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3000 
## time series starts 2012-08-22
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3010
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3017
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3020
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3066
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3081
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3094
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3113
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3114
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3127
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3128
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3137
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3144
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3145
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3152
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3155
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3162
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3165
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3166
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3179
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3180
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3181
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3182
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3183
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3191
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3198
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3210
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3211
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3225
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3228
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3229
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3232
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3233 
## skip loop  3234
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3240
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3247
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3249
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3261
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3271 
## skip loop  3275
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3279
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3282
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3288
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3289
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3290
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3291
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3293
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3311
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3317
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3327
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3330 
## time series starts 2012-08-28
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3336
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3338
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3339 
## time series starts 2012-06-14
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3349
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3350
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3353
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3354
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3355
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3360
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3362
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3363
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3364
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3365
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3368
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3369
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3370
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3372
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3373
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3375
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3380
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3381
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3382
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3383
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3393 
## time series starts 2012-06-14
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3400
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3401
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3402
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3403
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3404
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3405
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3406
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3407
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3408
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3409
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3410
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3411
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3413
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3418
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3419
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3423
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3424
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3425
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3426 
## time series starts 2012-07-27
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3433
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3436
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3440
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3442
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3443
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3454
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3461
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3464
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3467
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3468
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3470
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3471
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3473
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3475
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3477
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3478
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3482
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3484
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3485
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3487
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3492
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3501
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3502
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3503
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3521
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3522
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3541
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3542
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3552
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3556
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3557
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3558
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3575
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3576
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3577
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3578
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3585
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3592
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3595
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3602
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3606
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3609
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3612
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3617
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3618
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3621 
## time series starts 2012-07-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3624
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3626
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3630
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3646
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3647
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3649
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3653 
## time series starts 2012-06-20
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3673
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3674
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3675
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3676
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3677
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3689
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3698
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3710
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3712
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3719 
## time series starts 2012-08-30
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3733
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3744 
## time series starts 2012-07-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3752
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3753
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3754
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3755
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3756
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3758
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3759
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3774
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3776
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3782
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3783
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3785
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3786
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3789
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3790
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3793
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3798
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3799
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3801
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3809
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3812
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3815
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3821
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3823
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3827
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3832
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3841
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3844
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3847
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3852
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3862
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3865
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3881
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3884
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3889
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3891
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3898
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3901
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3902
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3909
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3923
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3924
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3931
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3934
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3935
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3942
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3952
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3966
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3970
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3973
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3974 
## time series starts 2012-08-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3984 
## time series starts 2012-08-03
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3988
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3989
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3992
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  3993
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4004
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4006
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4011
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4012 
## time series starts 2012-07-30
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4021
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4026
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4027
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4028
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4030
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4031
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4040
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4049
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4050
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4059
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4060
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4061
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4064
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4073
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4075
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4077
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4078
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4091
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4098
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4099
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4100
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4101
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4103
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4112
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4127
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4129
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4132
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4136
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4142
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4146
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4147
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4153
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4163
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4164
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4167
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4168
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4171
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4172
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4173
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4177
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4182
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4188
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4191
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4198 
## time series starts 2012-07-18
## time series starts 2012-07-06
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4220
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4221
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4227
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4235
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4239
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4241
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4259
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4262
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4263
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4264 
## time series starts 2012-06-27
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4271
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4274
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4280
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4281
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4283
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4297
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4301 
## time series starts 2012-05-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4303
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4307
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4311
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4321
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4334
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4340
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4341
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4351
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4359
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4361
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4364
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4366
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4380
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4384
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4392
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4394
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4399
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4400
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4402
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4407
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4408
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4409
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4410
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4411
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4417
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4419
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4431
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4437
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4438
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4439
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4441
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4453
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4457
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4461
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4462
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4465
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4467
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4470
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4471
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4486
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4488
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4490
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4495
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4499
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4510
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4515
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4516
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4517 
## time series starts 2012-08-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4522
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4525
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4534
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4542
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4545
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4547
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4550
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4551
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4552
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4553
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4555
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4557
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4558
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4559
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4561
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4562
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4563 
## time series starts 2012-05-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4577
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4581
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4584
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4585
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4586
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4595
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4602 
## time series starts 2012-08-16
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4605
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4606
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4615
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4630
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4635
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4647
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4667
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4671
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4683
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4687
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4693
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4694 
## time series starts 2012-06-06
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4699 
## time series starts 2012-08-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4704
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4711
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4712
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4713
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4714
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4715
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4721
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4728
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4729
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4735
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4743
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4760
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4767
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4775
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4776
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4777
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4788
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4792
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4795
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4796
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4806
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4807
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4817
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4819
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4842
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4851
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4853
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4854
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4856
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4857
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4864 
## time series starts 2012-07-27
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4870
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4871
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4872
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4873
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4874
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4876
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4896
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4903
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4915
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4920
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4921
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4922
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4923
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4924
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4925
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4926
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4933
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4936
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4941
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4945
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4948
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4949
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4950
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4952
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4959
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4960
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4962
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4969
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4977
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4981
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4982
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4983
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  4987 
## time series starts 2012-07-30
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5000
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5003
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5013
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5016
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5017
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5018
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5021
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5028 
## time series starts 2012-05-15
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5034
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5037
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5042
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5053
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5054
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5057
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5061 
## time series starts 2012-08-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5076
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5088
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5100
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5101
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5102
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5103
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5105
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5106
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5108
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5109
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5111 
## time series starts 2012-08-10
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5126
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5136
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5138
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5142
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5146
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5147
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5150
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5151
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5152 
## time series starts 2012-08-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5167
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5176
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5179
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5180
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5183
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5190
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5193
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5204
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5205
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5209
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5210
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5211
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5212
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5215
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5229
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5230
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5231
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5232
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5238
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5257
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5260
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5261
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5279
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5291
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5293
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5294
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5297
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5302
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5303
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5308
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5315
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5316
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5318 
## time series starts 2012-07-27
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5328
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5329
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5330
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5331
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5332
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5333
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5334
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5339 
## time series starts 2012-07-25
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5348
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5352
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5356
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5362
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5363
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5369
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5370
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5371
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5373
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5375
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5378
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5379
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5384
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5385
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5387
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5388
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5389
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5390
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5391
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5392
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5398
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5399
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5406
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5408 
## time series starts 2012-06-29
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5428
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5429
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5436
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5437
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5438
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5443
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5448
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5452 
## time series starts 2012-07-26
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5460
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5465
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5478
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5484
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5490
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5491
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5492
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5495
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5496
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5498
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5499
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5503
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5504
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5507
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5508
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5513
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5514
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5516
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5517
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5518
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5520
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5525
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5540
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5559
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5560 
## time series starts 2012-07-20
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5566
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5569
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5570
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5573
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5574
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5582 
## time series starts 2012-05-04
## time series starts 2012-05-25
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5595
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5596
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5597
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5600
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5601
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5606
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5610
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5617
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5620
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5625
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5641
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5653
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5654
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5669
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5670
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5671
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5677
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5693
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5695
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5699
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5700
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5701
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5703
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5706 
## time series starts 2012-05-30
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5712
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5713
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5714
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5715
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5716
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5717
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5718
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5719
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5720
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5721
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5722
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5724
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5725
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5726
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5727
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5728
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5732
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5739
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5745
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5751
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5760
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5762
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5766
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5767
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5772
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5774
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5775
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5776
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5782
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5783
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5784
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5785
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5786
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5787
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5789
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5790
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5791
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5793
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5794
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5795
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5806
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5807
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5809
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5812
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5815
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5817
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5818
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5821
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5827
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5828
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5832
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5840
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5843
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5849
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5855
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5859
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5860 
## time series starts 2012-05-03
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5868
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5871
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5881
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5882
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5883
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5889 
## time series starts 2012-08-24
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5901
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5902
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5906
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5907
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5908
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5909
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5910
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5912
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5915
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5916
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5917
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5919
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5923
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5924
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5927
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5928
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5929
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5932
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5935
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5936
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5941
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5946
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5950
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5957
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5963
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5966
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5970
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5990
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  5992
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6000 
## time series starts 2012-05-25
## time series starts 2012-07-23
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6010
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6013
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6020
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6026
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6035
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6039
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6046
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6049
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6051
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6052
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6053
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6054
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6057
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6058
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6060
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6061
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6062
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6063
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6064
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6065
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6069
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6070
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6071
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6072
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6076
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6085
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6086
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6093
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6096
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6100
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6103 
## time series starts 2012-07-26
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6115
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6116
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6125
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6132
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6133
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6136
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6140
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6143
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6144
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6145
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6147
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6150
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6151
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6152
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6154
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6156
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6173
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6176
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6189 
## time series starts 2012-05-04
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6211
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6213
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6217
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6221
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6222
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6225
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6229
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6231
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6232
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6242
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6243
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6246
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6256
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6257
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6279
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6284
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6286
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6289
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6293
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6301
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6302
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6304
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6305
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6318
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6331
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6333
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6334
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6335
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6336
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6337
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6347
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6355
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6363
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6364
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6374
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6377
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6378
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6381
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6383
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6387 
## time series starts 2012-07-13
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6393
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6397
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6408
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6413 
## time series starts 2012-05-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6421
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6425
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6426
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6429
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6432
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6441
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6442
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6443
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6444
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6445
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6446
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6447
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6452
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6461 
## time series starts 2012-05-11
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6473
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6478
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6483
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6487 
## time series starts 2012-08-16
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6501
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6502
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6507
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6520
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6535
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6539
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6540
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6541
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6542
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6543
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6546
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6550
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6553
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6555
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6556
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6557
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6558
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6559
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6560
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6561
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6562
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6563
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6564
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6565
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6566
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6567
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## download error, retrying ...
```

```
## Warning: cannot open: HTTP status was '404 Not Found'
```

```
## skip loop  6568
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


