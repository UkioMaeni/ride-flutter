import 'package:ezride/helpers/color_constants.dart';
import 'package:ezride/pages/mainapp/menupages/search/UI/person_count/modal_person_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonCount extends StatefulWidget{
  const PersonCount({super.key});
  @override
  State<PersonCount> createState() => _PersonCountState();
}

class _PersonCountState extends State<PersonCount> {

int count=1;
void _increment(){
  if(count<4){
    setState(() {
    count++;
  });
  }
}

void setCount(int newCount){
  setState(() {
    count=newCount;
  });
}

void _decrement(){
   if(count>1){
    setState(() {
    count--;
  });
  }
}


 void _showDialogPage(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
        return ModalPersonCount(count:count,increment:_increment,decrement:_decrement,setter:setCount);
      },
      );
      
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){
            _showDialogPage(context);
        },
        child: Container(
           height: 60,
            decoration: BoxDecoration(
              color:categorySelected,
              borderRadius: BorderRadius.circular(10),
          
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19,right: 12),
                child: SvgPicture.asset(
                  "assets/svg/person.svg"
                ),
              ),
              Text(count.toString())
            ]
            ),
        ),
      ),
    );
  }
}