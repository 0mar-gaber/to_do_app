import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/editText.dart';

import '../shared/screens_provider.dart';

class AddTaskSheet extends StatefulWidget {

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDetailsController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();


  AddTaskSheet({super.key,required this.taskTitleController,required this.taskDetailsController,required this.formKey});





  @override
  _AddTaskSheetState createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {





  @override
  void initState() {
    ScreenProvider provider = Provider.of<ScreenProvider>(context,listen: false);

    super.initState();
    provider.selectedTime = TimeOfDay.now();
  }

  void _selectTime(BuildContext context) async {
    ScreenProvider provider = Provider.of<ScreenProvider>(context,listen: false);

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: provider.selectedTime,
    );

    if (pickedTime != null && pickedTime != provider.selectedTime) {

      provider.changeTime(pickedTime);

      // setState(() {
      //   widget.selectedTime = pickedTime;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenProvider provider = Provider.of<ScreenProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.38,
      width: width,
      decoration:  BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.08),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Text("Add New Task", style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * 0.04,color: Theme.of(context).colorScheme.onSurface,)),
              SizedBox(height: height * 0.02),
              EditText(
                validate: (value) {
                  if(value!.isEmpty){
                    return "add task title" ;
                  }
                },
                lapel: "Enter your task title",
                obscureText: false,
                keyboardType: TextInputType.text,
                formKay: widget.formKey,
                controller: widget.taskTitleController,
              ),
              SizedBox(height: height * 0.02),
              EditText(
                lapel: "Enter your task details",
                obscureText: false,
                keyboardType: TextInputType.text,
                formKay: widget.formKey,
                controller:widget.taskDetailsController,
              ),
              SizedBox(height: height * 0.04),
              InkWell(
                onTap: () => _selectTime(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Time:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * 0.04,color: Theme.of(context).colorScheme.onSurface,)),
                    Text(
                      provider.selectedTime.format(context),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * 0.04,color: Theme.of(context).colorScheme.onSurface,),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

