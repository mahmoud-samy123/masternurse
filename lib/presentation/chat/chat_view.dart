import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/const/chat_const.dart';
import 'package:medical_app/const/colors.dart';
import 'package:medical_app/cubits/connection/connection_cubit.dart';
import 'package:medical_app/cubits/global_cubit/global_cubit.dart';
import 'package:medical_app/presentation/chat/model/chat_model.dart';
import 'package:medical_app/services/fire_chat.dart';


import '../../app/style/custom_icon_button.dart';
import '../../app/style/custom_list_view_chat.dart';
import '../../app/style/custom_search.dart';
import '../../app/style/custom_text.dart';
import '../../cubits/connection/connection_event.dart';
import '../../cubits/connection/connection_state.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  static String id = 'Chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userModel =
        BlocProvider.of<GlobalCubit>(context, listen: true).userModel;
    //   843.4285714285714
    //   411.42857142857144
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.07113821138211382,
        left: width * 0.048611111111,
        right: width * 0.048611111111,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: 'Chat',
                colorText: AppColor.kText1,
                fontSize: width * 0.058333333,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              BlocBuilder<GlobalCubit, bool>(
                builder: (context, state) {
                  if(state){
                    return CustomIconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? const Icon(
                        Icons.close_rounded,
                        size: 30,
                      )
                          : const Icon(
                        Icons.search_rounded,
                        size: 30,
                      ),
                    );
                  }else{
                    return const SizedBox.shrink();
                  }

                },
              ),
            ],
          ),
          Container(
            child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomSearch(
                          controller: searchController,
                        ),
                        const Spacer(),
                        CustomIconButton(
                          onPressed: () {
                            setState(() {
                              FireChat().isDoctor;
                            });
                            if (searchController.text != '') {
                              FireChat()
                                  .createChat(searchController.text)
                                  .then((value) {
                                setState(() {
                                  searchController.text = '';
                                });
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.check,
                            color: AppColor.kPrimaryColor1,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  )

          ),
          Expanded(
            child: BlocBuilder<InternetBloc, InternetState>(
              builder: (context, connectState) {
                if (connectState is InternetConnectedState) {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(kRoomsCollections)
                        .where(kMembers, arrayContains: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ChatModel> items = snapshot.data!.docs
                            .map((e) => ChatModel.fromJson(e.data()))
                            .toList()
                          ..sort((a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!));

                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return CustomListViewChat(
                              chatModel: items[index],
                            );
                          },
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
                } else if (connectState is InternetDisconnectedState) {
                  return const Center(
                    child: CustomText(
                      text: "Internet Not Connected",
                      colorText: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  );
                } else {
                  return const Center(
                    child: CustomText(
                      text: "Checking connection...",
                      colorText: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
