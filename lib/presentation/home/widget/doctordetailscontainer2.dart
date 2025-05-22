import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';

class DoctorDetailsContainer2 extends StatelessWidget {
  final String photoUrl;
  final String doctorName;
  final String category;
  final double rating;
  final String address;
  final String city;
  final String government;

  const DoctorDetailsContainer2({
    super.key,
    required this.photoUrl,
    required this.doctorName,
    required this.category,
    required this.rating,
    required this.address,
    required this.city,
    required this.government,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                0.048661800486618 * MediaQuery.of(context).size.width),
            color: AppColor.kWhite,
            border: Border.all(
              color: AppColor.kColorCircle,
            ),
          ),
          width: 0.9926520681265207 * MediaQuery.of(context).size.width,
          height: 0.1441753171856978 * MediaQuery.of(context).size.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 0.024330900243309 * MediaQuery.of(context).size.width,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      0.024330900243309 * MediaQuery.of(context).size.width),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.0057670126874279 *
                          MediaQuery.of(context).size.height,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.024330900243309 *
                          MediaQuery.of(context).size.width),
                      child: Image.network(
                        photoUrl,
                        width: 0.267639902676399 *
                            MediaQuery.of(context).size.width,
                        height: 0.1268742791234141 *
                            MediaQuery.of(context).size.height,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 0.024330900243309 * MediaQuery.of(context).size.width,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.0115340253748558 *
                        MediaQuery.of(context).size.height,
                  ),
                  Text(
                    "Dr.$doctorName",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 0.0437956204379562 *
                          MediaQuery.of(context).size.width,
                      color: AppColor.kText1,
                    ),
                  ),
                  Text(
                    category,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width *
                          0.0291970802919708,
                      color: AppColor.ratingColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.0057670126874279,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height *
                                  0.0072992700729927),
                          color: AppColor.kColorCircle,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColor.kPrimaryColor1,
                              size: 0.048661800486618 *
                                  MediaQuery.of(context).size.width,
                            ),
                            Text(
                              rating.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 0.0291970802919708 *
                                    MediaQuery.of(context).size.width,
                                color: AppColor.kPrimaryColor1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.0057670126874279 *
                        MediaQuery.of(context).size.height,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: 0.0334963503649635 *
                            MediaQuery.of(context).size.width,
                        color: AppColor.kPrimaryColor1,
                      ),
                      Text(
                        "$address, $city, $government",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 0.0270001003163017 *
                              MediaQuery.of(context).size.width,
                          color: AppColor.kPrimaryColor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
