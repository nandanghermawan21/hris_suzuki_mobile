import 'dart:convert';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:suzuki/component/list_data_component.dart';
import 'package:suzuki/model/leave_model.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/model/jatah_cuti_model.dart';
import 'package:suzuki/util/system.dart';

class CutiView extends StatefulWidget {
  final VoidCallback onTapBuatCuti;

  const CutiView({Key? key, required this.onTapBuatCuti}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CutiViewState();
  }
}

class CutiViewState extends State<CutiView> with TickerProviderStateMixin {
  TabController? tabController;
  ListDataComponentController<LeaveModel> cutiSayaController =
      ListDataComponentController<LeaveModel>();
  ListDataComponentController<LeaveModel> butuhPersetujuanController =
      ListDataComponentController<LeaveModel>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DecorationComponent.appBar(
        context: context,
        title: System.data.strings!.leave,
        textColor: System.data.color!.primaryColor,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      child: Column(
        children: [
          jatahCuti(),
          const SizedBox(
            height: 10,
          ),
          TabBar(
            controller: tabController,
            labelStyle: System.data.textStyles!.headLine3,
            labelColor: Colors.black,
            indicatorColor: System.data.color!.primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: System.data.strings!.myLeave,
              ),
              Tab(
                text: System.data.strings!.needApproval,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Stack(
                  children: [
                    cutiSaya(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: FloatingActionButton(
                          backgroundColor: System.data.color!.primaryColor,
                          onPressed: () {
                            widget.onTapBuatCuti();
                          },
                          child: const Icon(Icons.add),
                        ),
                      ),
                    )
                  ],
                ),
                butuhPersetujuan(),
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

  Widget cutiSaya() {
    return Container(
      color: Colors.transparent,
      child: ListDataComponent<LeaveModel>(
        controller: cutiSayaController,
        enableDrag: false,
        enableGetMore: true,
        autoSearch: false,
        dataSource: (skip, key) {
          return LeaveModel.getMyLeave(
            token: System.data.global.token ?? "",
            skip: skip,
          );
        },
        itemBuilder: (item, index) {
          return itemCuti(item);
        },
      ),
    );
  }

  Widget butuhPersetujuan() {
    return Container(
      color: Colors.transparent,
      child: ListDataComponent<LeaveModel>(
        controller: butuhPersetujuanController,
        enableDrag: false,
        enableGetMore: true,
        autoSearch: false,
        dataSource: (skip, key) {
          return LeaveModel.getBawahanLeave(
            token: System.data.global.token ?? "",
            skip: skip,
          );
        },
        itemBuilder: (item, index) {
          return itemCuti(item, asApprover: true);
        },
      ),
    );
  }

  Widget itemCuti(LeaveModel? data, {bool? asApprover}) {
    return GestureDetector(
      onTap: () {
        detailCuti(data, asApprover);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
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
        width: double.infinity,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 5, top: 5),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data?.tglPengajuan == null
                          ? ""
                          : DateFormat("dd MM yyyy HH:mm",
                                  System.data.strings!.locale)
                              .format(data!.tglPengajuan!),
                      style: System.data.textStyles!.headLine3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: data?.color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.only(
                          bottom: 5, top: 5, right: 10, left: 10),
                      child: Text(
                        data?.status ?? "",
                        style: System.data.textStyles!.headLine3.copyWith(
                            color: System.data.color!.lightTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 3,
                thickness: 2,
              ),
              Container(
                color: Colors.transparent,
                width: double.infinity,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.all(10),
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: data?.color,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "${data?.jumlahLeave ?? ""}",
                                  style: System
                                      .data.textStyles!.boldTitleLightLabel
                                      .copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              data?.attendance ?? "",
                              style: System.data.textStyles!.headLine3,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.transparent,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nama Pegawai",
                                            style: System
                                                .data.textStyles!.headLine3,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data?.namaPegawai ?? "",
                                            style: System
                                                .data.textStyles!.headLine2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Alasan",
                                            style: System
                                                .data.textStyles!.headLine3,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data?.reason ?? "",
                                            style: System
                                                .data.textStyles!.headLine2,
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
                              Text(
                                "Tanggal",
                                style: System.data.textStyles!.headLine3,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Wrap(
                                  children: List.generate(
                                      data?.tanggalLeave?.length ?? 0, (index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          right: 5, bottom: 5),
                                      padding: const EdgeInsets.only(
                                          top: 3, bottom: 3, left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        data?.tanggalLeave?[index] == null
                                            ? ""
                                            : DateFormat("dd/MM/yy",
                                                    System.data.strings!.locale)
                                                .format(data!
                                                    .tanggalLeave![index]!),
                                        style:
                                            System.data.textStyles!.headLine2,
                                      ),
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void detailCuti(
    LeaveModel? data,
    bool? asApprover,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (constext) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        avatar(),
                        Text(
                          data?.namaPegawai ?? "",
                          style: System.data.textStyles!.headLine1,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tanggal",
                                              style: System
                                                  .data.textStyles!.headLine3,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data?.tglPengajuan == null
                                                  ? ""
                                                  : DateFormat(
                                                          "dd MMM yyyy",
                                                          System.data.strings!
                                                              .locale)
                                                      .format(
                                                          data!.tglPengajuan!),
                                              style: System
                                                  .data.textStyles!.headLine2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Status",
                                              style: System
                                                  .data.textStyles!.headLine3,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data?.status ?? "",
                                              style: System
                                                  .data.textStyles!.headLine2
                                                  .copyWith(
                                                      // color: data?.warnaStatusCuti,
                                                      ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Alasan",
                                              style: System
                                                  .data.textStyles!.headLine3,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data?.reason ?? "",
                                              style: System
                                                  .data.textStyles!.headLine2,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tanggal",
                                              style: System
                                                  .data.textStyles!.headLine3,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Wrap(
                                              children: List.generate(
                                                  data?.tanggalLeave?.length ??
                                                      0, (index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5, bottom: 5),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3,
                                                          bottom: 3,
                                                          left: 5,
                                                          right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    data?.tanggalLeave?[
                                                                index] ==
                                                            null
                                                        ? ""
                                                        : DateFormat(
                                                                "dd/MM/yy",
                                                                System
                                                                    .data
                                                                    .strings!
                                                                    .locale)
                                                            .format(data!
                                                                    .tanggalLeave![
                                                                index]!),
                                                    style: System.data
                                                        .textStyles!.headLine2,
                                                  ),
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                data?.attachment == null || data?.attachment == "" ? const SizedBox() : GestureDetector(
                                  onTap: (){
                                     showImageViewer(
                                        context,
                                        MemoryImage(
                                          base64Decode(data?.attachment?.split(',').last ?? ""),
                                        ),
                                        immersive: false,
                                        useSafeArea: true,
                                        onViewerDismissed: () {},
                                      );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    color: Colors.grey.shade300,
                                    child: Image.memory(
                                      base64Decode(data?.attachment?.split(',').last ?? ""),
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Text("Gambar tidak valid"),
                                        );
                                      },
                                    ),
                                  ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Persetujuan",
                                              style: System
                                                  .data.textStyles!.headLine3,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data?.levelAtasan ??
                                                                    "",
                                                                style: System
                                                                    .data
                                                                    .textStyles!
                                                                    .headLine3,
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                data?.namaAtasan ??
                                                                    "",
                                                                style: System
                                                                    .data
                                                                    .textStyles!
                                                                    .headLine2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data?.aprrovedDate ==
                                                                        null
                                                                    ? ""
                                                                    : DateFormat(
                                                                            "dd MMM yyyy",
                                                                            System
                                                                                .data.strings!.locale)
                                                                        .format(
                                                                            data!.aprrovedDate!),
                                                                style: System
                                                                    .data
                                                                    .textStyles!
                                                                    .headLine3,
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                data?.status ??
                                                                    "",
                                                                style: System
                                                                    .data
                                                                    .textStyles!
                                                                    .headLine2
                                                                    .copyWith(
                                                                        // color: data
                                                                        //     ?.persetujuanAtasan[
                                                                        //         index]
                                                                        //     .warnaPersetujuanStatus,
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  width: double.infinity,
                                  child: asApprover == true
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .all<Color>(System
                                                              .data
                                                              .color!
                                                              .dangerColor),
                                                ),
                                                child: Text(
                                                  "Tolak",
                                                  style: System.data.textStyles!
                                                      .boldTitleLightLabel,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .all<Color>(System
                                                              .data
                                                              .color!
                                                              .primaryColor),
                                                ),
                                                child: Text(
                                                  "Setuji",
                                                  style: System.data.textStyles!
                                                      .boldTitleLightLabel,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(System.data
                                                        .color!.dangerColor),
                                          ),
                                          child: Text(
                                            "Batalkan",
                                            style: System.data.textStyles!
                                                .boldTitleLightLabel,
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget avatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: SizedBox(
        height: 60,
        child: GestureDetector(
          onTap: () {
            // widget.onTapProfile!();
          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            foregroundImage: System.data.global.myProfile?.filePhoto != null
                ? NetworkImage(
                    System.data.global.myProfile?.filePhoto ?? "",
                  )
                : null,
            child: Icon(
              Icons.person,
              color: System.data.color!.primaryColor,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
