import 'package:barber_booking_management/Category/screen/category_shop_details_screen.dart';
import 'package:barber_booking_management/utils/app_image.dart';
import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import 'model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  String gender = 'Male';
  List<ServiceListModel> maleHairCategoryList = <ServiceListModel>[
    ServiceListModel(serviceName: 'Medium Length',serviceGender: 'Male', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ww4SRRNCagE5ZjMPWJWrr4V7-ImWGxCfPeM2cNZa&s'),
    ServiceListModel(serviceName: 'Bun Cut',serviceGender: 'Male', serviceImage: 'https://i.pinimg.com/736x/4f/71/ef/4f71efa1052474d1baa10a0b67e1807b.jpg'),
    ServiceListModel(serviceName: 'French Crop',serviceGender: 'Male', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPrvidE1IlmMOC6qtprA_TAOgMJS-c0uA624blXZS4&s=0'),
    ServiceListModel(serviceName: 'Faux Hawk',serviceGender: 'Male', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo3-VDvJ31Yf9aKoQ8jg3HF0lUr5LuXSiDmrLyp65-DQ&s'),
    ServiceListModel(serviceName: 'Fringe',serviceGender: 'Male', serviceImage: 'https://i.pinimg.com/originals/7a/c4/69/7ac469fee5cec00acc70a2e42c663335.jpg'),
    ServiceListModel(serviceName: 'Buzz Cut',serviceGender: 'Male', serviceImage: 'https://i.pinimg.com/736x/65/f0/9c/65f09c0e4b8839c3e0d6e86db6c486c0.jpg'),
    ServiceListModel(serviceName: 'Man Bread',serviceGender: 'Male', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw-KDlkwu4CKXfdkkNemwCY7IpX8PIGpVKkJMeEUk&s'),
    ServiceListModel(serviceName: 'Pixie Cut',serviceGender: 'Male', serviceImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRT7EbeWQWa0kOrLzUgwWzNQTQwf0pA1SN1Vs6xhqC&s'),
    ServiceListModel(serviceName: 'Crew Cut',serviceGender: 'Male', serviceImage: 'https://www.menshairstyletrends.com/wp-content/uploads/2019/11/joshconnollybarberModern-crew-cut-hairstyle.jpg'),
  ];

  List<ServiceListModel> femaleHairCategoryList = <ServiceListModel>[
    ServiceListModel(serviceName: 'Medium Length',serviceGender: 'Female', serviceImage: 'https://i2.wp.com/www.hadviser.com/wp-content/uploads/2019/03/4-medium-length-straight-hair-with-layers-CKjceXbMRWr.jpg?resize=869%2C1047&ssl=1'),
    ServiceListModel(serviceName: 'Bun Cut',serviceGender: 'Female', serviceImage: 'https://i.pinimg.com/736x/42/46/51/424651f1ec884cc2c7b74083074169fc.jpg'),
    ServiceListModel(serviceName: 'French Crop',serviceGender: 'Female', serviceImage: 'https://i1.wp.com/therighthairstyles.com/wp-content/uploads/2022/09/2-feminine-blonde-short-haircut-with-skin-fade.jpg?resize=500%2C574&ssl=1'),
    ServiceListModel(serviceName: 'Faux Hawk',serviceGender: 'Female', serviceImage: 'https://www.prettydesigns.com/wp-content/uploads/2017/01/Female-faux-hawk-women.jpg'),
    ServiceListModel(serviceName: 'Fringe',serviceGender: 'Female', serviceImage: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/alexis-bledel-haircut-with-bangs-1532374583.jpg?crop=0.781xw:0.973xh;0.104xw,0&resize=480:*'),
    ServiceListModel(serviceName: 'Buzz Cut',serviceGender: 'Female', serviceImage: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/iris-law-buzzcut-1626340815.jpg?crop=0.830xw:0.803xh;0.0744xw,0&resize=480:*'),
    ServiceListModel(serviceName: 'Female Bread',serviceGender: 'Female', serviceImage: 'https://stylesatlife.com/wp-content/uploads/2018/03/French-Braided-Hairstyle-598569950.jpg.webp'),
    ServiceListModel(serviceName: 'Pixie Cut',serviceGender: 'Female', serviceImage: 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/pixiecut-1608666762.png?crop=0.502xw:1.00xh;0.498xw,0&resize=640:*'),
    ServiceListModel(serviceName: 'Crew Cut',serviceGender: 'Female', serviceImage: 'https://www.byrdie.com/thmb/Fnj3lSu78I1KKfz17tVVe4rXSD0=/735x0/GettyImages-1158754969-03ad9e0365c247b4ba1bdf968de0950b.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('Gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(value: 'Male', groupValue: gender, onChanged: (index) {
                          setState((){
                            gender = index.toString();
                          });
                        }),
                        const Text('Male')
                      ],
                    ),
                    Row(
                      children: [
                        Radio(value: "Female", groupValue: gender, onChanged: (index) {
                          setState((){
                            gender = index.toString();
                          });
                        }),
                        const Text('Female')
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListView.builder(
                    itemCount: gender == 'Male' ? maleHairCategoryList.length : femaleHairCategoryList.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryShopDetailScreen(hairCategory: maleHairCategoryList[index].serviceName,gender: gender,)));
                        },
                        // child: Container(
                        //   margin: const EdgeInsets.only(right: 10,top: 10),
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10)
                        //   ),
                        //   child:  Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       ClipRRect(
                        //         child: Image.network(
                        //           gender == 'Male' ? maleHairCategoryList[index].serviceImage : femaleHairCategoryList[index].serviceImage,
                        //           height: 90,width: 80,fit: BoxFit.fill,),
                        //       ),
                        //       Expanded(
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(left: 10),
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children:  [
                        //               Text(
                        //                   gender == 'Male' ? maleHairCategoryList[index].serviceName : femaleHairCategoryList[index].serviceName,
                        //                   style : const TextStyle(color: AppColor.appColor),maxLines: 2,overflow: TextOverflow.ellipsis),
                        //               const SizedBox(height: 2),
                        //               Text(
                        //                   gender == 'Male' ? maleHairCategoryList[index].serviceGender : femaleHairCategoryList[index].serviceGender,
                        //                   style : const TextStyle(color: AppColor.aquaColor2,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis),
                        //               const SizedBox(height: 4),
                        //               // const Text('30 Shop',
                        //               //     style : TextStyle(color: AppColor.blackColor,fontSize: 10),overflow: TextOverflow.ellipsis),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),

                        child: Container(
                          height: 150,
                          margin: const EdgeInsets.only(right: 10,top: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.summerColor4.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30,top: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(
                                          gender == 'Male' ? maleHairCategoryList[index].serviceName : femaleHairCategoryList[index].serviceName,
                                          style : const TextStyle(color: AppColor.appColor),maxLines: 2,overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 2),
                                      Text(
                                          gender == 'Male' ? maleHairCategoryList[index].serviceGender : femaleHairCategoryList[index].serviceGender,
                                          style : const TextStyle(color: AppColor.aquaColor2,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 4),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: AppColor.appColor,
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: const Center(child: Text('View Shop',style : TextStyle(color: AppColor.whiteColor))),
                                      )
                                      // const Text('30 Shop',
                                      //     style : TextStyle(color: AppColor.blackColor,fontSize: 10),overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              ClipRRect(
                                child: Image.asset(
                                  AppImage.butCut,
                                  height: double.infinity,width: 100,fit: BoxFit.fill,),
                              ),
                            ],
                          ),
                        ),

                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
