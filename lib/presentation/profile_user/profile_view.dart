import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medical_app/presentation/localization/localizationCubit/localization_cubit.dart';
import 'package:medical_app/presentation/profile_user/update_to_doctor.dart';
import 'package:medical_app/presentation/profile_user/widget/textbutton.dart';
import 'package:medical_app/presentation/profile_user/widget/row_reusable.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/const/colors.dart';

import '../../../const/navigations.dart';
import '../../../const/show_dialog.dart';
import '../../../cubits/connection/connection_cubit.dart';
import '../../../generated/l10n.dart';
import '../../cubits/connection/connection_event.dart';
import '../../cubits/connection/connection_state.dart';
import '../localization/model/localization.dart';
import 'model/user_model.dart';
import '../../app/style/custom_icon.dart';
import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_text.dart';
import '../auth/login_or_sign_up.dart';
import 'edite_profile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static String id = 'profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    userModel;
    super.initState();
  }

  File? file;
  // Image/user.png
  Future getImage() async {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final ImagePicker imagePicker = ImagePicker();
    final XFile? imageGallery =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      file = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage =
          FirebaseStorage.instance.ref('imageProfile').child(imageName);
      await refStorage.putFile(file!);
      urlImage = await refStorage.getDownloadURL();
      // await  FirebaseFirestore.instance
      //     .collection(kUsersCollections)
      //     .doc(myId)
      //     .set(userModel1!.toJson());
      //userModel!.image = urlImage;
      await FirebaseFirestore.instance
          .collection(kUsersCollections)
          .doc(myId)
          .update({
        kImage: urlImage,
      });
      file = null;
      setState(() {});
    }
  }
  User? user = FirebaseAuth.instance.currentUser;
  Future<bool> userGoogle = GoogleSignIn().isSignedIn();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(kUsersCollections)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userModel1 = UserModel.fromJson(snapshot.data!.data()!);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColor.kGreen2,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 91,
                  ),
                  child:               BlocBuilder<InternetBloc, InternetState>(
                    builder: (context, connectState) {
                      InternetBloc internetBloc = BlocProvider.of<InternetBloc>(context);
    if (connectState is InternetConnectedState){
    return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Container(
    child: Stack(
    clipBehavior: Clip.none,
    children: [
    // ClipOval(
    //   child: urlImage != null &&
    //           userModel1!.image!.isNotEmpty
    //       ? Image.network(
    //           userModel1!.image!,
    //           width: 130,
    //           height: 130,
    //           fit: BoxFit.fill,
    //         )
    //       : Container(
    //           width: 130,
    //           height: 130,
    //           padding: EdgeInsets.all(25),
    //           decoration: BoxDecoration(
    //             shape: BoxShape.circle,
    //             color: Colors.grey[200],
    //           ),
    //           child: Image.asset(
    //             "Image/user.png",
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    // ),
    if (urlImage != null) ...[
    ClipOval(
    child: Image.network(
    urlImage!,
    width: 130,
    height: 130,
    fit: BoxFit.fill,
    ),
    ),
    ] else if (userModel1!.image!.isNotEmpty) ...[
    ClipOval(
    child: Image.network(
    userModel1!.image!,
    width: 130,
    height: 130,
    fit: BoxFit.fill,
    ),
    ),
    ]else if(urlImage == null || userModel1!.image==null )...[
    Container(
    width: 130,
    height: 130,
    padding: const EdgeInsets.all(25),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.grey[200],
    ),
    child: Image.asset(
    "Image/user.png",
    fit: BoxFit.fill,
    ),
    ),
    ],
    Positioned(
    child: Container(
    child: Center(
    child: CustomIconButton(
    onPressed: () async {
    await getImage().then((value) {
    if (urlImage != null) {
    FirebaseAuth
        .instance.currentUser!
        .updatePhotoURL(urlImage);
    }
    });
    },
    icon: const Icon(
    Icons.edit,
    color: AppColor.kWhite,
    size: 15,
    ),
    ),
    ),
    decoration: const BoxDecoration(
    color: Colors.red,
    shape: BoxShape.circle,
    ),
    height: 35,
    width: 35,
    ),
    bottom: -5,
    right: -5,
    ),
    ],
    ),
    ),
    const SizedBox(
    height: 20,
    ),
    CustomText(
    text: userModel1!.name!,
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 19,
    ),
    const SizedBox(
    height: 5,
    ),
    userModel1!.email == null
    ? const SizedBox.shrink()
        : CustomText(
    text: userModel1!.email!,
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    ),
    const SizedBox(
    height: 30,
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
    height: 90,
    width: 2,
    decoration: const BoxDecoration(
    color: AppColor.kWhite,
    ),
    ),
    const SizedBox(
    width: 60,
    ),
    Column(
    children: [
    CustomText(
    text: S.of(context).age,
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 11,
    ),
    const SizedBox(
    height: 15,
    ),
    const CustomText(
    text: '25',
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    ),
    ],
    ),
    const SizedBox(
    width: 40,
    ),
    Column(
    children: [
    CustomText(
    text: S.of(context).weight,
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 11,
    ),
    const SizedBox(
    height: 15,
    ),
    const CustomText(
    text: '80',
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    ),
    ],
    ),
    const SizedBox(
    width: 40,
    ),
    Column(
    children: [
    CustomText(
    text: S.of(context).height,
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 11,
    ),
    const SizedBox(
    height: 15,
    ),
    const CustomText(
    text: '180',
    colorText: AppColor.kWhite,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    ),
    ],
    ),
    const SizedBox(
    width: 60,
    ),
    Container(
    height: 90,
    width: 2,
    decoration: const BoxDecoration(
    color: AppColor.kWhite,
    ),
    ),
    ],
    ),
    ],
    );
    }

                       else if (connectState is InternetDisconnectedState) {
      return const CustomText(
        text: "No Internet Connection",
        colorText: Colors.red,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      );
                      }
                      return CustomText(
                        text: "Checking Connection...",
                        colorText: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      );


                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 23,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColor.kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowReusable(
                        onTap: () {
                          pushNamed(context, EditeProfile.id);
                        },
                        leadingIcon: Icons.person_outlined,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 17,
                        title: CustomText(
                          text: S.of(context).profile,
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: const CustomIcon(
                          icon: Icons.arrow_forward_ios,
                          color: AppColor.kText2,
                          size: 20,
                        ),
                      ),
                      RowReusable(
                        onTap: () {
                          pushNamed(context, UpdateToDoctor.id);
                        },
                        leadingIcon: Icons.accessibility_new_outlined,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 17,
                        title: const CustomText(
                          text: 'I am a doctor',
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: const CustomIcon(
                          icon: Icons.arrow_forward_ios,
                          color: AppColor.kText2,
                          size: 20,
                        ),
                      ),
                      RowReusable(
                        onTap: () {},
                        leadingIcon: Icons.language,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 17,
                        title: CustomText(
                          text: S.of(context).language,
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextButton(
                              onPressed: () {
                                BlocProvider.of<LocalizationCubit>(context)
                                    .appLanguage(
                                        LanguageEventEnums.englishLanguage);
                              },
                              text: 'English',
                              colorText: AppColor.kPrimaryColor1,
                            ),
                            CustomTextButton(
                              onPressed: () {
                                BlocProvider.of<LocalizationCubit>(context)
                                    .appLanguage(
                                        LanguageEventEnums.arabicLanguage);
                              },
                              text: 'العربية',
                              colorText: AppColor.kPrimaryColor1,
                            ),
                          ],
                        ),
                      ),
                      // RowReusable(
                      //   leadingIcon: Icons.logout,
                      //   leadingIconColor: AppColor.kPrimaryColor1,
                      //   leadingIconSize: 17,
                      //   title: CustomText(
                      //     text: 'Mode',
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      //   trailing: BlocBuilder<ThemeCubit, ThemeState>(
                      //     builder: (context, state) {
                      //       return Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           CustomIconButton(
                      //             onPressed: () {
                      //               BlocProvider.of<ThemeCubit>(context)
                      //                   .changeMode(ThemeEnum.Dark);
                      //             },
                      //             icon: Icon(
                      //               Icons.dark_mode_outlined,
                      //               color: Colors.black54,
                      //               size: 30,
                      //             ),
                      //           ),
                      //           CustomIconButton(
                      //             onPressed: () {
                      //               BlocProvider.of<ThemeCubit>(context)
                      //                   .changeMode(ThemeEnum.Light);
                      //             },
                      //             icon: Icon(
                      //               Icons.light_mode_outlined,
                      //               color: Colors.yellow[700],
                      //               size: 30,
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),
                      RowReusable(
                        onTap: () async {
                          // if (user != null) {
                          //   await ShowAlert.showErrorORWarningDialog(
                          //     isError: false,
                          //     context: context,
                          //     subtitle: 'Are you sure?',
                          //     fct: () async
                          //     {
                          //       if(isLogin == true) {
                          //         print(isLogin);
                          //         await FirebaseAuth.instance.signOut();
                          //         if(!mounted) return;
                          //         pushNamedAndRemoveUntil(
                          //           context, LoginOrSignUp.id,
                          //         );
                          //         isLogin = false;
                          //         print(isLogin);
                          //       } else if(isLoginGoogle = true) {
                          //         print(isLoginGoogle);
                          //         GoogleSignIn googleSignIn = GoogleSignIn();
                          //         await googleSignIn.disconnect();
                          //         pushNamedAndRemoveUntil(
                          //           context, LoginOrSignUp.id,
                          //         );
                          //         isLoginGoogle = false;
                          //         print(isLoginGoogle);
                          //       } else {
                          //         return;
                          //       }
                          //     },
                          //   );
                          // }

                          if (user != null) {
                            await ShowAlert.showErrorORWarningDialog(
                              isError: false,
                              context: context,
                              subtitle: 'Are you sure?',
                              fct: () async
                              {
                                if(user != null) {
                                  await FirebaseAuth.instance.signOut();
                                  if(!mounted) return;
                                  pushNamedAndRemoveUntil(
                                    context, LoginOrSignUp.id,
                                  );
                                } else if(userGoogle == true) {
                                  GoogleSignIn googleSignIn = GoogleSignIn();
                                  await googleSignIn.disconnect();
                                  if(!mounted) return;
                                  pushNamedAndRemoveUntil(
                                    context, LoginOrSignUp.id,
                                  );
                                } else {
                                  return;
                                }
                              },
                            );
                          }
                        },
                        leadingIcon: Icons.logout,
                        leadingIconColor: AppColor.kPrimaryColor1,
                        leadingIconSize: 17,
                        title: CustomText(
                          text: S.of(context).logout,
                          fontWeight: FontWeight.w600,
                        ),
                        trailing: const CustomIcon(
                          icon: Icons.arrow_forward_ios,
                          color: AppColor.kText2,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.kPrimaryColor1,
            ),
          );
        }
      },
    );
  }
}
