import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/presentation/home/widget/doctordetailscontainer.dart';
import '../../../const/colors.dart';
import '../../app/style/custom_button.dart';
import 'doctorbooking.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({
    super.key,
    required this.photoUrl,
    required this.doctorName,
    required this.category,
    required this.rating,
    required this.address,
    required this.city,
    required this.government,
    required this.aboutUs,
    required this.times,
    required this.reservation,
    required this.email,
  });
  final String email;
  final String photoUrl;
  final String doctorName;
  final String category;
  final double rating;
  final String address;
  final String city;
  final String government;
  final String aboutUs;
  final List<Timestamp> times;
  final int reservation;
  static String id = 'DoctorDetails';

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  late DateTime _selectedDate;
  late int checkin; // Define checkin variable
  late List<DateTime> dateTimeList; // List to hold converted times

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    checkin = -1; // Initialize checkin variable
    dateTimeList =
        widget.times.map((timestamp) => timestamp.toDate()).toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "Doctor Detail",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width < 500
                ? MediaQuery.of(context).size.width * 0.0472
                : MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.width * 0.05
                : MediaQuery.of(context).size.width * 0.02,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DoctorDetailsContainer(
                photoUrl: widget.photoUrl,
                doctorName: widget.doctorName,
                category: widget.category,
                rating: widget.rating,
                address: widget.address,


                aboutDoctor: widget.aboutUs, city: widget.city, government:  widget.government,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 336.7,
                width: 341.1,
                decoration: BoxDecoration(
                  color: AppColor.kWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2130),
                  onDateChanged: (dateTimeList) {
                    setState(() {
                      _selectedDate = dateTimeList;
                      DateTime dateTime =
                      DateTime.parse(_selectedDate.toString());
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(dateTime);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 45,
                ),
                itemCount: dateTimeList.length,
                itemBuilder: (BuildContext context, int index) {
                  final formattedTime = dateFormat.format(dateTimeList[index]);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        checkin = index;
                      });
                    },
                    child: Container(
                      width: 103,
                      height: 37,
                      decoration: BoxDecoration(
                        color: checkin != index
                            ? AppColor.kWhite
                            : AppColor.kPrimaryColor1,
                        border: Border.all(
                          color: checkin != index
                              ? AppColor.kWhite
                              : AppColor.kPrimaryColor1,
                        ),
                        borderRadius:
                        BorderRadius.circular(0.048661800486618 * width),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(0, 4),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          formattedTime,
                          style: GoogleFonts.inter(
                            fontSize: 0.0389294403892944 * width,
                            fontWeight: FontWeight.w600,
                            color: checkin != index
                                ? AppColor.kBlack
                                : AppColor.kWhite,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 0.0115340253748558 * height,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorBooking(
                          name: widget.doctorName,
                          category: widget.category,
                          rating: widget.rating,
                          address: widget.address,
                          photoUrl: widget.photoUrl,
                          city: widget.city,
                          government: widget.government,
                          reservation: widget.reservation,
                        ),
                      ));
                    },
                    height: height * 0.0576701268742791,
                    width: width * 0.7472019464720195,
                    color: AppColor.kPrimaryColor1,
                    borderRadius:
                    BorderRadius.circular(0.0778588807785888 * width),
                    border: Border.all(
                      color: AppColor.kPrimaryColor1,
                    ),
                    text: 'Book Appointment',
                    fontSize: width * 0.0364963503649635,
                    colorText: AppColor.kWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
