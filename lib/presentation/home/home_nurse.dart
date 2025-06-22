import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_cubit/home_cubit.dart';
import 'model/nurse_model.dart';
import 'model/service.dart';

class HomeNurse extends StatelessWidget {
  const HomeNurse({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().fetchIamDoctorData();

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is TopdoctorHomeloading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TopdoctorHomeError) {
            return Center(child: Text(state.error));
          } else if (state is TopdoctorHomeSuccefully) {
            final cubit = context.read<HomeCubit>();
            final nurseList = cubit.data2;

            if (nurseList.isEmpty) {
              return const Center(child: Text("لا توجد بيانات."));
            }

            final nurse = nurseList[0];

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("الاسم", nurse.nameAr),
                    _buildInfoRow("المدينة", nurse.cityAr),
                    _buildInfoRow("رقم الهاتف", nurse.phone),
                    const SizedBox(height: 24),
                    const Text(
                      "الخدمات",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    ...List.generate(nurse.services?.length ?? 0, (index) {
                      final service = nurse.services![index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(service.nameAr),
                          subtitle: Text("السعر: ${service.price} جنيه"),
                          leading: const Icon(Icons.medical_services),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              nurse.services!.removeAt(index);
                              await cubit.updateNurseServices(nurse);
                              cubit.fetchIamDoctorData();
                            },
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showAddServiceDialog(context, nurse);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("إضافة خدمة"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("جار تحميل البيانات..."));
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value ?? "-",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context, Nurse nurse) {
    final nameArController = TextEditingController();
    final nameEnController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("إضافة خدمة جديدة"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameArController,
                  decoration: const InputDecoration(labelText: "الاسم بالعربي"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameEnController,
                  decoration: const InputDecoration(labelText: "الاسم بالإنجليزية"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "السعر"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () async {
                final service = NurseService(
                  nameAr: nameArController.text.trim(),
                  nameEn: nameEnController.text.trim(),
                  price: int.tryParse(priceController.text.trim()) ?? 0,
                );

                nurse.services ??= [];
                nurse.services!.add(service);

                final cubit = context.read<HomeCubit>();
                await cubit.updateNurseServices(nurse);
                cubit.fetchIamDoctorData();

                Navigator.pop(context);
              },
              child: const Text("إضافة"),
            ),
          ],
        );
      },
    );
  }
}
