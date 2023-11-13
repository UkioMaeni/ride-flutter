import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum NavigationEvent { MessagesPage }

class NavigationBloc extends Bloc<NavigationEvent, dynamic> {
  NavigationBloc() : super(null);

  @override
  Stream<dynamic> mapEventToState(NavigationEvent event) async* {
    if (event == NavigationEvent.MessagesPage) {
      yield '/messages'; 
    }
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
