import 'package:flutter/material.dart';
import 'package:flutter_application_1/http/cars/cars.dart';
import 'package:flutter_application_1/pages/menupages/create/enumMap/enum_map.dart';
import 'package:flutter_application_1/pages/menupages/provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';





class NameModal extends StatefulWidget{
 final MyEnum types;
 final Function update;
 final int id;
 const NameModal({required this.id, required this.update, required this.types,super.key});
  @override
  State<NameModal> createState() => _NameModalState();
}

class _NameModalState extends State<NameModal> {

List<CarModel> carModel=[];

String _searchText = '';

final FocusNode _focusNode =FocusNode();
bool _isFocused = false;
@override
  void initState() {
    _focusNode.addListener((){
      if(_focusNode.hasFocus&&_searchText.isEmpty){
        setState(() {
          _isFocused=true;
        });
      }if(!_focusNode.hasFocus&&_searchText.isEmpty){
        setState(() {
          _isFocused=false;
        });
      }
    });
    super.initState();
  }

void _clickValue(CarModel model){
    widget.update(model);
    Navigator.pop(context);
}

@override
void dispose() {
  _focusNode.dispose();
  super.dispose();
}



Map<MyEnum,dynamic> funcModel ={
  MyEnum.model: ""
};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24,bottom: 20,right: 24),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              SvgPicture.asset(
                "assets/svg/back.svg",
                width: 6,
                height: 12,
                ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "Выбирите ${typeWindow[widget.types]}",
                  style: const TextStyle(
                    
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(51,51,51,1)
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            alignment: Alignment.center,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 184, 181, 172)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    _searchText = text; // Сохраняем текст в переменной _searchText
                  });},
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
        ),
            Visibility(
              visible: _isFocused||_searchText.isNotEmpty,
              child: FutureBuilder<List<CarModel>>(
              future: widget.types==MyEnum.name?CarsHttp().getName(_searchText):CarsHttp().getModel(_searchText, widget.id), // Асинхронно получаем список CarModel
              builder: (BuildContext context, AsyncSnapshot<List<CarModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 43),
                    child: CircularProgressIndicator(),
                  ); // Отображаем индикатор загрузки пока данные загружаются
                } else {
                  if (snapshot.hasError) {
                    return const Text('Ошибка загрузки данных'); // Обработка ошибки, если она произошла
                  } else {
                    List<CarModel>? carModels = snapshot.data;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: carModels!.length<5?carModels.length:5,
                          itemBuilder: (BuildContext context, int index) {
                            CarModel car = carModels[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 15,right: 6),
                              child: InkWell(
                                onTap:(){
                                  _clickValue(carModels[index]);
                                },
                                child: ListTile(
                                  trailing: SizedBox(
                                    height: 43,
                                    child: SvgPicture.asset(
                                      "assets/svg/upToMap.svg"
                                    ),
                                  ),
                                  tileColor: const Color.fromARGB(255, 128, 121, 101),
                                  title: Text(
                                    car.name,
                                    style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(51,51,51,1)
                                    ),
                                    ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                }
              },
                 ),
            ),
      ],
    );
    
  }
}