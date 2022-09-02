import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 300,width: double.infinity,
                  ),
                  Image.network(
                      'https://images.unsplash.com/photo-1600948836101-f9ffda59d250?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aGFpciUyMHNhbG9ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.fill),
                  Positioned(
                    left: 0,right: 0,top: 130,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColor.whiteColor,
                              ),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: ClipOval(
                              child: Image.network(
                                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.fill)

                          ),
                        ),
                        const Text('User Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: AppColor.blackColor)),
                        const Text('Shop Name'),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ignoreGestures : true,
                              itemSize: 24,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                debugPrint('$rating');
                              },
                            ),
                            const SizedBox(width: 10),
                            const Text('( 100 Review)')
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 5,
                      child: GestureDetector(
                        onTap: (){},
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.edit,color: AppColor.whiteColor.withOpacity(0.7),)),
                      )
                  )
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('About Me',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 5),
                    const Text('It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model tex',style: TextStyle(fontSize: 12)),

                    const SizedBox(height: 10),
                    const Text('Opening Hours',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Mon - Wed'),
                            SizedBox(height: 10),
                            Text('Thu - Sat'),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('08:00 am - 10:00 pm'),
                            SizedBox(height: 10),
                            Text('10:00 am - 06:00 pm'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text('Address',style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on),
                        SizedBox(width: 10),
                        Expanded(child: Text('It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model tex',style: TextStyle(fontSize: 12))),
                      ],
                    ),

                  ],
                ),
              )
              
            ],
          )
        )
      );
  }
}
