import 'dart:async';
import 'dart:convert';

import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/sms.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/payment_respository.dart';
import 'package:appointmentproject/repository/sms_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

part 'appointment_booking_event.dart';

part 'appointment_booking_state.dart';

class AppointmentBookingBloc
    extends Bloc<AppointmentBookingEvent, AppointmentBookingState> {
  final Professional professional;
  final Customer customer;
  final DateTime appointmentStartTime;
  final DateTime appointmentEndTime;
  final Manager manager;

  AppointmentBookingBloc(
      {@required this.professional,
      @required this.customer,
      @required this.appointmentStartTime,
      @required this.appointmentEndTime,
      this.manager});

  @override
  Stream<AppointmentBookingState> mapEventToState(
    AppointmentBookingEvent event,
  ) async* {
    if (event is AddAppointmentButtonPressedEvent) {
      yield AppointmentBookingLoadingState();
      await AppointmentRepository.defaultConstructor()
          .professionalMakeAppointment(
              event.professional.getProfessionalID(),
              event.customer.getCustomerID(),
              Timestamp.fromDate(event.appointmentStartTime),
              Timestamp.fromDate(event.appointmentEndTime),
              'booked');
      if (event.smsCheck) {
        if (event.professional.getManagerID() != null ||
            event.professional.getManagerID() != "") {
          bool check = await PaymentRepository.defualtConstructor()
              .getManagerPaymentStatus(event.professional.getManagerID());
          if (check) {
            yield AppointmentBookedSuccessfully(
                professional: event.professional);
            yield AppointmentBookingScreenSmsServiceNotPurchasesState();
          } else {
            String message =
                "hi ${event.customer.getName()}, your appointment have been booked with ${event.professional.getName()} at ${DateFormat.yMMMMd('en_US').add_jm().format(event.appointmentStartTime)} \n Please be on time";

            final http.Response response =
                await SmsRepository.defaultConstructor()
                    .sendSMS(event.customer.getPhone(), message);

            if (response.statusCode == 200) {
              Map map = Sms.defaultConstructor().smsMap(
                  professionalID: event.professional.getProfessionalID(),
                  customerID: event.customer.getCustomerID(),
                  message: message);
              await SmsRepository.defaultConstructor().saveSmsDetails(map);
              yield AppointmentBookedSuccessfully(
                  professional: event.professional);
            } else {
              var test = jsonDecode(response.body);
              Map<String, dynamic> api1 = test['errors'][0];
              AppointmentBookedSuccessfullyWithoutMessage(
                  message: api1['title']);
            }
          }
        } else {
          bool check = await PaymentRepository.defualtConstructor()
              .getProfessionalPaymentStatus(
                  event.professional.getProfessionalID());
          if (check) {
            yield AppointmentBookedSuccessfully(
                professional: event.professional);
            yield AppointmentBookingScreenSmsServiceNotPurchasesState();
          } else {
            String message =
                "hi ${event.customer.getName()}, your appointment have been booked with ${event.professional.getName()} at ${DateFormat.yMMMMd('en_US').add_jm().format(event.appointmentStartTime)} \n Please be on time";

            final http.Response response =
                await SmsRepository.defaultConstructor()
                    .sendSMS(event.customer.getPhone(), message);

            if (response.statusCode == 200) {
              Map map = Sms.defaultConstructor().smsMap(
                  professionalID: event.professional.getProfessionalID(),
                  customerID: event.customer.getCustomerID(),
                  message: message);
              await SmsRepository.defaultConstructor().saveSmsDetails(map);
              yield AppointmentBookedSuccessfully(
                  professional: event.professional);
            } else {
              yield AppointmentBookedSuccessfully(
                  professional: event.professional);
              var test = jsonDecode(response.body);
              Map<String, dynamic> api1 = test['errors'][0];

              yield AppointmentBookedSuccessfullyWithoutMessage(
                  message: api1['title']);
            }
          }
        }
      } else {
        yield AppointmentBookedSuccessfully(professional: event.professional);
      }
    }
  }

  @override
  AppointmentBookingState get initialState => AppointmentBookingInitial(
      customer: customer,
      appointmentStartTime: appointmentStartTime,
      appointmentEndTime: appointmentEndTime);
}
