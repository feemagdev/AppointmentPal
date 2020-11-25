import 'dart:async';

import 'package:appointmentproject/model/custom_time_slots.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/custom_time_slots_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_custom_time_slot_event.dart';

part 'add_custom_time_slot_state.dart';

class AddCustomTimeSlotBloc
    extends Bloc<AddCustomTimeSlotEvent, AddCustomTimeSlotState> {
  final Professional professional;
  final String day;

  AddCustomTimeSlotBloc({@required this.professional, @required this.day});

  @override
  Stream<AddCustomTimeSlotState> mapEventToState(
    AddCustomTimeSlotEvent event,
  ) async* {
    if (event is ProfessionalAddCustomTimeSlotEvent) {
      yield AddCustomSlotLoadingState();
      int tempFromTime = event.from.hour * 60 + event.from.minute;
      int tempToTime = event.to.hour * 60 + event.to.minute;
      print(tempFromTime);
      print(tempToTime);
      if (tempFromTime >= tempToTime) {
        yield WrongTimeSelectedState();
      } else {
        List<CustomTimeSlots> customTimeSlots =
            await CustomTimeSlotRepository.defaultConstructor()
                .getListOfCustomTimeSlotsOfSpecificDay(
                    day, professional.getProfessionalID());
        if (customTimeSlots.isEmpty || customTimeSlots.length == 0) {
          bool checked = await addCustomTimeSlot(event.from, event.to);
          if (checked) {
            yield CustomSlotTimeSlotAddedSuccessfullyState(
                customTimeSlots: await getCustomTimeSlotList());
          }
        } else {
          bool checkExist =
              checkTimeSlotExists(customTimeSlots, event.from, event.to);
          if (checkExist == false) {
            bool addedCheck = false;
            addedCheck = await addCustomTimeSlot(event.from, event.to);
            if (addedCheck) {
              yield CustomSlotTimeSlotAddedSuccessfullyState(
                  customTimeSlots: await getCustomTimeSlotList());
            }
          } else {
            print("time slot already exists");
            yield CustomTimeSlotNotAdded();
          }
        }
      }
    } else if (event is GetCustomTimeSlotEvent) {
      yield AddCustomSlotLoadingState();
      yield GetCustomTimeSlotsState(
          customTimeSlots: await getCustomTimeSlotList());
    } else if (event is DeleteCustomTimeSlotEvent) {
      yield AddCustomSlotLoadingState();
      bool check = await CustomTimeSlotRepository.defaultConstructor()
          .deleteCustomTimeSlot(event.customTimeSlots.getTimeSlotID(),
              professional.getProfessionalID(), day);
      if (check) {
        yield CustomTimeSlotDeletedSuccessfully();
        yield GetCustomTimeSlotsState(
            customTimeSlots: await getCustomTimeSlotList());
      }
    }
  }

  @override
  AddCustomTimeSlotState get initialState => AddCustomTimeSlotInitial();

  Future<List<CustomTimeSlots>> getCustomTimeSlotList() async {
    return await CustomTimeSlotRepository.defaultConstructor()
        .getListOfCustomTimeSlotsOfSpecificDay(
            day, professional.getProfessionalID());
  }

  bool checkTimeSlotExists(List<CustomTimeSlots> customTimeSlots,
      DateTime fromDateTime, DateTime toDateTime) {
    int fromCheckMinutes = fromDateTime.hour * 60 + fromDateTime.minute;
    int toCheckMinutes = toDateTime.hour * 60 + toDateTime.minute;

    int index = 0;
    bool check1 = false;
    while (true) {
      int fromTimeMinutes = customTimeSlots[index].getFromTime().hour * 60 +
          customTimeSlots[index].getFromTime().minute;
      int toTimeMinutes = customTimeSlots[index].getToTime().hour * 60 +
          customTimeSlots[index].getToTime().minute;

      if (fromCheckMinutes > fromTimeMinutes &&
          toCheckMinutes < toTimeMinutes) {
        check1 = true;
        break;
      } else if (fromTimeMinutes > fromCheckMinutes &&
          toTimeMinutes < toCheckMinutes) {
        check1 = true;
        break;
      } else if (fromCheckMinutes > fromTimeMinutes &&
          fromCheckMinutes < toTimeMinutes) {
        check1 = true;
        break;
      } else if (fromCheckMinutes < fromTimeMinutes &&
          toCheckMinutes > fromTimeMinutes) {
        check1 = true;
        break;
      }
      index++;
      if (index == customTimeSlots.length) {
        break;
      }
    }
    if (check1 == false) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> addCustomTimeSlot(DateTime from, DateTime to) async {
    return await CustomTimeSlotRepository.defaultConstructor()
        .addCustomTimeSlot(from, to, day, professional.getProfessionalID());
  }
}
