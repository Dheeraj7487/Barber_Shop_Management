import 'package:barber_booking_management/Appointment/screen/appointment_book_screen.dart';
import 'package:barber_booking_management/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_color.dart';
import '../../Appointment/widget/review_widget.dart';
import 'direction_screen.dart';

class ShopDetailsScreen extends StatefulWidget{
  const ShopDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> with SingleTickerProviderStateMixin{

  final List<Widget> _tabs = const [
    Text("About"),
    Text("Rating"),
  ];
  late TabController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = TabController(length: _tabs.length, vsync: this,initialIndex: 0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                      backgroundColor: AppColor.whiteColor,
                      pinned: true,
                      shadowColor: AppColor.blackColor,
                      toolbarHeight: 280,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: Column(
                        children: [
                          Stack(
                            children: [
                              const SizedBox(
                                height: 200,width: double.infinity,
                              ),
                              Image.network(
                                  'https://media.istockphoto.com/photos/hairstylist-serving-client-at-barber-shop-picture-id639607852?k=20&m=639607852&s=612x612&w=0&h=q7FFW0zs61g6Cclpv287xPaBpGeztqcm1y5EopR6-8Y=',
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.fill),

                              Container(
                                height: 220,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0x922B2626),
                                      Color(0x922B2626),
                                    ],
                                  ),
                                ),
                              ),

                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: const Icon(Icons.arrow_back),color: AppColor.whiteColor,),

                              Positioned(
                                left: 20,top: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Shop Name',
                                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: AppColor.whiteColor)),
                                    const Text('Address',
                                        style: TextStyle(color: AppColor.whiteColor,fontSize: 18,fontWeight: FontWeight.w500,)),
                                    const SizedBox(height: 10),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ignoreGestures : true,
                                      itemSize: 24,
                                      unratedColor: AppColor.whiteColor,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        debugPrint('$rating');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    const url = 'https://flutter.io';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await canLaunchUrl(Uri.parse(url));
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                   },
                                  child: Column(
                                    children: [
                                      Image.asset(AppImage.website,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Website',style: TextStyle(fontSize: 16))
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await launch('tel://7487026406');
                                  },
                                  child: Column(
                                    children:  [
                                      Image.asset(AppImage.call,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Call Now',style: TextStyle(fontSize: 16),)
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const DirectionScreen()));
                                  },
                                  child: Column(
                                    children:  [
                                      Image.asset(AppImage.map,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Direction',style: TextStyle(fontSize: 16),)
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AppointmentBookScreen()));
                                  },
                                  child: Column(
                                    children:  [
                                      Image.asset(AppImage.bookNow,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Book Now',style: TextStyle(fontSize: 16),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,)
                        ],
                      ),

                      bottom: TabBar(
                          unselectedLabelColor: AppColor.blackColor,
                          labelPadding: const EdgeInsets.symmetric(vertical: 10),
                          // isScrollable: true,
                          controller: controller,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: AppColor.blackColor,
                          indicatorColor: AppColor.appColor,

                          labelStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                          indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(width: 2,color: AppColor.appColor)
                          ),
                          tabs: _tabs
                      )
                  )
              )
            ];
          },
          body: TabBarView(
              controller: controller,
              children:  <Widget>[
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 10,top: 350),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('About'),
                      ],
                    ),
                  ),
                ),
                ReviewWidget()
              ]),
        ),
      )
    );
  }
}
