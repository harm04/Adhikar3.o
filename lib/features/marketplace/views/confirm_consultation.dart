import 'package:adhikar3_o/constants/appwrite_constants.dart';
import 'package:adhikar3_o/theme/pallete_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmConsultation extends StatefulWidget {
  final String date;
  final String time;
  final String profImage;
  final String amount;
  final String uid;
  final String firstName;
  final String lastName;
  final String email;

  const ConfirmConsultation(
      {super.key,
      required this.date,
      required this.time,
      required this.amount,
      required this.uid,
      required this.firstName,
      required this.lastName,
      required this.profImage,
      required this.email});

  @override
  State<ConfirmConsultation> createState() => _ConfirmConsultationState();
}

class _ConfirmConsultationState extends State<ConfirmConsultation> {
  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Navigator.pop(context);
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return const MyMeetingsScreen();
    // }));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
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

  void openCheckout(String totalAmount, String username, String description,
      String contact, String email) async {
    var options = {
      'key': AppwriteConstants.razorpayKey,
      'amount': totalAmount,
      'name': username, 
      'description': description,
      'prefill': {'contact': contact, 'email': email}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double amount = double.parse(widget.amount);
    double totalAmount = amount * 0.21 + amount;
    double razorpayAmount = totalAmount * 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Pallete.primaryColor,
            statusBarIconBrightness: Brightness.light),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Confirm Payemnt',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 242, 242),
                  borderRadius: BorderRadius.circular(20)),
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Online Consultation",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.date,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.time,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Amount',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.amount} Rs',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GST',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '21%',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${totalAmount.toString()} Rs',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
                'Note :- Money will be deducted once you click on the Proceed to pay button.'),
          ),
          Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () async {
                  // UserModel userModel =
                  //     Provider.of<UserProvider>(context, listen: false).getUser;
                  // // LawyerModel lawyerModel =
                  // //     Provider.of<LawyerProvider>(context, listen: false)
                  // //         .getLawyer;

                  // //if we want all meetings to be visible in my meetings section then just change meetinguid to a random uid
                  // final meetingUid =
                  //    Random().nextInt(10000);
                  openCheckout(
                      razorpayAmount.toString(),
                      '${widget.firstName} ${widget.lastName}',
                      'Consultation with lawyer',
                      '9999999999',
                      widget.email);
                  // print('meeting id :$meetingUid');

                  // //creating a collection named meetings
                  // await FirebaseFirestore.instance
                  //     .collection('Meetings')
                  //     .doc(meetingUid.toString())
                  //     .set({
                  //   "meetingUid": meetingUid,
                  //   "lawyerName": '${widget.firstName} ${widget.lastName}',
                  //   "clientName":
                  //       '${userModel.firstName} ${userModel.lastName}',
                  //   "time": widget.time,
                  //   "date": widget.date,
                  //   "status": "pending",
                  //   "profImage": widget.profImage,
                  //   "ratings": 3,
                  //   "clientProfImage":userModel.profImage??""
                  // });

                  // //adding meeting uid in user collection
                  // await FirebaseFirestore.instance
                  //     .collection('Users')
                  //     .doc(userModel.uid)
                  //     .update({
                  //   "meetings": FieldValue.arrayUnion([meetingUid]),
                  // });
                  // //adding meeting uid in lawyer collection
                  // await FirebaseFirestore.instance
                  //     .collection('Lawyers')
                  //     .doc(widget.uid)
                  //     .update({
                  //   "meetings": FieldValue.arrayUnion([meetingUid]),
                  // });
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(16, 32, 55, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'Proceed to pay ${totalAmount.toString()} Rs',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ))
        ],
      ),
    );
  }
}
