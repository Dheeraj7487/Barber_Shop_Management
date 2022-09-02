import 'package:barber_booking_management/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Author'),
      ),
        body:  SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.1,
                        mainAxisExtent: 135
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0,right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                //borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0GXEFRS_vXMohkukMy9dUB_vSurIM_YLTjvJRd8IL&s',
                                    height: 80,width: 80,fit: BoxFit.fill),
                              ),
                              const SizedBox(height: 10),
                              const Text('Barber Name',maxLines: 2,overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: AppColor.blackColor),textAlign:TextAlign.center),
                            ],
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
