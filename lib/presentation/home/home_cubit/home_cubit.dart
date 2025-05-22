import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_app/presentation/home/model/Doctor.model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // Declare a list to store fetched data


  HomeCubit() : super(HomeInitial());
  List<Doctor> data= [];
  fetchHomeData() async {

    try {
      data.clear();
      emit(TopdoctorHomeloading());
      //
      // Fetch data from Firestore
      CollectionReference doctor =
      FirebaseFirestore.instance.collection("Doctor");
      QuerySnapshot doctorData =
      await doctor.orderBy("Rating", descending: true).get();
      data.clear();

      for (var element in doctorData.docs) {
        data.add(Doctor.fromJson(element.data()as Map<String, dynamic>));
      }

      emit(TopdoctorHomeSuccefully());

    }
    catch (e) {
      // Emit error state if any exception occurs
      emit(TopdoctorHomeError(error: "Failed to load data: $e"));
    }
  }

}
