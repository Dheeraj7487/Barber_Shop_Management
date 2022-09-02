import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class PopularCategoryWidget extends StatelessWidget {
  const PopularCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: "Popular Category",
                        style: TextStyle(
                          color: AppColor.appColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthorScreen()));
                },
                child: Container(
                    padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                    child: const Text('View All',style: TextStyle(color: AppColor.greyColor),)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 190,
          child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    width: 160,
                    height: 200,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        Image.network('https://media.istockphoto.com/photos/hairstylist-serving-client-at-barber-shop-picture-id639607852?k=20&m=639607852&s=612x612&w=0&h=q7FFW0zs61g6Cclpv287xPaBpGeztqcm1y5EopR6-8Y=',
                            height: 120,width: double.infinity,fit: BoxFit.fill),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: const Center(
                              child: Text('Hair Style',
                                  style: TextStyle(color: AppColor.appColor,fontSize: 16),textAlign:TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis)),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: Center(
                              child: Text('10 Place',
                                style: const TextStyle(color: AppColor.blackColor,fontSize: 10,overflow: TextOverflow.ellipsis),textAlign:TextAlign.center,maxLines: 2,)),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}
