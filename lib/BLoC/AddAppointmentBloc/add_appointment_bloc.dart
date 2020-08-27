import 'dart:async';
import 'package:appointmentproject/model/professional.dart';
import 'package:appointmentproject/repository/sub_services_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import './bloc.dart';

class AddAppointmentBloc
    extends Bloc<AddAppointmentEvent, AddAppointmentState> {
  @override
  AddAppointmentState get initialState => InitialAddAppointmentState();

  @override
  Stream<AddAppointmentState> mapEventToState(
    AddAppointmentEvent event,
  ) async* {
    if (event is TapOnServiceEvent) {
      yield TapOnServiceState(
          selectedService: event.serviceID,
          subServicesList: await SubServiceRepository.defaultConstructor()
              .getSubServicesList(event.serviceID));
    } else if (event is TapOnSubServiceEvent) {
      print(event.subServiceID);
      yield TapOnSubServiceState(
        professionals: await Professional.defaultConstructor()
            .getListOfProfessionalsBySubService(event.subServiceID),
        subServicesList: await SubServiceRepository.defaultConstructor()
            .getSubServicesList(event.serviceID),
        selectedService: event.serviceID,
        selectedSubService: event.subServiceID,
      );
    } else if (event is NearByProfessionalsEvent) {
      try{
        List<double> distances = await getDistance(event.professionals);
        // now run sorting
        sorting(event.professionals, distances);
        // sorting done
        yield NearByProfessionalsState(
            professionals: event.professionals,
            subServices: event.subServices,
            selectedService: event.selectedService,
            selectedSubService: event.selectedSubService,
            distances: distances);
      }catch(exception){
        if(exception is PlatformException){
          if(exception.code == "PERMISSION_DENIED"){
            yield LocationPermissionDeniedState(
              subServices: event.subServices,
              selectedService: event.selectedService,
              selectedSubService: event.selectedSubService,
              professionals: event.professionals
            );
          }
        }
      }

    }
    else if(event is AllProfessionalsEvent){
      event.professionals.shuffle();
      yield AllProfessionalsState(
        professionals: event.professionals,
        subServices: event.subServices,
        selectedService: event.selectedService,
        selectedSubService: event.selectedSubService
      );
    }
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<double>> getDistance(List<Professional> professionals) async {

    List<double> distances = new List(professionals.length);
    int distancesIndex=0;
    Position position = await getCurrentPosition();
    await Future.forEach(professionals, (element) async{
      double distanceInMeters = await Geolocator().distanceBetween(
          position.latitude, position.longitude, element.appointmentLocation.latitude, element.appointmentLocation.longitude);
      distanceInMeters = double.parse((distanceInMeters/1000).toStringAsFixed(2));
      distances[distancesIndex] = distanceInMeters;
      distancesIndex++;
    });
    return  distances;
  }



  sorting(List<Professional> professional,List<double> distances){
    QuickSort qs = QuickSort(professional);
    qs.sort(distances, 0, distances.length-1);
    qs.printArray(distances);
  }



}















class QuickSort
{

  List<Professional> professional;
  QuickSort(this.professional);
  /* This function takes last element as pivot, 
       places the pivot element at its correct 
       position in sorted array, and places all 
       smaller (smaller than pivot) to left of 
       pivot and all greater elements to right 
       of pivot */
  int partition(List<double> arr, int low, int high)
  {
    double pivot = arr[high];
    int i = (low-1); // index of smaller element 
    for (int j=low; j<high; j++)
    {
      // If current element is smaller than or 
      // equal to pivot 
      if (arr[j] <= pivot)
      {
        i++;

        // swap arr[i] and arr[j] 
        double temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
        Professional tem = professional[i];
        professional[i] = professional[j];
        professional[j] = tem;
      }
    }

    // swap arr[i+1] and arr[high] (or pivot) 
    double temp = arr[i+1];
    arr[i+1] = arr[high];
    arr[high] = temp;
    Professional tem = professional[i+1];
    professional[i+1] = professional[high];
    professional[high] = tem;

    return i+1;
  }


  /* The main function that implements QuickSort() 
      arr[] --> Array to be sorted, 
      low  --> Starting index, 
      high  --> Ending index */
  void sort(List<double> arr, int low, int high)
  {
    if (low < high)
    {
      /* pi is partitioning index, arr[pi] is  
              now at right place */
      int pi = partition(arr, low, high);

      // Recursively sort elements before 
      // partition and after partition 
      sort(arr, low, pi-1);
      sort(arr, pi+1, high);
    }
  }

  void printArray(List<double> arr)
  {
    print("distance sorting function");
    int n = arr.length;
    for (int i=0; i<n; ++i)
      print(arr[i]);

    print("distance name function");

    for(int i=0;i<professional.length;i++)
      print(professional[i].name);

  }

}


