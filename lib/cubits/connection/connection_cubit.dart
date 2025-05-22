import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'connection_event.dart';
import 'connection_state.dart';


class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  bool _isManuallyDisconnected = false;

  InternetBloc() : super(InternetInitial()) {
    on<InternetChecked>((event, emit) {
      if (_isManuallyDisconnected) {
        emit(InternetDisconnectedState());
      } else {
        emit(state);
      }
    });

    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (!_isManuallyDisconnected) {
        if (results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile)) {
          add(InternetConnected());
        } else {
          add(InternetDisconnected());
        }
      }
    });

    on<InternetConnected>((event, emit) => emit(InternetConnectedState()));
    on<InternetDisconnected>((event, emit) => emit(InternetDisconnectedState()));

    on<InternetManuallyDisconnected>((event, emit) {
      _isManuallyDisconnected = !_isManuallyDisconnected;
      emit(_isManuallyDisconnected ? InternetDisconnectedState() : InternetConnectedState());
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
// الأحداث
 // تعطيل يدوي

// class AppConnectivityBloc extends Bloc<ConnectedEvent, ConnectionStates>
// {
//   var subscribtion;
//   AppConnectivityBloc() : super(ConnectionInitial()){
//     on<ConnectedEvent>((event, emit){
//       if(event is ConnectionEvent){
//         emit(InternetConnected(
//             internetStates: 'Internet Connected'));
//       } else if(event is NotConnectionEvent){
//         emit(InternetNotConnected(
//             internetStates: 'Internet Not Connected'));
//       }
//     });
//     subscribtion =Connectivity().onConnectivityChanged.listen((value) {
//       if(value == ConnectivityResult.wifi ||
//           value == ConnectivityResult.mobile)
//       {
//         add(ConnectionEvent());
//       } else {
//         add(NotConnectionEvent());
//       }
//     });
//   }
//   @override
//   Future<void> close(){
//     subscribtion.cancel();
//     return super.close();
//   }
// }