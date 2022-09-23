import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Firebase/firebase_collection.dart';
import '../Home/screen/shop_details_screen.dart';
import '../utils/app_color.dart';
import 'model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  String gender = 'Male';
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
                StreamBuilder(
                    stream: FirebaseCollection().shopCollection.where('gender',isEqualTo: gender).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot)  {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if (snapshot.hasError) {
                        return const Center(child: Text("Something went wrong"));
                      } else if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.requireData.docChanges.isEmpty){
                        return const Center(child: Text("No Shop Available"));
                      } else {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Choose Your Services'),
                                Text('Total - ${snapshot.data?.docs.length}'),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopDetailsScreen(snapshotData: snapshot.data?.docs[index])));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10,top: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child:  Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            child: Image.network(snapshot.data?.docs[index]['shopImage'],
                                              height: 90,width: 80,fit: BoxFit.fill,),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  Text(snapshot.data?.docs[index]['hairCategory'],
                                                      style : const TextStyle(color: AppColor.appColor),maxLines: 1,overflow: TextOverflow.ellipsis),
                                                  const SizedBox(height: 2),
                                                  Text(snapshot.data?.docs[index]['shopName'],
                                                      style : const TextStyle(color: AppColor.aquaColor2,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis),
                                                  const SizedBox(height: 4),
                                                  const Text('30 Shop',
                                                      style : TextStyle(color: AppColor.blackColor,fontSize: 10),overflow: TextOverflow.ellipsis),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            )
                          ],
                        );
                      }
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
