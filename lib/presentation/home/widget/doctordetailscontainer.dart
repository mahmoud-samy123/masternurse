import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/const/colors.dart';
import 'package:rich_readmore/rich_readmore.dart';

class DoctorDetailsContainer extends StatelessWidget {
  final String photoUrl;
  final String doctorName;
  final String category;
  final double rating;
  final String address;
  final String city;
  final String government;
  final String aboutDoctor;

  const DoctorDetailsContainer({
    super.key,
    required this.photoUrl,
    required this.doctorName,
    required this.category,
    required this.rating,
    required this.address,
    required this.city,
    required this.government,
    required this.aboutDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(0.0181654501216545*MediaQuery.of(context).size.width),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.048661800486618*MediaQuery.of(context).size.width),
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
                    borderRadius: BorderRadius.circular(0.024330900243309*MediaQuery.of(context).size.width),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.0057670126874279 *
                            MediaQuery.of(context).size.height,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.024330900243309*MediaQuery.of(context).size.width),
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
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.0072992700729927),
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
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 0.0316301703163017 *
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
        ),
        SizedBox(height: 0.0115340253748558*MediaQuery.of(context).size.height),
        Text(
          "About",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 0.0589294403892944 * MediaQuery.of(context).size.width,
            color: AppColor.kText1,
          ),
        ),
        const SizedBox(height: 5),
        RichReadMoreText.fromString(
          text: aboutDoctor,
          textStyle: GoogleFonts.inter(color: const Color(0xff199A8E)),
          settings: LengthModeSettings(
            trimLength: 80,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            onPressReadMore: () {
              /// specific method to be called on press to show more
            },
            onPressReadLess: () {
              /// specific method to be called on press to show less
            },
            lessStyle: GoogleFonts.inter(color: const Color(0xff199A8E)),
            moreStyle: GoogleFonts.inter(color: const Color(0xff199A8E)),
          ),
        ),
      ],
    );
  }
}



//Lorem ipsum dolor sit amet, consectetur adipiscing elicZXcazxvzcxvzvzcvzxczxadfsafasfasdfasdfasfasfasfasfasfsfaasfasdfasasfasfasfsaft, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...