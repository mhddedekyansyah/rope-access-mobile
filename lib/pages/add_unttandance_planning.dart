import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rope_access/widgets/custom_textformfield.dart';
import 'package:rope_access/widgets/custom_textformfield_address.dart';

class UntandancePlanning extends StatefulWidget {
  const UntandancePlanning({super.key});

  @override
  State<UntandancePlanning> createState() => _UntandancePlanningState();
}

class _UntandancePlanningState extends State<UntandancePlanning> {
  final TextEditingController _employeeID =
      TextEditingController(text: '62231148');
  final TextEditingController _employeeName =
      TextEditingController(text: 'Mhd Dedek Yansyah');
  final TextEditingController _reason = TextEditingController(text: '');
  final TextEditingController _startDate = TextEditingController(text: '');
  final TextEditingController _endDate = TextEditingController(text: '');

  String? type;
  int days = 0;
  final List<String> _list = [
    "Bencana Alam",
    "Home Trip",
    "Izin Dinas",
    "Izin Khusus",
    "Sakit",
    "Umroh"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Unattendance  Planning'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_card),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: _list,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Unattendance Type",
                    hintText: "choose unattendance type",
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomFormField(
                        label: 'Employee ID',
                        controller: _employeeID,
                        title: 'Employee ID'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                        label: 'Employee Name',
                        controller: _employeeID,
                        title: 'Employee Name'),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Start Date'),
              TextFormField(
                controller: _startDate, //editing controller of this TextField
                readOnly:
                    true, //set it true, so that user will not able to edit text.
                decoration:
                    const InputDecoration(enabledBorder: OutlineInputBorder()),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      _startDate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Text('Instance'),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Set Dinstance',
                            textAlign: TextAlign.center,
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(days.toString()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('End Date'),
              TextFormField(
                controller: _startDate, //editing controller of this TextField
                readOnly:
                    true, //set it true, so that user will not able to edit text.
                decoration:
                    const InputDecoration(enabledBorder: OutlineInputBorder()),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      _endDate.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
              CustomFormAddressField(
                  label: 'Reason',
                  controller: _reason,
                  assetIcon: '',
                  hintText: '',
                  maxLines: 3,
                  title: 'Reason')
            ],
          ),
        ),
      ),
    );
  }
}
