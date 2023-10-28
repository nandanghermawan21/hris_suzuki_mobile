import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/input_component.dart';
import 'package:suzuki/model/decoration_component.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/activasi_akun_view_model.dart';

class ActivasiAkunView extends StatefulWidget {
  final VoidCallback onActivasiSuccess;
  const ActivasiAkunView({
    Key? key,
    required this.onActivasiSuccess,
  }) : super(key: key);

  @override
  _PresenterState createState() => _PresenterState();
}

class _PresenterState extends State<ActivasiAkunView> {
  ActivasiAkunViewModel model = ActivasiAkunViewModel();

  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      cover: true,
      controller: model.circularLoaderController,
      child: Scaffold(
        appBar: DecorationComponent.appBar(
          context: context,
          title: "Aktivasi Akun",
          textColor: System.data.color!.primaryColor,
        ),
        body: body(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: submitButton(),
        ),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            nip(),
            const SizedBox(
              height: 15,
            ),
            nama(),
            const SizedBox(
              height: 15,
            ),
            tglLahir(),
            const SizedBox(
              height: 15,
            ),
            tglMulaiKerja(),
            const SizedBox(
              height: 15,
            ),
            password(),
          ],
        ),
      ),
    );
  }

  Widget nip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nomor Induk Pegawai",
          style: System.data.textStyles!.basicLabel,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.transparent,
          height: 50,
          child: InputComponent.inputText(
            controller: model.nipController,
            hint: "Nomor Induk Pegawai",
            obscureText: false,
          ),
        ),
      ],
    );
  }

  Widget nama() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nama Lengkap",
          style: System.data.textStyles!.basicLabel,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.transparent,
          height: 50,
          child: InputComponent.inputText(
            controller: model.namaController,
            hint: "Nama Lengkap",
            obscureText: false,
          ),
        ),
      ],
    );
  }

  Widget tglLahir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tanggal Lahir",
          style: System.data.textStyles!.basicLabel,
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate:
                        DateTime.now().add(const Duration(days: -1 * 365 * 30)),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now())
                .then((value) {
              model.tglLahir = value;
            });
          },
          child: SizedBox(
            height: 50,
            child: Stack(
              children: [
                InputComponent.inputText(
                  controller: model.tglLahirController,
                  hint: "Tanggal Lahir",
                  obscureText: false,
                  readOnly: true,
                ),
                Container(
                  color: Colors.white.withOpacity(0.1),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget tglMulaiKerja() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tanggal Mulai Kerja",
          style: System.data.textStyles!.basicLabel,
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now())
                .then((value) {
              model.tglMulaiKerja = value;
            });
          },
          child: SizedBox(
            height: 50,
            child: Stack(
              children: [
                InputComponent.inputText(
                  controller: model.tglMulaiKerjaController,
                  hint: "Tanggal Mulai Kerja",
                  obscureText: false,
                  readOnly: true,
                ),
                Container(
                  color: Colors.white.withOpacity(0.1),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Buat Kata Sandi",
          style: System.data.textStyles!.basicLabel,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.transparent,
          height: 50,
          child: InputComponent.inputText(
            controller: model.passwordController,
            hint: "Buat Kata Sandi",
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget submitButton() {
    return GestureDetector(
      onTap: () {
        model.submit(widget.onActivasiSuccess);
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
}
