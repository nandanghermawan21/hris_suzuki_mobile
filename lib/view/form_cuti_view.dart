import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/image_picker_component.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/model/jatah_cuti_model.dart';
import 'package:suzuki/model/category_attendace_model.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/form_cuti_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class FormCutiView extends StatefulWidget {
  final VoidCallback onSubmitSucess;

  const FormCutiView({
    Key? key,
    required this.onSubmitSucess,
  }) : super(key: key);

  @override
  _FormCutiViewState createState() => _FormCutiViewState();
}

class _FormCutiViewState extends State<FormCutiView> {
  FormCutiViewModel model = FormCutiViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: CircularLoaderComponent(
        controller: model.loadingController,
        child: Scaffold(
          appBar: DecorationComponent.appBar(
            context: context,
            title: System.data.strings!.formLeave,
            textColor: System.data.color!.primaryColor,
          ),
          body: body(),
        ),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          jatahCuti(),
          Divider(
            color: System.data.color!.primaryColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                namaPegawai(),
                const SizedBox(
                  height: 20,
                ),
                tipeCuti(),
                const SizedBox(
                  height: 20,
                ),
                namaCuti(),
                const SizedBox(
                  height: 20,
                ),
                tanggalCuti(),
                const SizedBox(
                  height: 20,
                ),
                alasanCuti(),
                const SizedBox(
                  height: 20,
                ),
                attachment(),
                const SizedBox(
                  height: 20,
                ),
                submitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget jatahCuti() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            children: List.generate(
              JatahCutiModel.dummy().length,
              (index) {
                return jatahCutiItem(JatahCutiModel.dummy()[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget jatahCutiItem(JatahCutiModel data) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: data.warnaCuti,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                "${data.sisaCuti}",
                style: System.data.textStyles!.boldTitleLightLabel.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${data.namaTipeCuti}",
            style: System.data.textStyles!.boldTitleLabel,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            data.tangalKadalaursa == null
                ? ""
                : DateFormat("dd MMM yyyy", System.data.strings!.locale)
                    .format(data.tangalKadalaursa!),
            style: System.data.textStyles!.basicLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget namaPegawai() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      System.data.strings!.employeName,
                      style: System.data.textStyles!.headLine3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      System.data.global.myProfile?.namaPegawai ?? "",
                      style: System.data.textStyles!.headLine2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      System.data.strings!.position,
                      style: System.data.textStyles!.headLine3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      System.data.global.myProfile?.namaJabatan ?? "",
                      style: System.data.textStyles!.headLine2,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget tipeCuti() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.leaveType,
            style: System.data.textStyles!.headLine3,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Consumer<FormCutiViewModel>(
              builder: (c, d, w) {
                return DropdownButton<String>(
                  isExpanded: true,
                  underline: const SizedBox(),
                  value: model.leaveType,
                  items: [
                    DropdownMenuItem<String>(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Izin",
                            style: System.data.textStyles!.headLine2,
                          ),
                        ),
                        value: "izin"),
                    DropdownMenuItem<String>(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Cuti",
                            style: System.data.textStyles!.headLine2,
                          ),
                        ),
                        value: "cuti"),
                  ],
                  onChanged: (value) {
                    model.leaveType = value;
                    model.tanggalCuti.clear();
                    model.leaveTypeController.add(value!);
                    model.commit();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget namaCuti() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.category,
            style: System.data.textStyles!.headLine3,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: StreamBuilder(
              stream: model.leaveTypeController.stream,
              initialData: null,
              builder: (sc, ss) {
                return FutureBuilder<List<CategoryAttendanceModel>>(
                  future: model.leaveType == 'izin'
                      ? CategoryAttendanceModel.getIzinTersedia(
                          token: System.data.global.token ?? "",
                        ).then((value) {
                          debugPrint("total data ${value.length}");
                          return value;
                          // ignore: body_might_complete_normally_catch_error
                        }).catchError((onError) {
                          debugPrint("error $onError");
                        })
                      : Future.value().then((value) => []),
                  builder: (c, s) {
                    if (s.connectionState == ConnectionState.waiting) {
                      return SkeletonAnimation(
                        shimmerColor: Colors.grey.shade300,
                        gradientColor: Colors.grey.shade100,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: StreamBuilder(
                            stream: model
                                .selectedCategoryAttendanceController.stream,
                            builder: (d, w) {
                              return DropdownButton<int>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                value: model.leaveId,
                                items: List.generate(
                                  s.data?.length ?? 0,
                                  (index) {
                                    return DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          s.data?[index].attendance ?? "",
                                          style:
                                              System.data.textStyles!.headLine2,
                                        ),
                                      ),
                                      value: s.data?[index].idAttendance,
                                    );
                                  },
                                ),
                                onChanged: (val) {
                                  model.leaveId = val;
                                  model.selectedCategoryAttendance = s.data
                                          ?.firstWhere((element) =>
                                              element.idAttendance == val) ??
                                      CategoryAttendanceModel();
                                  model.selectedCategoryAttendanceController
                                      .add(model.selectedCategoryAttendance);
                                  model.tanggalCuti.clear();
                                  model.commit();
                                },
                              );
                            }),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget tanggalCuti() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.leaveDate,
            style: System.data.textStyles!.headLine3,
          ),
          const SizedBox(
            height: 5,
          ),
          IntrinsicHeight(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Consumer<FormCutiViewModel>(builder: (c, d, w) {
                debugPrint(
                    'picker mode ${model.selectedCategoryAttendance.pickerDateMode}');
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      color: Colors.grey.shade200,
                      child: Wrap(
                        children: List.generate(
                          model.tanggalCuti.length,
                          (index) {
                            return IntrinsicWidth(
                              child: GestureDetector(
                                onTap: () {
                                  model.focusedDay = model.tanggalCuti[index];
                                  model.commit();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: System.data.color!.primaryColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  margin: const EdgeInsets.only(
                                      right: 5, bottom: 5),
                                  child: Text(
                                    DateFormat("dd/MM/yyyy",
                                            System.data.strings!.locale)
                                        .format(
                                      model.tanggalCuti[index],
                                    ),
                                    style: System.data.textStyles!.headLine2
                                        .copyWith(
                                      color: System.data.color!.lightTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 400,
                      color: Colors.transparent,
                      child: TableCalendar(
                        focusedDay: model.focusedDay ?? DateTime.now(),
                        availableGestures: AvailableGestures.all,
                        rangeSelectionMode:
                            model.selectedCategoryAttendance.pickerDateMode ==
                                    'RANGE'
                                ? RangeSelectionMode.toggledOn
                                : RangeSelectionMode.toggledOff,
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            return dayBuilder(day);
                          },
                          rangeStartBuilder: (context, day, focusedDay) =>
                              dayBuilder(day),
                        ),
                        onDaySelected: (day1, day2) {
                          if (model.tanggalCuti.contains(day1)) {
                            model.tanggalCuti.remove(day1);
                          } else {
                            if (model.selectedCategoryAttendance.count !=
                                    null &&
                                model.tanggalCuti.length + 1 >
                                    model.selectedCategoryAttendance.count!) {
                              model.loadingController.stopLoading(
                                isError: true,
                                message:
                                    "Jumlah maksinal hari yang dapat diambil adalah ${model.selectedCategoryAttendance.count} hari",
                              );
                              return;
                            }
                            if (!model.validateTanggalPengajuan(day1)) {
                              return;
                            }
                            model.tanggalCuti.add(day1);
                          }
                          model.focusedDay = day1;
                          model.commit();
                        },
                        onRangeSelected: (day1, day2, day3) {
                          model.tanggalCuti.clear();
                          if (day2 == null) {
                            model.tanggalCuti.add(day1!);
                            model.rangeStartDay = day1;
                            model.rangeEndDay = day1;
                            model.focusedDay = day1;
                          } else {
                            for (var i = 0;
                                i <= day2.difference(day1!).inDays;
                                i++) {
                              model.tanggalCuti
                                  .add(day1.add(Duration(days: i)));
                            }
                            model.rangeStartDay = day1;
                            model.rangeEndDay = day2;
                            model.focusedDay = day2;
                          }
                          if (!model.validateTanggal()) {
                            model.tanggalCuti.clear();
                          }
                          model.commit();
                        },
                        firstDay: DateTime.now()
                            .add(const Duration(days: (365 * -10))),
                        lastDay:
                            (model.selectedCategoryAttendance.canNextDate ??
                                    true)
                                ? DateTime(
                                    DateTime.now().year + 1, DateTime.june, 31)
                                : DateTime.now(),
                        rangeStartDay: model.rangeEndDay,
                        rangeEndDay: model.rangeEndDay,
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget alasanCuti() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.leaveReason,
            style: System.data.textStyles!.headLine3,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: TextField(
              controller: model.alasanCuti,
              maxLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget attachment() {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            System.data.strings!.leaveReason,
            style: System.data.textStyles!.headLine3,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: ImagePickerComponent(
              controller: model.attachmentController,
              galery: false,
            ),
          )
        ],
      ),
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () {
        model.submitIzin(onSuccess: widget.onSubmitSucess);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: System.data.color!.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            System.data.strings!.submit,
            style: System.data.textStyles!.headLine2.copyWith(
              color: System.data.color!.lightTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget dayBuilder(DateTime day) {
    return Container(
      margin: const EdgeInsets.all(3),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: model.tanggalCuti.contains(day)
              ? System.data.color!.primaryColor
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: Center(
        child: Text(day.day.toString(),
            style: System.data.textStyles!.headLine3.copyWith(
              color: model.tanggalCuti.contains(day)
                  ? System.data.color!.lightTextColor
                  : null,
            )),
      ),
    );
  }
}
