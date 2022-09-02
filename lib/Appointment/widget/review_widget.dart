import 'package:barber_booking_management/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget({Key? key}) : super(key: key);

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top: 350),
        child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.blackColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                              child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPFplvJPKa32UzY3wELd3ytDEQgt_WupBDKpXWwcvGhg&s',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.fill)
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('User Name'),
                              const SizedBox(height: 5,),
                              RatingBar.builder(
                                initialRating: 4,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ignoreGestures : true,
                                itemSize: 15,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  debugPrint('$rating');
                                },
                              ),
                              SizedBox(height: 5),
                              Text('Excellent Service')
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        )
      ),
    );
  }
}
