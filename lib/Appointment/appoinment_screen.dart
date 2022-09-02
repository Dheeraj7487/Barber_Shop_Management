import 'package:barber_booking_management/Appointment/screen/service_category_shop_screen.dart';
import 'package:flutter/material.dart';

import '../Appointment/model/appointment_model.dart';
import '../utils/app_color.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {


  String gender = 'male';
  List<ServiceListModel> serviceList = <ServiceListModel>[
    ServiceListModel(serviceName: 'Pixie Cut', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY2HXh1YyV1zp4WbvS_7Iwet4m1iAoFgGTrhwyFrQ&s'),
    ServiceListModel(serviceName: 'Medium Length', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ww4SRRNCagE5ZjMPWJWrr4V7-ImWGxCfPeM2cNZa&s'),
    ServiceListModel(serviceName: 'Crew Cut', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvAR4b5LXRZg9Aq_HDuHMVBr7vJjrscm50FzpPqkNp&s'),
     ServiceListModel(serviceName: 'Bun Cut', serviceImage: 'https://i.pinimg.com/736x/4f/71/ef/4f71efa1052474d1baa10a0b67e1807b.jpg'),
     ServiceListModel(serviceName: 'French Crop', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPrvidE1IlmMOC6qtprA_TAOgMJS-c0uA624blXZS4&s=0'),
     ServiceListModel(serviceName: 'Faux Hawk', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3-VDvJ31Yf9aKoQ8jg3HF0lUr5LuXSiDmrLyp65-DQ&s'),
     ServiceListModel(serviceName: 'Fringe', serviceImage: 'https://i.pinimg.com/originals/7a/c4/69/7ac469fee5cec00acc70a2e42c663335.jpg'),
     ServiceListModel(serviceName: 'Buzz Cut', serviceImage: 'https://i.pinimg.com/736x/65/f0/9c/65f09c0e4b8839c3e0d6e86db6c486c0.jpg'),
     ServiceListModel(serviceName: 'Man Bread', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw-KDlkwu4CKXfdkkNemwCY7IpX8PIGpVKkJMeEUk&s'),
     // ServiceListModel(serviceName: 'Bun', serviceImage: serviceImage),
     // ServiceListModel(serviceName: 'Bun', serviceImage: serviceImage),
     // ServiceListModel(serviceName: 'Bun', serviceImage: serviceImage),
     // ServiceListModel(serviceName: 'Bun', serviceImage: serviceImage),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(child: Text('Appointment',style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500))),
              const SizedBox(height: 20),
              const Text('Gender',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(value: 'male', groupValue: gender, onChanged: (index) {
                        setState((){
                          gender = index.toString();
                          print('male');
                        });
                      }),
                      const Text('Male')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: "female", groupValue: gender, onChanged: (index) {
                        setState((){
                          gender = index.toString();
                          print('female');
                        });
                      }),
                      const Text('Female')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: "other", groupValue: gender, onChanged: (index) {
                        setState((){
                          gender = index.toString();
                          print('other');
                        });
                      }),
                      const Text('Other')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Choose Your Services',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  Text('Total - ${serviceList.length}',style:  const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                  itemCount: serviceList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ServiceCategoryScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10,top: 15),
                        decoration: BoxDecoration(
                            //border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: Image.network(serviceList[index].serviceImage,
                                height: 100,width: 90,fit: BoxFit.fill,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(serviceList[index].serviceName,
                                      style : const TextStyle(color: AppColor.appColor,fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis),
                                  const Text('30 Place',
                                      style : TextStyle(color: AppColor.blackColor,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis),

                                  // DropdownButtonHideUnderline(
                                  //   child: DropdownButton(
                                  //     value: selectType,
                                  //     hint: const Text('Select Country'),
                                  //     isExpanded: true,
                                  //     isDense: true,
                                  //     style: const TextStyle(color: AppColor.blackColor, fontSize: 14),
                                  //     icon: const Icon(Icons.arrow_drop_down),
                                  //     onChanged: (String? newValue) {
                                  //       selectType = newValue!;
                                  //       //snapshot.getCountry;
                                  //     },
                                  //     items: selectTypeList
                                  //         .map<DropdownMenuItem<String>>((String leaveName) {
                                  //       return DropdownMenuItem<String>(
                                  //           value: leaveName,
                                  //           child: Row(
                                  //             children: [
                                  //               Text(leaveName)
                                  //             ],
                                  //           )
                                  //       );
                                  //     }).toList(),
                                  //   ),
                                  // )

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
