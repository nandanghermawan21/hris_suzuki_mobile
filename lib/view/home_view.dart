import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/menu_model.dart';
import 'package:suzuki/util/data.dart';
import 'package:suzuki/util/sized_util.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  final VoidCallback? onTapSetting;
  final VoidCallback? onTapProfile;
  final VoidCallback? onTapLeave;
  final VoidCallback? onTapCreateLeave;
  final VoidCallback? onTapAttendance;

  const HomeView({
    Key? key,
    this.onTapSetting,
    this.onTapProfile,
    this.onTapLeave,
    this.onTapCreateLeave,
    this.onTapAttendance,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getMyprofile();
  }

  List<MenuModel> shorMenu(BuildContext context) {
    return <MenuModel>[
      MenuModel(
        title: System.data.strings!.checkInCheckOutAttendance,
        icon: Icons.punch_clock,
        iconBackgroundColor: Colors.purpleAccent,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {
          popupCheckInCheckOut(context);
        },
      ),
      MenuModel(
        title: System.data.strings!.requestLeave,
        icon: Icons.leave_bags_at_home,
        iconBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {
          widget.onTapCreateLeave!();
        },
      ),
      MenuModel(
        title: System.data.strings!.requestLemurs,
        icon: Icons.lock_clock,
        iconBackgroundColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
    ];
  }

  List<MenuModel> get mainMenu {
    return <MenuModel>[
      MenuModel(
        title: System.data.strings!.leave,
        icon: Icons.time_to_leave,
        iconBackgroundColor: Colors.purple,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {
          widget.onTapLeave!();
        },
      ),
      MenuModel(
        title: System.data.strings!.attendance,
        icon: Icons.alarm,
        iconBackgroundColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {
          widget.onTapAttendance!();
        },
      ),
      MenuModel(
        title: System.data.strings!.lemurs,
        icon: Icons.lock_clock,
        iconBackgroundColor: Colors.orange,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.salary,
        icon: Icons.file_present_sharp,
        iconBackgroundColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.employee,
        icon: Icons.people,
        iconBackgroundColor: const Color.fromARGB(255, 19, 98, 21),
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      // MenuModel(
      //   title: System.data.strings!.medical,
      //   icon: Icons.medical_information,
      //   iconBackgroundColor: Colors.pink,
      //   backgroundColor: Colors.white,
      //   iconColor: Colors.white,
      //   onTap: () {},
      // ),
      MenuModel(
        title: System.data.strings!.loan,
        icon: Icons.money,
        iconBackgroundColor: const Color.fromARGB(255, 75, 93, 231),
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      // MenuModel(
      //   title: "PFTK",
      //   icon: Icons.person_pin_outlined,
      //   iconBackgroundColor: const Color.fromARGB(255, 89, 8, 94),
      //   backgroundColor: Colors.white,
      //   iconColor: Colors.white,
      //   onTap: () {},
      // ),
      // MenuModel(
      //   title: System.data.strings!.carrier,
      //   icon: Icons.line_axis,
      //   iconBackgroundColor: const Color.fromARGB(255, 36, 159, 100),
      //   backgroundColor: Colors.white,
      //   iconColor: Colors.white,
      //   onTap: () {},
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: CircularLoaderComponent(
        controller: viewModel.circularLoaderController,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 350,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: System.data.color!.primaryColor,
                          child: SafeArea(
                            bottom: false,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      avatar(),
                                      accountInfo(),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    margin: const EdgeInsets.all(15),
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.onTapSetting!();
                                      },
                                      child: const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      shortMenu(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: Wrap(
                    children: List.generate(
                      mainMenu.length,
                      (index) {
                        return GestureDetector(
                          onTap: (){
                            mainMenu[index].onTap!();
                          },
                          child: Container(
                            width: 90,
                            height: 100,
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        mainMenu[index].iconBackgroundColor,
                                    child: Icon(
                                      mainMenu[index].icon,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      mainMenu[index].title ?? "",
                                      style: System.data.textStyles!.basicLabel
                                          .copyWith(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget avatar() {
    return SizedBox(
      height: 120,
      child: GestureDetector(
        onTap: () {
          widget.onTapProfile!();
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
    return Expanded(
      child: Container(
        color: Colors.transparent,
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
                  style: System.data.textStyles!.headLine1,
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
                child: Consumer<Data>(
                  builder: (c, d, w) {
                    return Text(
                      System.data.global.myProfile?.namaJabatan ?? "",
                      style: System.data.textStyles!.headLine1.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shortMenu() {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: System.data.color!.primaryColor,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(shorMenu(context).length, (index) {
                  return GestureDetector(
                    onTap: () {
                      shorMenu(context)[index].onTap!();
                    },
                    child: Container(
                      height: 90,
                      width: 80,
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            color: Colors.white,
                            child: CircleAvatar(
                              backgroundColor:
                                  shorMenu(context)[index].iconBackgroundColor,
                              child: Icon(
                                shorMenu(context)[index].icon,
                                color: shorMenu(context)[index].iconColor,
                                size: 40,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                shorMenu(context)[index].title ?? "",
                                style: System.data.textStyles!.basicLabel,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  void popupCheckInCheckOut(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return SizedBox(
          height: SizedUtil.minMaxHegihtPercent(context, 25, 300, 400),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 150,
                    child: Image.asset("assets/attendance_ilustration.jpeg"),
                  ),
                ),
                Text(
                  "Are you sure for check in/out now?",
                  style: System.data.textStyles!.basicLabel.copyWith(
                    color: System.data.color!.darkTextColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: System.data.color!.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          viewModel.checkIn();
                        },
                        child: Text(
                          "Chek In",
                          style: System.data.textStyles!.headLine1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: System.data.color!.dangerColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          viewModel.checkOut();
                        },
                        child: Text(
                          "Chek Out",
                          style: System.data.textStyles!.headLine1,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
