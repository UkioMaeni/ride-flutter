
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/color_constants.dart';
import 'package:flutter_application_1/pages/menupages/create/enumMap/enum_map.dart';
import 'package:flutter_application_1/pages/menupages/create/modal/name_modal.dart';

import '../../provider/provider.dart';



class CardCar extends StatefulWidget{
 final MyEnum types;
 final Function update;
 final String title;
  final CarModel other;
  const CardCar({required this.other, required this.title, required this.update, required this.types, super.key});

  @override
  State<CardCar> createState() => _CardCarState();
}

class _CardCarState extends State<CardCar> {


  String currentValue="";
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap:(){
          if(widget.other.name.isNotEmpty){
            showBottomSheet(
          context: context,
           builder:(context)=>NameModal(types: widget.types,update:widget.update,id: widget.other.id,)
           );
          }
         
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: categorySelected,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              widget.title.isNotEmpty?widget.title:"Укажите ${typeWindow[widget.types]}",
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(87,87,88,1)
              ),
            ),
          ),
        ),
      ),
    );
  }
}