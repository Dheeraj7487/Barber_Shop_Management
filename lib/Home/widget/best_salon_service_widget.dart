import 'package:barber_booking_management/Home/screen/shop_details_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class BestSalonServiceWidget extends StatelessWidget {
  const BestSalonServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: "Best Salon Service",
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShopDetailsScreen()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShopDetailsScreen()));
                  },
                  child: Container(
                    width: 200,
                    height: 180,
                    padding: const EdgeInsets.only(left:20,right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              child: Image.network('https://media.gettyimages.com/photos/barber-shop-picture-id1288801785?s=612x612',
                                  height: 120,width: double.infinity,fit: BoxFit.fill),
                            ),
                            Positioned(
                                bottom: 10,left: 10,right: 10,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 5,right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor.whiteColor
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.star,color: Colors.amber,),
                                          SizedBox(width: 5),
                                          Text('4.0')
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      padding: EdgeInsets.only(left: 10,right: 10,top: 2.5,bottom: 2.5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor.beachColor1
                                      ),
                                      child: Text('Open',style: TextStyle(color: AppColor.whiteColor),),
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: const Text('Salon Name',
                              style: TextStyle(color: AppColor.appColor,fontSize: 16),textAlign:TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: const Text('City',
                            style: TextStyle(color: AppColor.blackColor,fontSize: 10,overflow: TextOverflow.ellipsis),textAlign:TextAlign.center,maxLines: 2,),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}
