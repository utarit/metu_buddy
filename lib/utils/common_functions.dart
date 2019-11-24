String formattedNum(int number) => number < 10 ? "0$number" : "$number";
DateTime schoolStarted = DateTime.now().isBefore(DateTime.utc(2020, 2, 3))? DateTime.utc(2019, 9, 23): DateTime.utc(2020, 2, 3);
