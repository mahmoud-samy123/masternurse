import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/presentation/home/model/nurse_model.dart';
import 'package:medical_app/presentation/home/widget/doctordetailscontainer.dart';
import '../../../const/colors.dart';
import '../../app/style/custom_button.dart';
import 'model/service.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({
    super.key,
    required this.nurse,
  });
  final Nurse nurse;
  static String id = 'DoctorDetails';

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  NurseService? _selectedService;

  void _bookAppointment() {
    if (_selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a service first')),
      );
      return;
    }

    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd HH:mm').format(now);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Appointment Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nurse (AR): ${widget.nurse.nameAr}'),
            Text('Nurse (EN): ${widget.nurse.nameEn}'),
            Text('Phone: ${widget.nurse.phone}'),
            const SizedBox(height: 8),
            Text('Service (AR): ${_selectedService!.nameAr}'),
            Text('Service (EN): ${_selectedService!.nameEn}'),
            Text('Price: ${_selectedService!.price}'),
            const SizedBox(height: 8),
            Text('Date & Time: $formatted'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final services = widget.nurse.services ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "Doctor Detail",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: width < 500
                ? width * 0.0472
                : width < 800
                ? width * 0.05
                : width * 0.02,
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
                photoUrl: widget.nurse.photo,
                doctorName: widget.nurse.nameEn,
                address: widget.nurse.cityEn,
              ),
              const SizedBox(height: 5),
              SizedBox(
                height:300,
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final svc = services[index];
                    final selected = svc == _selectedService;
                    return Card(
                      color: selected ? AppColor.kPrimaryColor1.withOpacity(0.3) : null,
                      child: ListTile(
                        title: Text(svc.nameEn),
                        subtitle: Text("${svc.price}"),
                        onTap: () {
                          setState(() => _selectedService = svc);
                        },
                      ),
                    );
                  },
                ),
              ),
SizedBox(height: 100,),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  onTap: _bookAppointment,
                  height: height * 0.0577,
                  width: width * 0.7472,
                  color: AppColor.kPrimaryColor1,
                  borderRadius: BorderRadius.circular(width * 0.0779),
                  border: Border.all(color: AppColor.kPrimaryColor1),
                  text: 'Book Appointment',
                  fontSize: width * 0.0365,
                  colorText: AppColor.kWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
