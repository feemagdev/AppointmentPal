part of 'splash_screen_bloc.dart';


abstract class SplashScreenEvent {}

class SplashScreenStartEvent extends SplashScreenEvent{}

class SplashScreenEndedEvent extends SplashScreenEvent {}