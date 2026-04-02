import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/features/service/booking/ui/steps/step1_branch_service.dart';
import 'package:ntl_app/features/service/booking/ui/steps/step2_details.dart';
import 'package:ntl_app/features/service/booking/ui/steps/step3_pickup.dart';
import 'package:ntl_app/features/service/booking/ui/steps/step4_summary.dart';

class BookingFlowPage extends ConsumerStatefulWidget {
  const BookingFlowPage({super.key});

  @override
  ConsumerState<BookingFlowPage> createState() => _BookingFlowPageState();
}

class _BookingFlowPageState extends ConsumerState<BookingFlowPage> {
  int step = 0;

  void nextStep() {
    if (step < 3) {
      setState(() => step++);
    }
  }

  void prevStep() {
    if (step > 0) {
      setState(() => step--);
    }
  }

  Widget getStep() {
    switch (step) {
      case 0:
        return Step1BranchService(onNext: nextStep);
      case 1:
        return Step2Details(onNext: nextStep);
      case 2:
        return Step3Pickup(onNext: nextStep);
      case 3:
        return Step4Summary();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTopAppBar(
            title: "Nagesh Touch Lab",
            showRightIcon: false,
            showBack: true,
            onBack: () {
              if (step > 0) {
                setState(() => step--);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          _stepIndicator(),

          Expanded(child: getStep()),
        ],
      ),
    );
  }

  Widget _stepIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              decoration: BoxDecoration(
                color: index <= step ? Colors.red : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}
