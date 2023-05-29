import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:suzuki/model/menu_model.dart';
import 'package:suzuki/util/system.dart';

class HomeViewModel extends ChangeNotifier {
  List<MenuModel> get shorMenu {
    return <MenuModel>[
      MenuModel(
        title: System.data.strings!.checkInCheckOutAttendance,
        icon: Icons.punch_clock,
        iconBackgroundColor: Colors.purpleAccent,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.requestLeave,
        icon: Icons.leave_bags_at_home,
        iconBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
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
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.attendance,
        icon: Icons.alarm,
        iconBackgroundColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
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
        iconBackgroundColor:const Color.fromARGB(255, 19, 98, 21),
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.medical,
        icon: Icons.medical_information,
        iconBackgroundColor: Colors.pink,
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.loan,
        icon: Icons.money,
        iconBackgroundColor: const Color.fromARGB(255, 75, 93, 231),
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: "PFTK",
        icon: Icons.person_pin_outlined,
        iconBackgroundColor: const Color.fromARGB(255, 89, 8, 94),
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
      MenuModel(
        title: System.data.strings!.carrier,
        icon: Icons.line_axis,
        iconBackgroundColor:const  Color.fromARGB(255, 36, 159, 100),
        backgroundColor: Colors.white,
        iconColor: Colors.white,
        onTap: () {},
      ),
    ];
  }

  void commit() {
    notifyListeners();
  }
}
