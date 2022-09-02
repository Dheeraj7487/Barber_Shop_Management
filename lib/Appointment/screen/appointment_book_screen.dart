import 'package:barber_booking_management/mixin/button_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../utils/app_color.dart';

class AppointmentBookScreen extends StatefulWidget {
  const AppointmentBookScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentBookScreen> createState() => _AppointmentBookScreenState();
}

class _AppointmentBookScreenState extends State<AppointmentBookScreen> {

  DateTime? pickedDate;

  DateTime appointmentDate = DateTime.now();

  late Razorpay _razorpay;
  static const platform = MethodChannel("razorpay_flutter");


  List timeSlot = ['08:00 AM','09:00 AM','10:00 AM',
    '11:00 AM','12:00 PM',
    '02:00 PM','03:00 PM','04:00 PM','05:00 PM','06:00 PM','07:00 PM'];

  Future<void> selectAppointmentDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {}
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': 100,
      'name': 'Shop Name',
      'description': 'Description Shop',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '7487026406', 'email': 'shop@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          padding: const EdgeInsets.only(top:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap : () {
                  selectAppointmentDate(context);
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select Date'),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColor.blackColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_outlined,color: AppColor.appColor,),
                            const SizedBox(width: 10),
                            Text(pickedDate == null ? "Please select date" : DateFormat('dd-MM-yyyy').format(appointmentDate),
                                style: const TextStyle(fontSize: 16)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Select Time'),
              SizedBox(height: 10),
              Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    for(var item in timeSlot)...{
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 40,
                              minHeight: 0,
                              maxWidth: 500,
                              minWidth: 0
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.appColor
                              ),
                              child: TextButton(
                                onPressed: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResults(item)));
                                },
                                child: Text('$item',style: const TextStyle(color: AppColor.whiteColor,overflow: TextOverflow.ellipsis),),
                              )
                          )
                      )
                    }
                  ]
              ),
              SizedBox(height: 50),
              GestureDetector(
                  onTap: (){
                    openCheckout();
                  },
                  child: ButtonMixin().appButton(text: 'Book Now')
              ),

            ],
          ),
        ),
      ),
    );
  }
}
