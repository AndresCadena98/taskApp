import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:task_app_nextline/core/card_widget.dart';
import 'package:task_app_nextline/screen/cubit/task_cubit.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../project_details/project_color.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({super.key});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController titulo = TextEditingController();
  int? check = 0;
  int? edit = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var cubit = context.read<TaskCubit>();
    dateInput.text = "";

    cubit.getTask();
  }

  int? id;
  String? title;
  int? iscompleted;
  String? duedate;
  String? comments;
  String? description;
  int value = 0;
  DateTime currentDate = DateTime.now();
  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  Widget rollingIconBuilder(int value, Size iconSize, bool foreground) {
    IconData data = Icons.check;
    if (value.isEven) data = Icons.cancel;
    return Icon(
      data,
      size: iconSize.shortestSide,
    );
  }

  showAlertDialog(
    BuildContext context,
  ) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      title: Text(title!),
      content: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.blue[200],
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Comentarios: ${id!}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blue[200],
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Cereado: ${duedate!}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blue[200],
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Cereado: ${comments!}',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )),
              ),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ProjectColorsUtitilty().backgroundPage,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle().copyWith(
              statusBarColor: const Color.fromARGB(255, 255, 255, 255),
              statusBarBrightness: Brightness.dark,
            ),
            backgroundColor: ProjectColorsUtitilty().backgroundPage,
            elevation: 0.0,
            title: Text(PageString().appBarTitle,
                style: style().styel1, maxLines: 1),
            actions: [
              IconButton(
                  onPressed: () {
                    StylishDialog dialog = StylishDialog(
                        context: context,
                        alertType: StylishDialogType.NORMAL,
                        cancelButton: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        confirmButton: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            var cubit = context.read<TaskCubit>();
                            cubit
                                .addTask(titulo.text, check, dateInput.text)
                                .then((value) {
                              StylishDialog dialog = StylishDialog(
                                context: context,
                                alertType: StylishDialogType.SUCCESS,
                                title: Text(
                                  value,
                                  style: GoogleFonts.workSans(
                                    color: ProjectColorsUtitilty().appBarText2,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                dismissOnTouchOutside: true,
                              );
                              dialog.dismiss();
                              cubit.getTask();
                            });
                          },
                        ),
                        content: Column(
                          children: [
                            TextFormField(
                                controller: titulo,
                                decoration: InputDecoration(
                                  labelText: "Título",
                                  border: myinputborder(),
                                  enabledBorder: myinputborder(),
                                  focusedBorder: myfocusborder(),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                labelText: "Seleccionar fecha",
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ToggleSwitch(
                              minWidth: 150.0,
                              initialLabelIndex: 1,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              labels: ['Incompleta', 'Completada'],
                              icons: [Icons.close, Icons.check],
                              activeBgColors: [
                                [Colors.red],
                                [Colors.green]
                              ],
                              onToggle: (index) {
                                setState(() {
                                  check = index;
                                });
                              },
                            ),
                            TextFormField()
                          ],
                        ));
                    dialog.show();
                  },
                  icon: const Icon(
                    CupertinoIcons.add,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      'Tareas Principales',
                      style: GoogleFonts.workSans(
                        color: ProjectColorsUtitilty().appBarText2,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Andrés Alanis Cadena',
                          style: GoogleFonts.workSans(
                            color: ProjectColorsUtitilty().appBarText1,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                      itemCount: state.tasks?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            var cubit = context.read<TaskCubit>();
                            setState(() {});
                            int? idTask = state.tasks![index].id;
                            cubit.getTaskById(idTask).then((value) {
                              title = state.task![0].title ?? '';
                              id = state.task![0].id ?? 0;
                              comments = state.task![0].comments ?? '';
                              duedate = state.task![0].duedate ?? '';

                              showAlertDialog(
                                context,
                              );
                            });
                          },
                          child: CardWidget(
                              onEdit: () {
                    StylishDialog dialog = StylishDialog(
                        context: context,
                        alertType: StylishDialogType.NORMAL,
                        cancelButton: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        confirmButton: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            var cubit = context.read<TaskCubit>();
                            cubit
                                .editTask(state.tasks![index].id!,titulo.text, check, dateInput.text)
                                .then((value) {
                              StylishDialog dialog = StylishDialog(
                                context: context,
                                alertType: StylishDialogType.SUCCESS,
                                title: Text(
                                  value,
                                  style: GoogleFonts.workSans(
                                    color: ProjectColorsUtitilty().appBarText2,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                dismissOnTouchOutside: true,
                              );
                              dialog.dismiss();
                              cubit.getTask();
                            });
                          },
                        ),
                        content: Column(
                          children: [
                            TextFormField(
                                controller: titulo,
                                decoration: InputDecoration(
                                  labelText: "Título",
                                  border: myinputborder(),
                                  enabledBorder: myinputborder(),
                                  focusedBorder: myfocusborder(),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                labelText: "Seleccionar fecha",
                                border: myinputborder(),
                                enabledBorder: myinputborder(),
                                focusedBorder: myfocusborder(),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateInput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ToggleSwitch(
                              minWidth: 150.0,
                              initialLabelIndex: 1,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              labels: ['Incompleta', 'Completada'],
                              icons: [Icons.close, Icons.check],
                              activeBgColors: [
                                [Colors.red],
                                [Colors.green]
                              ],
                              onToggle: (index) {
                                setState(() {
                                  check = index;
                                });
                              },
                            ),
                            TextFormField()
                          ],
                        ));
                    dialog.show();
                  },
                              onPressed: () {
                                var cubit = context.read<TaskCubit>();
                                cubit
                                    .deleteTaskById(state.tasks![index].id)
                                    .then((value) {
                                  var cubit = context.read<TaskCubit>();
                                  StylishDialog dialog = StylishDialog(
                                    context: context,
                                    alertType: StylishDialogType.SUCCESS,
                                    title: Text(
                                      value,
                                      style: GoogleFonts.workSans(
                                        color:
                                            ProjectColorsUtitilty().appBarText2,
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    dismissOnTouchOutside: true,
                                  );
                                  dialog.show();
                                  cubit.getTask();
                                });
                              },
                              icon: state.tasks?[index].iscompleted == 1
                                  ? Icons.check
                                  : Icons.close,
                              iconcolor: state.tasks?[index].iscompleted == 1
                                  ? Colors.blue
                                  : Colors.red,
                              taskTitle: state.tasks?[index].title ?? '',
                              taskSubtitle: state.tasks?[index].iscompleted == 1
                                  ? 'Completado'
                                  : 'Incompleto',
                              date: state.tasks?[index].duedate ?? ''),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PageString {
  final String appBarTitle = "TaskApp";
}

class style {
  final TextStyle styel1 = GoogleFonts.workSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: ProjectColorsUtitilty().appBarText2,
  );
}

class ProjectButtons {
  SizedBox topIcons(String text) {
    return SizedBox(
      width: 91,
      height: 27,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: BorderSide(width: 1, color: ProjectColorsUtitilty().iconColor),
        ),
        onPressed: () {},
        child: Text(text,
            style: GoogleFonts.poppins(
              color: ProjectColorsUtitilty().iconColor,
              fontSize: 9,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
      ),
    );
  }
}
