import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/util/data.dart';
import 'package:suzuki/util/system.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key})
      : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() {
    return ProfileViewState();
  }
}

class ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  TabController? tabController;

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
        title: System.data.strings!.profile,
        textColor: System.data.color!.primaryColor,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar(),
          accountInfo(),
          const SizedBox(
            height: 20,
          ),
          TabBar(
            controller: tabController,
            indicatorColor: System.data.color!.primaryColor,
            labelColor: System.data.color!.primaryColor,
            unselectedLabelColor: System.data.color!.greyColor,
            labelStyle: System.data.textStyles!.boldTitleLightLabel.copyWith(
              color: System.data.color!.darkTextColor,
            ),
            unselectedLabelStyle:
                System.data.textStyles!.boldTitleLightLabel.copyWith(
              color: System.data.color!.darkTextColor,
            ),
            tabs: const [
              Tab(
                text: "Company Data",
              ),
              Tab(
                text: "Personal Data",
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                companyData(),
                companyData(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget avatar() {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: () {
          // widget.onTapProfile!();
        },
        child: Consumer<Data>(
          builder: (c, d, w) {
            return CircleAvatar(
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
            );
          },
        ),
      ),
    );
  }

  Widget accountInfo() {
    return IntrinsicHeight(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: FittedBox(
                child: Text(
                  System.data.global.user?.nama ??
                      System.data.strings!.employeName,
                  style: System.data.textStyles!.headLine1.copyWith(
                    color: System.data.color!.darkTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
              child: FittedBox(
                child: Text(
                  System.data.global.user?.email ?? "email@employe.com",
                  style: System.data.textStyles!.headLine1.copyWith(
                    fontWeight: FontWeight.normal,
                    color: System.data.color!.darkTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget companyData() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            detail(
              title: "Divisi Area",
              value: System.data.global.myProfile?.divisi,
            ),
            detail(
              title: "Depo Cabang/ Sub Cabang",
              value: System.data.global.myProfile?.cabang,
            ),
            detail(
              title: "Jabatan",
              value: System.data.global.myProfile?.namaJabatan,
            ),
            detail(
              title: "Level Name",
              value: System.data.global.myProfile?.level,
            ),
            detail(
              title: "Employe type",
              value: System.data.global.myProfile?.statusKerja,
            ),
            detail(
              title: "Home Base",
              value: System.data.global.myProfile?.homebase,
            ),
            detail(
              title: "Start Date",
              value: System.data.global.myProfile?.startDate != null
                  ? DateFormat("dd MMMM yyyy")
                      .format(System.data.global.myProfile!.startDate!)
                  : "",
            ),
            detail(
              title: "Masa Kerja",
              value: System.data.global.myProfile?.masaKerja,
            ),
            detail(
              title: "Sign Data",
              value: System.data.global.myProfile?.retirementDate != null
                  ? DateFormat("dd MMMM yyyy")
                      .format(System.data.global.myProfile!.retirementDate!)
                  : "",
            ),
            detail(
              title: "Terminate Data",
              value: System.data.global.myProfile?.terminateDate != null
                  ? DateFormat("dd MMMM yyyy")
                      .format(System.data.global.myProfile!.terminateDate!)
                  : "",
            ),
            detail(
              title: "Masa Pensiun",
              value: System.data.global.myProfile!.masaPensiun.toString(),
            ),
            detail(
              title: "Email Pribadi",
              value: System.data.global.myProfile!.emailPribadi,
            ),
            detail(
              title: "Emai Kantor",
              value: System.data.global.myProfile!.emailKantor,
            ),
          ],
        ),
      ),
    );
  }

  Widget personalData() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            detail(
              title: "Home Base",
              value: System.data.global.myProfile?.homebase,
            ),
            detail(
              title: "Tanggal Lahir",
              value: System.data.global.myProfile?.tanggalLahir != null
                  ? DateFormat("dd MMMM yyyy")
                      .format(System.data.global.myProfile!.tanggalLahir!)
                  : "",
            ),
            detail(
              title: "Usia",
              value: System.data.global.myProfile?.umur,
            ),
            detail(
              title: "Gender",
              value: System.data.global.myProfile?.jenisKelamin,
            ),
            detail(
              title: "Agama",
              value: System.data.global.myProfile?.agama,
            ),
            detail(
              title: "KTP",
              value: System.data.global.myProfile?.nikKtp,
            ),
            detail(
              title: "NPWP",
              value: System.data.global.myProfile!.npwp,
            ),
            detail(
              title: "PTKP",
              value: System.data.global.myProfile!.ptkp,
            ),
            detail(
              title: "Alamat KTP",
              value: System.data.global.myProfile!.alamatKtp,
            ),
            detail(
              title: "Alamat Domisili",
              value: System.data.global.myProfile!.alamatDomisili,
            ),
            detail(
              title: "Telephone / HP",
              value: System.data.global.myProfile!.telephoneHp,
            ),
            detail(
              title: "EmergencyCall",
              value: System.data.global.myProfile!.emergencyCall,
            ),
          ],
        ),
      ),
    );
  }

  Widget detail({
    String? title,
    String? value,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: System.data.color!.greyColor, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? "",
            style: System.data.textStyles!.headLine1.copyWith(
              fontWeight: FontWeight.normal,
              color: System.data.color!.darkTextColor,
            ),
          ),
          Text(
            value ?? "",
            style: System.data.textStyles!.headLine1.copyWith(
              fontWeight: FontWeight.w300,
              color: System.data.color!.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
