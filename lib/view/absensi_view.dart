import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suzuki/component/list_data_component.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/model/kehadiran_model.dart';
import 'package:suzuki/util/system.dart';

class AbsensiView extends StatefulWidget {
  const AbsensiView({Key? key}) : super(key: key);

  @override
  _AbsensiViewState createState() => _AbsensiViewState();
}

class _AbsensiViewState extends State<AbsensiView>
    with TickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: DecorationComponent.appBar(
        context: context,
        title: System.data.strings!.attendance,
        textColor: System.data.color!.primaryColor,
      ),
      body: body(),
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
      child: ListDataComponent<KehadiranModel>(
        controller: kehadiranSayaController,
        autoSearch: false,
        enableGetMore: false,
        enableDrag: false,
        dataSource: (skip, key) {
          return Future.value(KehadiranModel.dunnyKehadiranSaya());
        },
        itemBuilder: (data, index) {
          return kehadiranItem(data);
        },
      ),
    );
  }

  Widget kehadiranPegawai() {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat("dd MMMM yyyy", System.data.strings!.locale)
                      .format(DateTime.now()),
                  style: System.data.textStyles!.headLine1,)
              ],
            ),
          ),
          Expanded(
            child: ListDataComponent<KehadiranModel>(
              controller: kehadiranPegawaiController,
              autoSearch: false,
              enableGetMore: false,
              enableDrag: false,
              dataSource: (skip, key) {
                return Future.value(KehadiranModel.dunnyKehadiranPegawai());
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
    return Container(
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
                                : DateFormat("dd").format(data!.tanggal!),
                            textAlign: TextAlign.center,
                            style: System.data.textStyles!.boldTitleLabel
                                .copyWith(fontSize: 40, color: Colors.white),
                          ),
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          foregroundImage:
                              NetworkImage(data?.fotoPegawai ?? ""),
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    !isMine
                        ? data?.namaPegawai ?? "-"
                        : data?.tanggal == null
                            ? "-"
                            : DateFormat("MMMM", System.data.strings!.locale)
                                .format(data!.tanggal!),
                    textAlign: TextAlign.center,
                    style: System.data.textStyles!.boldTitleLabel
                        .copyWith(fontSize: 20),
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
                                  "${data?.namaStatusKehadiran}",
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
                                  "${data?.kodeStatusKehadiran}",
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
                                          .format(data!.jamMasuk!),
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
                                          .format(data!.jamKeluar!),
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
    );
  }
}
