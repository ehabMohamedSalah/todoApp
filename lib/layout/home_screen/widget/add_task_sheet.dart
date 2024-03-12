import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/layout/home_screen/provider/home_provider.dart';
import 'package:todoapp/shared/resuable_component/custom_form_field.dart';

class AddTaskSheet extends StatefulWidget {
  void Function() onCancel;
  TextEditingController titleController;
  TextEditingController descController;
  GlobalKey<FormState> formKey;


  AddTaskSheet({required this.onCancel,required this.formKey,required this.titleController,required this.descController});
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {



  @override
  Widget build(BuildContext context) {
    HomeProvider provider= Provider.of<HomeProvider>(context);
    return  Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Form(
          key:widget.formKey ,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add New Task',style: Theme.of(context).textTheme.labelMedium,),
                SizedBox(height: 20,),
                CustomFormField(
                    label: 'Enter task title',
                    keyboard: TextInputType.text,
                    controller: widget.titleController,
                  validator: (value){
                      if(value==null||value.isEmpty){
                        return"title cant be empty";
                      }
                      return null;


                  },
                ),
                SizedBox(height: 10,),

                CustomFormField(
                  maxlines: 5,
                  label: 'Enter task desc',
                  keyboard: TextInputType.multiline, //da zorar fe al keyboard eny anzl line gded
                  controller: widget.descController,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return"Description cant be empty";
                    }
                    return null;


                  },
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () async {
                   DateTime ? selectedDate= await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      initialDate: DateTime.now(), //da al selectedDate

                    );
                   provider.selectedNewDate(selectedDate  );
                    setState(() {

                    });
                    print(selectedDate?.day);
                  },
                  child: Text
                    (provider.selectedDate==null?'Selected time':"${provider.selectedDate?.day} / ${provider.selectedDate?.month} / ${provider.selectedDate?.year}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                  )),
                ),
                SizedBox(height: 10,),
                ElevatedButton
                  (onPressed:()
                  {
                  Navigator.pop(context);
                 widget.onCancel();
                    },
                    child: Text(
                  'cancel'
                ))




              ],
            ),
          ),
        ),
      ),
    );
  }
}
