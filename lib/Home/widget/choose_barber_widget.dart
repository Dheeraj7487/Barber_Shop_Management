import 'package:barber_booking_management/Home/screen/author_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class ChooseBarberWidget extends StatelessWidget {
  const ChooseBarberWidget({Key? key}) : super(key: key);

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
                        text: "Choose Your Barber",
                        style: TextStyle(
                          color: AppColor.appColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AuthorScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                    child: const Text('View All',style: TextStyle(color: AppColor.greyColor),)),
              )
            ],
          ),
        ),
        Container(
          height: 100,
          margin: const EdgeInsets.only(left: 10),
          child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){},
                  child: SizedBox(
                    width: 90,
                    height: 100,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.network('https://st2.depositphotos.com/2931363/9695/i/950/depositphotos_96952024-stock-photo-young-handsome-man-in-barbershop.jpg',
                            height: 60,width: 60,fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        const Text('Barber Name',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)
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
