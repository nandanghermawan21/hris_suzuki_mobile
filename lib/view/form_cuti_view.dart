import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/model/jatah_cuti_model.dart';
import 'package:suzuki/model/tipe_cuti_model.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/form_cuti_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class FormCutiView extends StatefulWidget {
  const FormCutiView({Key? key}) : super(key: key);

  @override
  _FormCutiViewState createState() => _FormCutiViewState();
}

class _FormCutiViewState extends State<FormCutiView> {
  FormCutiViewModel model = FormCutiViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        appBar: DecorationComponent.appBar(
          context: context,
          title: System.data.strings!.formLeave,
          textColor: System.data.color!.primaryColor,
        ),
        body: body(),
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
                tanggalCuti(),
                const SizedBox(
                  height: 20,
                ),
                alasanCuti(),
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
                      System.data.global.myProfile?.namaJabatan ?? "",
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
                return DropdownButton<int>(
                  isExpanded: true,
                  underline: const SizedBox(),
                  value: model.tipeCutiId,
                  items: List.generate(TipeCutiModel.dummy().length, (index) {
                    return DropdownMenuItem<int>(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          TipeCutiModel.dummy()[index].nama ?? "",
                          style: System.data.textStyles!.headLine2,
                        ),
                      ),
                      value: TipeCutiModel.dummy()[index].id,
                    );
                  }),
                  onChanged: (value) {
                    var selected = TipeCutiModel.dummy().where((e) => e.id == value).first;
                    model.tipeCutiId = value;
                    if(model.tipeCuti.rangeMode == false && selected.rangeMode == true){
                      model.tanggalCuti.clear();
                      model.rangeStartDay = null;
                      model.rangeEndDay = null;
                    }
                    model.tipeCuti = selected;
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
                      height: 350,
                      color: Colors.transparent,
                      child: TableCalendar(
                        focusedDay: model.focusedDay ?? DateTime.now(),
                        availableGestures: AvailableGestures.all,
                        rangeSelectionMode: model.tipeCuti.rangeMode == true
                            ? RangeSelectionMode.toggledOn
                            : RangeSelectionMode.toggledOff,
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            return dayBuilder(day);
                          },
                          rangeStartBuilder: (context, day, focusedDay) => dayBuilder(day),
                        ),
                        onDaySelected: (day1, day2) {
                          if (model.tanggalCuti.contains(day1)) {
                            model.tanggalCuti.remove(day1);
                          } else {
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
                          model.commit();
                        },
                        firstDay: DateTime.now(),
                        lastDay: DateTime(
                            DateTime.now().year + 1, DateTime.june, 31),
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

  Widget submitButton() {
    return Container(
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
