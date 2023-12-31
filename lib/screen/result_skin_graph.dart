import 'package:capstonefe/screen/result_skin_each.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constant/color.dart';
import '../controller/skin_data_controller.dart';
import 'home_screen.dart';

class ResultSkinGraph extends StatefulWidget {
  @override
  State<ResultSkinGraph> createState() => _ResultSkinGraphState();
}

class _ResultSkinGraphState extends State<ResultSkinGraph> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime finalDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SkinDataController>(
      init: SkinDataController(),
      builder: (SkinDataController skinDataController) {
        return Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          body: Center(
            child: FutureBuilder<List<PetSkinData>>(
              future: skinDataController.loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('기록 불러오는중...'),
                      CircularProgressIndicator(),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No data available');
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                          color: DEFAULT_BLUE,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pets,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  '뽀삐의 피부 진단기록',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BMJUA',
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.pets,
                                color: Colors.white.withOpacity(0.7),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '6세 / 여아 / 총 16개의 진단기록',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'BMJUA',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'BMJUA',
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black.withOpacity(0.5),
                                side: BorderSide(color: Color(0XFFDDDDDD)),
                                minimumSize: Size(125, 23),
                              ),
                              onPressed: () async {
                                final selectedDateRange =
                                    await showDateRangePicker(
                                        context: context,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime.now(),
                                        initialEntryMode:
                                            DatePickerEntryMode.calendarOnly,
                                        initialDateRange: DateTimeRange(
                                          start: startDate,
                                          end: finalDate,
                                        ));
                                if (selectedDateRange != null) {
                                  setState(() {
                                    startDate = selectedDateRange.start;
                                    finalDate = selectedDateRange.end;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${startDate.year.toString()}/${startDate.month.toString().padLeft(2, '0')}/${startDate.day.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontFamily: 'BMJUA',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'BMJUA',
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black.withOpacity(0.5),
                                side: BorderSide(color: Color(0XFFDDDDDD)),
                                minimumSize: Size(125, 23),
                              ),
                              onPressed: () async {
                                final selectedDateRange =
                                    await showDateRangePicker(
                                        context: context,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime.now(),
                                        initialEntryMode:
                                            DatePickerEntryMode.calendarOnly,
                                        initialDateRange: DateTimeRange(
                                          start: startDate,
                                          end: finalDate,
                                        ));
                                if (selectedDateRange != null) {
                                  setState(() {
                                    startDate = selectedDateRange.start;
                                    finalDate = selectedDateRange.end;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${finalDate.year.toString()}/${finalDate.month.toString().padLeft(2, '0')}/${finalDate.day.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontFamily: 'BMJUA',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: (skinDataController.data!.length * 200)
                              .toDouble(),
                          height: 380,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: BarChart(

                              BarChartData(

                                groupsSpace: 1,
                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        if (skinDataController.data != null &&
                                            value.toInt() <
                                                skinDataController
                                                    .data!.length) {
                                          final dateString = DateFormat('MM/dd')
                                              .format(skinDataController
                                                  .data![value.toInt()]
                                                  .diagnosisDate);
                                          return Text(
                                            dateString,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'BMJUA',
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      reservedSize: 70,
                                      showTitles: true,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        PetSkinData item;
                                        if (skinDataController.data != null &&
                                            value.toInt() <
                                                skinDataController
                                                    .data!.length) {
                                          item=skinDataController.data![value.toInt()];
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                skinDataController
                                                    .data![value.toInt()]
                                                    .results[0],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'BMJUA',
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Text(
                                                '${(skinDataController.data![value.toInt()].resultValues[0] * 100).toInt()}%',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'BMJUA',
                                                  color: Colors.black
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              Container(
                                                width: 57,
                                                height: 25,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    Get.to(ResultSkinEach(item: item!));
                                                  },
                                                  style: OutlinedButton
                                                      .styleFrom(
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 0,
                                                      vertical: 0,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        size: 12,
                                                      ),
                                                      Text(
                                                        '상세보기',
                                                        softWrap: false,
                                                        style: TextStyle(
                                                          fontFamily: 'BMJUA',
                                                          fontSize: 10,
                                                          overflow:
                                                          TextOverflow
                                                              .visible,
                                                          color: DEFAULT_BLUE,

                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                barGroups: _getBarGroups(),

                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false, // This removes the vertical lines
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: DEFAULT_BLUE,
                              elevation: 0,
                              padding: EdgeInsets.all(0),
                              minimumSize: Size(54, 54),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: DEFAULT_BLUE)),
                            ),
                            onPressed: () {
                              Get.offAll(HomeScreen());
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home_outlined,
                                  size: 22,
                                ),
                                Text(
                                  'HOME',
                                  style: TextStyle(
                                    fontFamily: 'BMJUA',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DEFAULT_BLUE,
                                onPrimary: BACKGROUND_COLOR,
                                shadowColor: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {},
                              child: SizedBox(
                                height: 54,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.pets,
                                        size: 16.0,
                                      ),
                                      Text(
                                        '비만도 진단기록 확인하러 가기',
                                        style: TextStyle(
                                          fontFamily: 'BMJUA',
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

List<BarChartGroupData> _getBarGroups() {
  final SkinDataController skinDataController = Get.find();

  List<BarChartGroupData> barGroups = [];
  for (int i = 0; i < skinDataController.data!.length; i++) {
    barGroups.add(
      BarChartGroupData(

        x: i,
        barRods: [
          for (int j = 0; j < 3; j++)
            BarChartRodData(
              toY: skinDataController.data![i].resultValues[j],
              color: skinDataController.data![i].results[j] == '무증상'
                  ? CHART_GREEN
                  : CHART_RED,
              width: 20,
            )
        ],
        barsSpace: 10,
      ),
    );
  }
  return barGroups;
}
