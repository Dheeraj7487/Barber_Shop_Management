import 'package:barber_booking_management/Home/screen/shop_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/app_color.dart';

class ServiceCategoryScreen extends StatelessWidget {
  const ServiceCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  child: Text('Hair Style',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.1,
                      mainAxisExtent: 250
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopDetailsScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                        child: Card(
                          elevation: 5,
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0GXEFRS_vXMohkukMy9dUB_vSurIM_YLTjvJRd8IL&s',
                                    height: 120,width: double.infinity,fit: BoxFit.fill),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.only(left: 5,right: 5),
                                child: const Text('Shop Name',maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColor.blackColor),textAlign:TextAlign.start),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                child: Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ignoreGestures : true,
                                      itemSize: 18,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        debugPrint('$rating');
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    const Text('203')
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                child: const Text('\$ 20',maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColor.blackColor),textAlign:TextAlign.start),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                child: const Text('Address',maxLines: 2,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColor.blackColor),textAlign:TextAlign.start),
                              ),
                              const SizedBox(height: 5)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      )
    );
  }
}
