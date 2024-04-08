import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/controller.dart';
import 'package:weather_app/screen/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherDataProvider>(
      builder: (context, weatherProvider, _) {
        String formattedDate = DateFormat.yMMMd().format(
          DateTime.now(),
        );

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: const Icon(Icons.location_on,color: Colors.white,),
            title: Text(weatherProvider.cityModel?.name ?? '',
            style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.search,color: Colors.white,),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert,color: Colors.white,))
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        
                        borderRadius: BorderRadius.all(
                          Radius.circular(17),
                        ),
                        color: Color.fromARGB(255, 16, 83, 198),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today $formattedDate',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${weatherProvider.weatherData?.weather?[0].main}',
                              style: const TextStyle(
                                color: Colors.white,
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${weatherProvider.weatherData?.main?.temp} °C',
                                  style: const TextStyle(fontSize: 30,
                                  color: Colors.white),
                                ),
                                Text(
                                  ' ${weatherProvider.weatherData?.main?.tempMax.toString()}°C,  ${weatherProvider.weatherData?.main?.tempMin.toString()}°C',
                                  style: const TextStyle(fontSize: 14,
                                  color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    // Call the method to fetch weather data again
                                    await weatherProvider.fetchWeatherData(
                                        weatherProvider.cityModel?.lat ?? 0.0,
                                        weatherProvider.cityModel?.lon ?? 0.0);

                                    // Call the method to fetch forecast data again
                                    await weatherProvider.fetchWeatherDataList(
                                        weatherProvider.cityModel?.lat ?? 0.0,
                                        weatherProvider.cityModel?.lon ?? 0.0);

                                    // Trigger a rebuild of the UI
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.refresh),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 82, 80, 80),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Feel like',
                                      style: TextStyle(
                                        color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.ac_unit,
                                        color: Colors.white,
                                        ),
                                        Text(
                                            '${weatherProvider.weatherData?.main?.feelsLike} °C',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Humidity is making it',
                                      style: TextStyle(
                                        color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Row(
                                        children: [
                                          // Replace Icons.ac_unit with the desired icon
                                          Text(
                                              "${weatherProvider.weatherData?.weather?[0].description}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 82, 80, 80),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Wind Speed',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.wind_power,
                                    color: Colors.white,),
                                    Text(
                                        '${weatherProvider.weatherData?.wind?.speed}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                             color: Color.fromARGB(255, 82, 80, 80),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.water_drop,
                                    color: Colors.white,),
                                    Text(
                                        '${weatherProvider.weatherData?.main?.humidity} %',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Forecast Data Container
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 82, 80, 80),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.calendar_month,
                                color: Colors.white,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '5 day Forecast',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<WeatherDataProvider>(
                              builder: (context, weatherProvider, _) {
                                final weatherDataList =
                                    weatherProvider.weatherDataList;

                                if (weatherDataList != null &&
                                    weatherDataList.length >= 5) {
                                  // Sort the weather data list by date
                                  weatherDataList.sort(
                                      (a, b) => a.dtTxt.compareTo(b.dtTxt));

                                  return Column(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // Format the date from the forecast data
                                                DateFormat('EEE, MMM d').format(
                                                    DateTime.now().add(
                                                        Duration(days: i + 1))),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.white),
                                              ),
                                              Text(
                                                weatherDataList[i]
                                                    .weather[0]
                                                    .description,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                // Display the max and min temperatures
                                                '${weatherDataList[i].main.tempMax.round()}° / ${weatherDataList[i].main.tempMin.round()}°',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  );
                                } else {
                                  // If forecast list is null or doesn't have enough data, display a message
                                  return const Text(
                                      'Not enough forecast data available');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}