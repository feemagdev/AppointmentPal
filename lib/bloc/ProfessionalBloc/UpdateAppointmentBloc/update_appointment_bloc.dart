import 'dart:async';
import 'dart:convert';

import 'package:appointmentproject/model/appointment.dart';
import 'package:appointmentproject/model/customer.dart';
import 'package:appointmentproject/model/manager.dart';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/model/sms.dart';
import 'package:appointmentproject/repository/appointment_repository.dart';
import 'package:appointmentproject/repository/payment_respository.dart';
import 'package:appointmentproject/repository/sms_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

part 'update_appointment_event.dart';
part 'update_appointment_state.dart';

class UpdateAppointmentBloc
    extends Bloc<UpdateAppointmentEvent, UpdateAppointmentState> {
  final Professional professional;
  final Appointment appointment;
  final Customer customer;
  final Manager manager;

  UpdateAppointmentBloc(
      {@required this.professional,
      @required this.appointment,
      @required this.customer,
      this.manager});

  @override
  Stream<UpdateAppointmentState> mapEventToState(
    UpdateAppointmentEvent event,
  ) async* {
    if (event is UpdateAppointmentDateTimeEvent) {
      yield UpdateAppointmentDateTimeState();
    } else if (event is MoveToEditAppointmentScreenEvent) {
      yield MoveToEditAppointmentScreenState();
    } else if (event is UpdateAppointmentSelectCustomerEvent) {
      yield UpdateAppointmentSelectCustomerState();
    } else if (event is CancelAppointmentEvent) {
      yield UpdateAppointmentLoadingState();
      await AppointmentRepository.defaultConstructor()
          .cancelAppointment(event.appointment.getAppointmentID());
      if (event.smsCheck) {
        if (professional.getManagerID() != "") {
          bool check = await PaymentRepository.defualtConstructor()
              .getManagerPaymentStatus(professional.getManagerID());
          if (check) {
            yield AppointmentCancelledSuccessfullyState();
            yield UpdateAppointmentScreenSmsServiceNotPurchasesState();
          } else {
            String message =
                "hi ${customer.getName()}, your appointment have been cancelled with ${professional.getName()} at ${DateFormat.yMMMMd('en_US').add_jm().format(appointment.getAppointmentStartTime().toDate())}";

            final http.Response response =
                await SmsRepository.defaultConstructor()
                    .sendSMS(customer.getPhone(), message);

            if (response.statusCode == 200) {
              Map map = Sms.defaultConstructor().smsMap(
                  professionalID: professional.getProfessionalID(),
                  customerID: customer.getCustomerID(),
                  message: message);
              await SmsRepository.defaultConstructor().saveSmsDetails(map);
              yield AppointmentCancelledSuccessfullyState();
            } else {
              var test = jsonDecode(response.body);
              Map<String, dynamic> api1 = test['errors'][0];
              UpdateAppointmentSuccessfullyWithoutMessage(
                  message: api1['title']);
            }
          }
        } else {
          bool check = await PaymentRepository.defualtConstructor()
              .getProfessionalPaymentStatus(professional.getProfessionalID());
          if (check) {
            yield AppointmentCancelledSuccessfullyState();
            yield UpdateAppointmentScreenSmsServiceNotPurchasesState();
          } else {
            String message =
                "hi ${customer.getName()}, your appointment have been cancelled with ${professional.getName()} at ${DateFormat.yMMMMd('en_US').add_jm().format(appointment.getAppointmentStartTime().toDate())}";

            final http.Response response =
                await SmsRepository.defaultConstructor()
                    .sendSMS(customer.getPhone(), message);

            if (response.statusCode == 200) {
              Map map = Sms.defaultConstructor().smsMap(
                  professionalID: professional.getProfessionalID(),
                  customerID: customer.getCustomerID(),
                  message: message);
              await SmsRepository.defaultConstructor().saveSmsDetails(map);
              yield AppointmentCancelledSuccessfullyState();
            } else {
              yield AppointmentCancelledSuccessfullyState();
              var test = jsonDecode(response.body);
              Map<String, dynamic> api1 = test['errors'][0];

              yield UpdateAppointmentSuccessfullyWithoutMessage(
                  message: api1['title']);
            }
          }
        }
      } else {
        yield AppointmentCancelledSuccessfullyState();
      }
    } else if (event is UpdateAppointmentButtonPressedEvent) {
      yield UpdateAppointmentLoadingState();
      appointment.setCustomerID(customer.getCustomerID());

      await AppointmentRepository.defaultConstructor()
          .updateAppointment(appointment);

      if (event.smsCheck) {
        if (professional.getManagerID() != "") {
          bool check = await PaymentRepository.defualtConstructor()
              .getManagerPaymentStatus(professional.getManagerID());
          if (check) {
            yield AppointmentUpdatedSuccessfullyState();
            yield UpdateAppointmentScreenSmsServiceNotPurchasesState();
          } else {
            String message =
                "hi ${customer.getName()}, your appointment have been updated with ${professional.getName()} at ${DateFormat.yMMMMd('en_US').add_jm().format(appointment.getAppointmentStartTime().toDate())}\n Please be on time";

            final http.Response response =
                await SmsRepository.defaultConstructor()
                    .sendSMS(customer.getPhone(), message);

            if (response.statusCode == 200) {
              Map map = Sms.defaultConstructor().smsMap(
                  professionalID: professional.getProfessionalID(),
                  customerID: customer.getCustomerID(),
                  message: message);
              await SmsRepository.defaultConstructor().saveSmsDetails(map);
              yield AppointmentUpdatedSuccessfullyState();
            } else {
              var test = jsonDecode(response.body);
              Map<String, dynamic> api1 = test['errors'][0];
              UpdateAppointmentSuccessfullyWithoutMessage(
                  message: api1['title']);
            }
          }
        } else {
          bool check = await PaymentRepository.defualtConstructor()
              .getProfessionalPaymentStatus(professional.getProfessionalID());
          if (check) {
            yield AppointmentUpdatedSuccessfullyState();
            yield UpdateAppointmentScreenSmsServiceNotPurchasesState();
          } else {
            String message =
                "hi ${customer.getName()}, your appointment have been updated with ${professional.getName()} at ${DateFormat.yMMMMd('en_US').add_jm().format(appointment.getAppointmentStartTime().toDate())}\n Please be on time";

            final http.Response response =
                await SmsRepository.defaultConstructor()
                    .sendSMS(customer.getPhone(), message);

            if (response.statusCode == 200) {
              Map map = Sms.defaultConstructor().smsMap(
                  professionalID: professional.getProfessionalID(),
                  customerID: customer.getCustomerID(),
                  message: message);
              await SmsRepository.defaultConstructor().saveSmsDetails(map);
              yield AppointmentUpdatedSuccessfullyState();
            } else {
              yield AppointmentUpdatedSuccessfullyState();
              var test = jsonDecode(response.body);
              Map<String, dynamic> api1 = test['errors'][0];

              yield UpdateAppointmentSuccessfullyWithoutMessage(
                  message: api1['title']);
            }
          }
        }
      } else {
        yield AppointmentUpdatedSuccessfullyState();
      }
    }
  }

  @override
  UpdateAppointmentState get initialState => UpdateAppointmentInitial();
}
