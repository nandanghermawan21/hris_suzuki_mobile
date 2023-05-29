import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
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
                              Column(
                                children: [
                                  avatar(),
                                  accountInfo(),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  margin: const EdgeInsets.all(15),
                                  child: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
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
                    viewModel.mainMenu.length,
                    (index) {
                      return Container(
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
                                backgroundColor: viewModel
                                    .mainMenu[index].iconBackgroundColor,
                                child: Icon(
                                  viewModel.mainMenu[index].icon,
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
                                  viewModel.mainMenu[index].title ?? "",
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
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget avatar() {
    return SizedBox(
      height: 120,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 40,
        child: Icon(
          Icons.person,
          color: System.data.color!.primaryColor,
          size: 40,
        ),
      ),
    );
  }

  Widget accountInfo() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
              child: FittedBox(
                child: Text(
                  "William Smith",
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
                child: Text(
                  "Human Resources",
                  style: System.data.textStyles!.headLine1.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
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
                children: List.generate(viewModel.shorMenu.length, (index) {
                  return Container(
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
                                viewModel.shorMenu[index].iconBackgroundColor,
                            child: Icon(
                              viewModel.shorMenu[index].icon,
                              color: viewModel.shorMenu[index].iconColor,
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
                              viewModel.shorMenu[index].title ?? "",
                              style: System.data.textStyles!.basicLabel,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
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
}
