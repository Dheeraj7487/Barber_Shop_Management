import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class AddShopProvider extends ChangeNotifier{
  String? selectHairStyle,selectGender,selectState;
  File? barberFile,shopImage,coverShopImage;
  String coverShopImageName ='';
  String barberImageName ='';
  String shopImageName ='';
  String latitude="";
  String longitude="";
  TimeOfDay selectedOpeningTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay selectedClosingTime = const TimeOfDay(hour: 9, minute: 0);

  List<String> selectGenderList = ['Male','Female'];

  List<String> selectHairStyleList = ['Pixie Cut','Medium Length',
    'Crew Cut','Bun Cut','French Crop','Faux Hawk','Fringe','Buzz Cut','Man Bread'];

  List stateList = [
    {
      "Andhra Pradesh" :[
        {
          'District' : [
            "Anantapur", "Chittoor", "East Godavari", "Guntur", "Kadapa", "Krishna",
            "Kurnool", "Nellore", "Prakasam", "Srikakulam", "Visakhapatnam", "West Godavari"
          ]
        }
      ]
    },
    {
      'Hyderabad' :[
        {
          'District' : [
          "Musheerabad", "Malakpet", "Amberpet", "Khairatabad", "Jubilee Hills",
            "Sanathnagar", "Karwan", "Nampally", "Goshamahal", "Charminar", "Chandrayangutta",
            "Yakutpura", "Bahadurpura", "Secunderabad", "Secunderabad Cantt"
          ]
        }
      ],
    },
    {
      "Arunachal Pradesh" :[
        {
          'District' : [

          ]
        }
      ],
    },
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    'West Bengal'
  ];

  get getHairCategory {
    notifyListeners();
    return selectHairStyle;
  }

  get getGender {
    notifyListeners();
    return selectGender;
  }

  get getState {
    notifyListeners();
    return selectState;
  }

  //Compress Image File
  Future<File> imageSizeCompress(
      {required File image, quality = 40, percentage = 50}) async {
    var path = await FlutterNativeImage.compressImage(image.absolute.path,quality: 40,percentage: 50);
    return path;
  }

  //Pick Image File
  void selectBarberImage(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );
    if(result == null) return;
    final filePath = result.files.single.path;
    File compressImage = await imageSizeCompress(image: File(filePath!));
    barberFile = compressImage;
    barberImageName = result.files.first.name;
    notifyListeners();
  }

  void selectCoverShopImage(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );
    if(result == null) return;
    final filePath = result.files.single.path;
    File compressImage = await imageSizeCompress(image: File(filePath!));
    coverShopImage = compressImage;
    coverShopImageName = result.files.first.name;
    notifyListeners();
  }

  void selectShopImage(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );
    if(result == null) return;
    final filePath = result.files.single.path;
    File compressImage = await imageSizeCompress(image: File(filePath!));
    shopImage = compressImage;
    shopImageName = result.files.first.name;
    notifyListeners();
  }

}