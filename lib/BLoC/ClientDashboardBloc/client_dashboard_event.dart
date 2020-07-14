import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ClientDashboardEvent {}

// ignore: must_be_immutable
class SearchBarOnTapEvent extends ClientDashboardEvent {}

class AddAppointmentEvent extends ClientDashboardEvent{}
