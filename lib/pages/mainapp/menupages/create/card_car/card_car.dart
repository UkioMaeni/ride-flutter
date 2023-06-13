import 'package:ezride/helpers/color_constants.dart';
import 'package:ezride/http/cars/car_model.dart';
import 'package:ezride/pages/mainapp/menupages/create/enumMap/enumMap.dart';
import 'package:ezride/pages/mainapp/menupages/create/modal/name_modal.dart';
import 'package:flutter/material.dart';



class CardCar extends StatefulWidget{
  MyEnum types;
  Function update;
  String title;
   CarModel other;
  CardCar({required this.other, required this.title, required this.update, required this.types, super.key});

  @override
  State<CardCar> createState() => _CardCarState();
}

class _CardCarState extends State<CardCar> {


  String currentValue="";
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
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
              widget.title.isNotEmpty?widget.title:"Укажите ${TypeWindow[widget.types]}",
              style: TextStyle(
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