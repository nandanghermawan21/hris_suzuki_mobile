import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:suzuki/component/basic_component.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/list_data_component.dart';
import 'package:suzuki/model/attendace_model.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/model/kehadiran_model.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/absensi_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AbsensiView extends StatefulWidget {
  const AbsensiView({Key? key}) : super(key: key);

  @override
  _AbsensiViewState createState() => _AbsensiViewState();
}

class _AbsensiViewState extends State<AbsensiView>
    with TickerProviderStateMixin {
  AbsensiViewModel model = AbsensiViewModel();

  TabController? mainTabController;

  ListDataComponentController<KehadiranModel> kehadiranSayaController =
      ListDataComponentController<KehadiranModel>();
  ListDataComponentController<KehadiranModel> kehadiranPegawaiController =
      ListDataComponentController<KehadiranModel>();

  @override
  void initState() {
    super.initState();
    mainTabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: DecorationComponent.appBar(
          context: context,
          title: System.data.strings!.attendance,
          textColor: System.data.color!.primaryColor,
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          mainTab(),
          const SizedBox(
            height: 10,
          ),
          mainTabView(),
        ],
      ),
    );
  }

  Widget mainTab() {
    return Container(
      height: 50,
      color: Colors.white,
      child: TabBar(
        controller: mainTabController,
        labelStyle: System.data.textStyles!.headLine3,
        labelColor: Colors.black,
        indicatorColor: System.data.color!.primaryColor,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(
            text: "Kehadiran Saya",
          ),
          Tab(
            text: "Kehadiran Pegawai",
          ),
        ],
      ),
    );
  }

  Widget mainTabView() {
    return Expanded(
      child: TabBarView(
        controller: mainTabController,
        children: [
          kehadiran(),
          kehadiranPegawai(),
        ],
      ),
    );
  }

  Widget kehadiran() {
    return SizedBox(
      child: Column(
        children: [
          Consumer<AbsensiViewModel>(builder: (c, d, w) {
            return Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<int>(
                    value: model.bulanTerpilih,
                    items: <DropdownMenuItem<int>>[
                      ...List.generate(12, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(
                            DateFormat("MMMM", System.data.strings!.locale)
                                .format(DateTime(2021, index + 1)),
                            style: System.data.textStyles!.headLine3,
                          ),
                        );
                      })
                    ],
                    onChanged: (val) {
                      model.bulanTerpilih = val ?? 1;
                      kehadiranSayaController.refresh();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<int>(
                    value: model.tahunTerpilih,
                    items: <DropdownMenuItem<int>>[
                      ...List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: DateTime.now().year - index,
                          child: Text(
                            "${DateTime.now().year - index}",
                            style: System.data.textStyles!.headLine3,
                          ),
                        );
                      })
                    ],
                    onChanged: (val) {
                      model.tahunTerpilih = val ?? 2021;
                      kehadiranSayaController.refresh();
                    },
                  ),
                ],
              ),
            );
          }),
          Expanded(
            child: ListDataComponent<KehadiranModel>(
              controller: kehadiranSayaController,
              autoSearch: false,
              enableGetMore: false,
              enableDrag: false,
              dataSource: (skip, key) {
                return KehadiranModel.getKehadiranSaya(
                  token: System.data.global.token ?? "",
                  bulan: model.bulanTerpilih,
                  tahun: model.tahunTerpilih,
                );
              },
              itemBuilder: (data, index) {
                return kehadiranItem(data);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget kehadiranPegawai() {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Consumer<AbsensiViewModel>(
              builder: (c, d, w) {
                return GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900, 1, 1),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        model.tanggalKehadiranKaryawan = value;
                        model.commit();
                        kehadiranPegawaiController.refresh();
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        DateFormat("dd MMMM yyyy", System.data.strings!.locale)
                            .format(model.tanggalKehadiranKaryawan),
                        style: System.data.textStyles!.headLine1,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListDataComponent<KehadiranModel>(
              controller: kehadiranPegawaiController,
              autoSearch: false,
              enableGetMore: false,
              enableDrag: false,
              dataSource: (skip, key) {
                return KehadiranModel.getKehadiranPegawai(
                  token: System.data.global.token ?? "",
                  tanggal: model.tanggalKehadiranKaryawan,
                );
              },
              itemBuilder: (data, index) {
                return kehadiranItem(data, isMine: false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget kehadiranItem(KehadiranModel? data, {bool isMine = true}) {
    return GestureDetector(
      onTap: () {
        showModalApprovalKehadiran(
          data?.pegawaiId ?? 0,
          data?.tanggal ?? DateTime.now(),
          isMine: isMine,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
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
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 90,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isMine
                              ? Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    data?.tanggal == null
                                        ? "-"
                                        : DateFormat("dd")
                                            .format(data!.tanggal!),
                                    textAlign: TextAlign.center,
                                    style: System
                                        .data.textStyles!.boldTitleLabel
                                        .copyWith(
                                            fontSize: 40, color: Colors.white),
                                  ),
                                )
                              : BasicComponent.avatar(
                                  size: 50,
                                  url: data?.fotoPegawai ?? "",
                                  onTap: () {},
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            !isMine
                                ? data?.namaPegawai ?? "-"
                                : data?.tanggal == null
                                    ? "-"
                                    : DateFormat(
                                            "MMMM", System.data.strings!.locale)
                                        .format(data!.tanggal!),
                            textAlign: TextAlign.center,
                            style: System.data.textStyles!.boldTitleLabel
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    data?.rejected == null
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(left: 10),
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(color: Colors.red)),
                              child: const Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Icon(
                                  FontAwesomeIcons.exclamationTriangle,
                                  size: 13,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status Kehadiran",
                                    style: System.data.textStyles!.headLine3,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data?.namaStatusKehadiran ?? '-',
                                    style: System.data.textStyles!.headLine2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kode Kehadiran",
                                    style: System.data.textStyles!.headLine3,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data?.kodeStatusKehadiran ?? '-',
                                    style: System.data.textStyles!.headLine2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jam Masuk",
                                    style: System.data.textStyles!.headLine3,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data?.jamMasuk == null
                                        ? "-"
                                        : DateFormat("HH:mm")
                                            .format(data!.jamMasuk!.toLocal()),
                                    style: System.data.textStyles!.headLine2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jam Keluar",
                                    style: System.data.textStyles!.headLine3,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data?.jamKeluar == null
                                        ? "-"
                                        : DateFormat("HH:mm")
                                            .format(data!.jamKeluar!.toLocal()),
                                    style: System.data.textStyles!.headLine2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showModalApprovalKehadiran(int idPegawai, DateTime tanggal,
      {bool isMine = true}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: model,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Consumer<AbsensiViewModel>(builder: (c, d, w) {
              return Container(
                height: double.infinity,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: IntrinsicHeight(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: FutureBuilder<List<AttendaceModel>?>(
                            future: KehadiranModel.getApprovalKehadiran(
                              token: System.data.global.token ?? "",
                              idPegawai: idPegawai,
                              tanggal: tanggal,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return approvalKehadiranItem(
                                        snapshot.data![index],
                                        isMine: isMine,
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text(
                                      "Tidak ada data \n ${snapshot.error}",
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget approvalKehadiranItem(AttendaceModel? data, {bool isMine = true}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                                child: SvgPicture.asset(
                                  data?.codeAttendance == 'MCI'
                                      ? 'assets/check_in.svg'
                                      : 'assets/check_out.svg',
                                  color: data?.codeAttendance == 'MCI'
                                      ? const Color.fromARGB(255, 7, 62, 9)
                                      : const Color.fromARGB(255, 87, 23, 19),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                data?.codeAttendance == 'MCI'
                                    ? "Masuk"
                                    : "Keluar",
                                style:
                                    System.data.textStyles!.headLine3.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                data?.createdDate == null
                                    ? "-"
                                    : DateFormat("hh:mm",
                                            System.data.strings!.locale)
                                        .format(data!.createdDate!),
                                style:
                                    System.data.textStyles!.headLine1.copyWith(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          child: Text(
                            data?.approvalStatus == 0 ? "Ditolak" : "Valid",
                            style: System.data.textStyles!.headLine3.copyWith(
                              color: data?.approvalStatus == 0
                                  ? const Color.fromARGB(255, 164, 18, 5)
                                  : null,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data?.createdDate == null
                              ? "-"
                              : DateFormat("dd MMMM yyyy",
                                      System.data.strings!.locale)
                                  .format(data!.createdDate!),
                          style: System.data.textStyles!.headLine3,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url =
                                'https://www.google.com/maps/search/?api=1&query=${data?.lat},${data?.lon}';
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Tidak dapat membuka Google Maps';
                            }
                          },
                          child: Icon(
                            FontAwesomeIcons.mapMarked,
                            color: System.data.color!.primaryColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        data?.address ?? "-",
                        style: System.data.textStyles!.headLine2,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    data?.approvalStatus != null
                        ? Text(
                            data?.approvalReason ?? "-",
                            style: System.data.textStyles!.headLine2.copyWith(
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox(),
                    data?.approvalStatus != null
                        ? Text(
                            "${data?.approvedByName} @${data?.approvedDate != null ? DateFormat("hh:mm:ss", System.data.strings!.locale).format(data!.approvedDate!) : "-"}",
                            style: System.data.textStyles!.headLine2.copyWith(
                              color: Colors.red,
                            ),
                          )
                        : const SizedBox(),
                    isMine || data?.approvalStatus != null
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  showApprovalConfirm(data);
                                },
                                child: Text(
                                  'Tolak',
                                  style: System.data.textStyles!.headLine3
                                      .copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showApprovalConfirm(AttendaceModel? data) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: CircularLoaderComponent(
            controller: model.rejectKehadiranControler,
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Alasan Penolakan",
                                  style: System.data.textStyles!.headLine3,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: model.alasanController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "Masukkan alasan penolakan",
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    model.rejectKehadiran(
                                        context,
                                        data?.idAttendance ?? 0,
                                        model.alasanController.text);
                                  },
                                  child: Text(
                                    'Tolak',
                                    style: System.data.textStyles!.headLine3
                                        .copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        System.data.color!.primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Batal',
                                    style: System.data.textStyles!.headLine3
                                        .copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
