import 'package:easy_debounce/easy_debounce.dart';

class Debounce{
  static run(Function fn,String text){
    EasyDebounce.debounce("one", Duration(milliseconds: 200), ()=>fn(text));
  }
}
