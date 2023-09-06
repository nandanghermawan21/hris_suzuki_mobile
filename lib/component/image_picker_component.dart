import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:suzuki/component/botton_component.dart';
import 'package:suzuki/component/camera_component.dart';
import 'package:suzuki/util/mode_util.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/util/type_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suzuki/util/string_extentions.dart';

class ImagePickerComponent extends StatelessWidget {
  final ImagePickerController? controller;
  final bool? camera;
  final bool? galery;
  final WidgetFromDataBuilder2<WidgetBuilder, ImagePickerValue>? container;
  final WidgetFromDataBuilder<ImagePickerValue>? placeHolderContainer;
  final WidgetFromDataBuilder<ImagePickerValue>? imageContainer;
  final WidgetFromDataBuilder<VoidCallback>? buttonCamera;
  final WidgetFromDataBuilder<VoidCallback>? buttonGalery;
  final WidgetFromDataBuilder2<VoidCallback, VoidCallback>? popUpChild;
  final Alignment? popUpAlign;
  final BoxDecoration? popUpDecoration;
  final EdgeInsets? popUpMargin;
  final EdgeInsets? popUpPadding;
  final double? popUpHeight;
  final double? popUpWidth;
  final ValueChanged<ImagePickerController?>? onTap;
  final bool? readOnly;
  final double? containerHeight;
  final double? containerWidth;
  final int? imageQuality;

