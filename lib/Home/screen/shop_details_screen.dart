import 'package:barber_booking_management/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Appointment/Screen/appointment_book_screen.dart';
import '../../Category/widget/review_widget.dart';
import '../../utils/app_color.dart';
import 'direction_screen.dart';

class ShopDetailsScreen extends StatefulWidget{

  var snapshotData;
  ShopDetailsScreen({Key? key,required this.snapshotData}) : super(key: key);

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
                      automaticallyImplyLeading : false,
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
                                  widget.snapshotData['shopImage'],
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
                                      Color(0x924E4444),
                                    ],
                                  ),
                                ),
                              ),

                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Container(
                                  padding: const EdgeInsets.only(left: 8,right: 5,bottom: 5,top: 5),
                                  decoration: BoxDecoration(
                                      color: AppColor.whiteColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: const Icon(Icons.arrow_back_ios,)),color: AppColor.whiteColor,iconSize: 24),

                              Positioned(
                                left: 20,bottom: 10,right: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(widget.snapshotData['shopName'],maxLines: 3,overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold,color: AppColor.whiteColor)),
                                     Text(widget.snapshotData['address'],
                                        style: const TextStyle(color: AppColor.whiteColor,fontSize: 12)),
                                     const SizedBox(height: 5),
                                    RatingBar.builder(
                                      initialRating: widget.snapshotData['rating'],
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      ignoreGestures : true,
                                      itemSize: 20,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible : widget.snapshotData['webSiteUrl'] != '' ? true : false,
                                  child: GestureDetector(
                                    onTap: () async {
                                      String url = widget.snapshotData['webSiteUrl'];
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                     },
                                    child: Column(
                                      children: [
                                        Image.asset(AppImage.website,height: 30,width: 30),
                                        const SizedBox(height: 5),
                                        const Text('Website')
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final launchUri = Uri(
                                        scheme: 'tel',
                                        path: widget.snapshotData['contactNumber']
                                    );
                                    await launchUrl(launchUri);
                                    //await launch('tel:${widget.snapshotData['contactNumber']}');
                                  },
                                  child: Column(
                                    children:  [
                                      Image.asset(AppImage.call,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Call Now')
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                        DirectionScreen(longitude: widget.snapshotData['longitude'],
                                          latitude: widget.snapshotData['latitude'],
                                          shopName: widget.snapshotData['shopName'],
                                          shopAddress: widget.snapshotData['address'],
                                        )));
                                  },
                                  child: Column(
                                    children:  [
                                      Image.asset(AppImage.map,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Direction')
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentBookScreen(snapshotData: widget.snapshotData,)));
                                  },
                                  child: Column(
                                    children:  [
                                      Image.asset(AppImage.bookNow,height: 30,width: 30),
                                      const SizedBox(height: 5),
                                      const Text('Book Now')
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
                        Text(widget.snapshotData['shopDescription'],style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                ReviewWidget(snapshotData: widget.snapshotData,shopName: widget.snapshotData['shopName'],
                  currentUser: widget.snapshotData['currentUser'],)
              ]),
        ),
      )
    );
  }
}
