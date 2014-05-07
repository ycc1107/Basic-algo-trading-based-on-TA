Select the all ticker stocks from market at time between 2012-05-02 and 2012-09-06
were using to train the training strategy model. The decision tree model after training shows as
follow. Where the volume stands for the volume of day divided by the volume of average of
past 10 days. The MACD stands for the percentage change of MACD and MACD signal.

Basically the model indicates:
+ When volume great than 0.59 times of 10 days average volume and less than 1.14 time of
10 day average volume, there is a buy signal
+ When volume less than 0.59 times if 10 days average volume and RSI great than 47.65,
there is a buy signal
+ When volume less than 1.14 times if 10 days average volume and MACD less than 1.19
time of MACD signal, there is a buy signal
+ When volume less than 1.14 less than 1.79 times if 10 days average volume and MACD
great than 1.19 time of MACD signal, there is a sell signal
+ Other times will be seen as a hold signal