  const ImagePickerComponent({
    Key? key,
    this.controller,
    this.camera = true,
    this.galery = true,
    this.container,
    this.placeHolderContainer,
    this.imageContainer,
    this.buttonCamera,
    this.buttonGalery,
    this.popUpChild,
    this.popUpAlign,
    this.popUpDecoration,
    this.popUpMargin,
    this.popUpPadding,
    this.popUpHeight,
    this.popUpWidth,
    this.onTap,
    this.readOnly = false,
    this.containerHeight,
    this.containerWidth,
    this.imageQuality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ImagePickerValue>(
      valueListenable: controller!,
      builder: (context, value, child) {
        controller!.value.context = context;
        return GestureDetector(
          onTap: readOnly == false
              ? onTap != null
                  ? () {
                      onTap!(controller);
                    }
                  : () {
                      if (value.state != ImagePickerComponentState.Disable) {
                        if (camera == true && galery == true) {
                          openModal(context);
                        } else if (camera == true) {
                          controller!.getImages(
                              camera: true, imageQuality: imageQuality);
                        } else if (galery == true) {
                          controller!.getImages(
                              camera: false, imageQuality: imageQuality);
                        }
                      }
                    }
              : () {},
          child: container != null
              ? container!((context) {
                  return widgetBuilder(value);
                }, value)
              : Container(
                  height: containerHeight ?? 100,
                  width: containerWidth ?? 100,
                  child: Center(
                    child: widgetBuilder(value),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: stateColor(value.state),
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
        );
      },
    );
  }

  void openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 1,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.red.withOpacity(0),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop("modal");
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.0),
            child: Align(
              alignment: popUpAlign ?? Alignment.bottomCenter,
              child: Container(
                height: popUpHeight ?? 170,
                width: popUpWidth ?? double.infinity,
                margin: popUpAlign == Alignment.center
                    ? const EdgeInsets.only(left: 10, right: 20)
                    : null,
                padding: popUpPadding ?? const EdgeInsets.all(20),
                decoration: popUpDecoration ??
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: popUpAlign == Alignment.center
                            ? const Radius.circular(20)
                            : Radius.zero,
                        bottomRight: popUpAlign == Alignment.center
                            ? const Radius.circular(20)
                            : Radius.zero,
                      ),
                    ),
                child: popUpChild != null
                    ? popUpChild!(() {
                        openCamera(context);
                      }, () {
                        openGalery(context);
                      })
                    : Column(
                        children: <Widget>[
                          Text(
                            System.data.strings!.selectPhoto,
                            style: System.data.textStyles!.basicLabel,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buttonCamera != null
                              ? buttonGalery!(() {
                                  openGalery(context);
                                })
                              : SizedBox(
                                  height: 35,
                                  width: 200,
                                  child: BottonComponent.roundedButton(
                                    onPressed: () {
                                      openCamera(context);
                                    },
                                    colorBackground:
                                        System.data.color!.primaryColor,
                                    text: System.data.strings!.camera,
                                    textstyle:
                                        System.data.textStyles!.basicLabel,
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          buttonGalery != null
                              ? buttonGalery!(() {
                                  openGalery(context);
                                })
                              : SizedBox(
                                  height: 35,
                                  width: 200,
                                  child: BottonComponent.roundedButton(
                                    onPressed: () {
                                      openGalery(context);
                                    },
                                    colorBackground:
                                        System.data.color!.primaryColor,
                                    text: System.data.strings!.galery,
                                    textstyle:
                                        System.data.textStyles!.basicLabel,
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openGalery(BuildContext context) {
    Navigator.of(context).pop();
    controller!.getImages(camera: false, imageQuality: imageQuality);
  }

  void openCamera(BuildContext context) {
    Navigator.of(context).pop();
    controller!.getImages(camera: true, imageQuality: imageQuality);
  }

  static Color stateColor(ImagePickerComponentState state) {
    return state == ImagePickerComponentState.Disable
        ? System.data.color!.disableColor
        : state == ImagePickerComponentState.Error
            ? System.data.color!.errorColor
            : System.data.color!.primaryColor;
  }

  Widget widgetBuilder(ImagePickerValue value) {
    return value.loadData
        ? immageWidget(value)
        : placeHolderContainer != null
            ? placeHolderContainer!(value)
            : placeHolder();
  }

  Widget immageWidget(ImagePickerValue value) {
    return imageContainer != null
        ? imageContainer!(value)
        : Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                  value.valueUri!.contentAsBytes(),
                ),
              ),
            ),
          );
  }

  Widget placeHolder() {
    return placeHolderContainer as Widget? ??
        const Icon(
          Icons.camera_alt,
          color: Colors.grey,
          size: 50,
        );
  }
}

class ImagePickerController extends ValueNotifier<ImagePickerValue> {
  ImagePickerController({ImagePickerValue? value})
      : super(value ?? ImagePickerValue());

  String? getExtension(String string) {
    List<String> getList = string.split(".");
    String data = getList.last.replaceAll("'", "");
    String? result;
    if (data == "png") {
      result = "data:image/png;base64,";
    } else if (data == "jpeg") {
      result = "data:image/jpeg;base64,";
    } else if (data == "jpg") {
      result = "data:image/jpg;base64,";
    } else if (data == "gif") {
      result = "data:image/gif;base64,";
    }
    return result;
  }

  /// The `imageQuality` argument modifies the quality of the image, ranging from 0-100
  /// where 100 is the original/max quality. If `imageQuality` is null, the image with
  /// the original quality will be returned. Compression is only supportted for certain
  /// image types such as JPEG. If compression is not supported for the image that is picked,
  /// an warning message will be logged.
  void getImages(
      {bool camera = true,
      int? imageQuality = 30,
      ValueChanged<ImagePickerController>? onPickedImage}) async {
    try {
      dynamic picker;
      if (camera) {
        picker = await openDeviceCamera(
          System.data.navigatorKey.currentState!.context,
        );
      } else {
        picker = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: imageQuality);
      }

      File image = File(picker.path);

      String _valueBase64Compress = "";
      value.fileImage = image;
      value.base64 = getExtension(image.toString())! +
          base64.encode(image.readAsBytesSync());
      notifyListeners();

      FlutterImageCompress.compressWithFile(
        image.absolute.path,
        quality: value.quality,
      ).then((a) {
        _valueBase64Compress =
            getExtension(image.toString())! + base64.encode(a!);
        value.base64Compress = _valueBase64Compress;
        value.loadData = true;
        value.valueUri = Uri.parse(_valueBase64Compress).data;
        getBase64();
        notifyListeners();
        if (onPickedImage != null) onPickedImage(this);
      }).catchError((e) {
        value.error = e;
        notifyListeners();
      });
    } catch (e) {
      ModeUtil.debugPrint("error on get picture $e");
    }
  }

  String? getBase64() {
    return value.base64;
  }

  String? getBase64Compress() {
    return value.base64Compress;
  }

  File? getFile() {
    return value.fileImage;
  }

  void clear() {
    value.fileImage = null;
    value.base64 = null;
    value.base64Compress = null;
    value.valueUri = null;
    value.loadData = false;
    notifyListeners();
  }

  List<Object?> getAll() {
    List<Object?> list = [value.base64, value.base64Compress, value.fileImage];
    return list;
  }

  String getFileName() {
    List<String> getList = value.fileImage.toString().split("-");
    String data = getList.last.replaceAll("'", "");
    return data == "null" ? "" : data;
  }

  set state(ImagePickerComponentState state) {
    value.state = state;
    notifyListeners();
  }

  void disposes() {
    value.loadData = false;
    value.valueUri = null;
    value.base64Compress = null;
    value.base64 = null;
    value.fileImage = null;
    value.error = null;
    notifyListeners();
  }

  bool validate() {
    bool _isValid = getBase64()!.isNullOrEmpty() ? false : true;
    if (_isValid) {
      value.state = ImagePickerComponentState.Enable;
      commit();
    } else {
      value.state = ImagePickerComponentState.Error;
      commit();
    }
    return _isValid;
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  static Future<PickedFile?> openDeviceCamera(
    BuildContext context, {
    CameraDescription? cameraDescription,
  }) {
    return showDialog<PickedFile>(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          color: Colors.transparent,
          height: double.infinity,
          width: double.infinity,
          child: CameraComponent(
            controller: CameraComponentController(),
            onConfirmImage: (image) {
              Navigator.of(ctx).pop(PickedFile(image!.path));
            },
          ),
        );
      },
    ).then(
      (value) {
        return value;
      },
    );
  }

  void commit() {
    notifyListeners();
  }
}

class ImagePickerValue {
  bool loadData;
  String? base64Compress;
  String? base64;
  UriData? valueUri;
  File? fileImage;
  int quality;
  String? error;
  ImagePickerComponentState state;

  BuildContext? context;

  ImagePickerValue({
    this.loadData = false,
    this.base64Compress,
    this.base64,
    this.quality = 25,
    this.valueUri,
    this.error,
    this.state = ImagePickerComponentState.Enable,
    this.context,
  });
}

enum ImagePickerComponentState {
  // ignore: constant_identifier_names
  Enable,
  // ignore: constant_identifier_names
  Disable,
  // ignore: constant_identifier_names
  Error,
}
