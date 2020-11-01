import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:horizontal_calendar_widget/date_helper.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';
import 'package:meta/meta.dart';

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class CustomDateView extends StatefulWidget {
  final onTap;
  const CustomDateView({
    Key key,
    @required this.onTap
  }) : super(key: key);

  @override
  _DemoWidgetState createState() => _DemoWidgetState(onTap: onTap);
}

class _DemoWidgetState extends State<CustomDateView> {
  DateTime firstDate;
  DateTime lastDate;
  String dateFormat = 'dd';
  String monthFormat = 'MMM';
  String weekDayFormat = 'EEE';
  bool isSelected = false;
  List<String> order = [labelMonth, labelDate, labelWeekDay];
  bool forceRender = false;
  final onTap;

  Color defaultDecorationColor = Color.fromRGBO(234, 245, 245, 1);
  BoxShape defaultDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusDefault = true;

  Color selectedDecorationColor = Colors.blue[400];
  BoxShape selectedDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusSelected = true;

  Color disabledDecorationColor = Colors.grey;
  BoxShape disabledDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusDisabled = true;

  int minSelectedDateCount = 0;
  int maxSelectedDateCount = 1;
  RangeValues selectedDateCount;

  List<DateTime> initialSelectedDates;

  _DemoWidgetState({@required this.onTap});


  @override
  void initState() {
    super.initState();
    const int days = 7;
    firstDate = toDateMonthYear(DateTime.now());
    lastDate = toDateMonthYear(firstDate.add(Duration(days: days - 1)));
    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
    initialSelectedDates = feedInitialSelectedDates(minSelectedDateCount, days);
  }

  List<DateTime> feedInitialSelectedDates(int target, int calendarDays) {
    List<DateTime> selectedDates = List();

    for (int i = 0; i < calendarDays; i++) {
      if (selectedDates.length == target) {
        break;
      }
      DateTime date = firstDate.add(Duration(days: i));
      if (date.weekday != DateTime.sunday) {
        selectedDates.add(date);
      }
    }

    return selectedDates;
  }

  @override
  Widget build(BuildContext context) {

    return calendar(context);
  }

  void showMessage(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget calendar(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return HorizontalCalendar(
      monthTextStyle: TextStyle(
        fontSize: deviceWidth < 360 ? 10:15
      ),
      weekDayTextStyle: TextStyle(
          fontSize: deviceWidth < 360 ? 10:15
      ),
      dateTextStyle: TextStyle(
          fontSize: deviceWidth < 360 ? 10:15
      ),

      onDateSelected: onTap,
      height: deviceWidth < 360 ? 80:120,
      padding: EdgeInsets.all(deviceWidth < 360 ? 15:22),
      firstDate: firstDate,
      lastDate: lastDate,
      dateFormat: dateFormat,
      weekDayFormat: weekDayFormat,
      monthFormat: monthFormat,
      defaultDecoration: BoxDecoration(
        color: defaultDecorationColor,
        shape: defaultDecorationShape,
        borderRadius: defaultDecorationShape == BoxShape.rectangle &&
            isCircularRadiusDefault
            ? BorderRadius.circular(8)
            : null,
      ),
      selectedDecoration: BoxDecoration(
        color: selectedDecorationColor,
        shape: selectedDecorationShape,
        borderRadius: selectedDecorationShape == BoxShape.rectangle &&
            isCircularRadiusSelected
            ? BorderRadius.circular(8)
            : null,
      ),
      disabledDecoration: BoxDecoration(
        color: disabledDecorationColor,
        shape: disabledDecorationShape,
        borderRadius: disabledDecorationShape == BoxShape.rectangle &&
            isCircularRadiusDisabled
            ? BorderRadius.circular(8)
            : null,
      ),
      labelOrder: order.map(toLabelType).toList(),
      minSelectedDateCount: minSelectedDateCount,
      maxSelectedDateCount: maxSelectedDateCount,
      initialSelectedDates: initialSelectedDates,
    );
  }

  bool isRangeValid(DateTime first, DateTime last, int minSelection) {
    int availableDays = availableDaysCount(
      getDateList(first, last),
      [DateTime.sunday],
    );

    return availableDays >= minSelection;
  }

  int availableDaysCount(List<DateTime> dates, List<int> disabledDays) =>
      dates.where((date) => !disabledDays.contains(date.weekday)).length;

  void dateRangeChange(DateTime first, DateTime last) {
    firstDate = first;
    lastDate = last;
    initialSelectedDates = feedInitialSelectedDates(
      minSelectedDateCount,
      daysCount(first, last),
    );
    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
  }
}

Future<DateTime> datePicker(
    BuildContext context,
    DateTime initialDate,
    ) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now().subtract(
      Duration(days: 365),
    ),
    lastDate: DateTime.now().add(
      Duration(days: 365),
    ),
  );
  return toDateMonthYear(selectedDate);
}

LabelType toLabelType(String label) {
  LabelType type;
  switch (label) {
    case labelMonth:
      type = LabelType.month;
      break;
    case labelDate:
      type = LabelType.date;
      break;
    case labelWeekDay:
      type = LabelType.weekday;
      break;
  }
  return type;
}

String fromLabelType(LabelType label) {
  String labelString;
  switch (label) {
    case LabelType.month:
      labelString = labelMonth;
      break;
    case LabelType.date:
      labelString = labelDate;
      break;
    case LabelType.weekday:
      labelString = labelWeekDay;
      break;
  }
  return labelString;
}
