import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntl_app/core/components/button.dart';
import 'package:ntl_app/core/components/custom_topbar.dart';
import 'package:ntl_app/features/service/booking/provider/booking_provider.dart';
import 'package:ntl_app/features/service/booking/store/booking.dart';
import 'package:ntl_app/features/service/provider/service_notifier.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({super.key});

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  int selectedDay = 1;
  String selectedTime = "11:00 AM";
  late List<DateTime> dates;
  String? selectedServiceId;
  DateTime? selectedDate;
  String? selectedSlotTime;
  String? selectedJewelleryType;
  List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    dates = List.generate(30, (index) {
      return today.add(Duration(days: index));
    });

    Future.microtask(() {
      ref.read(servicesProvider.notifier).fetchServices();
    });
  }

  Future<void> pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          selectedImages.addAll(pickedFiles.map((e) => File(e.path)));
        });
      }
    } else {
      final picked = await _picker.pickImage(source: source);

      if (picked != null) {
        setState(() {
          selectedImages.add(File(picked.path));
        });
      }
    }
  }

  void showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String formatTime(String time) {
    final parts = time.split(":");
    int hour = int.parse(parts[0]);
    final minute = parts[1];

    final period = hour >= 12 ? "PM" : "AM";

    hour = hour > 12 ? hour - 12 : hour;
    if (hour == 0) hour = 12;

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    final servicesState = ref.watch(servicesProvider);
    final controller = ref.read(appointmentControllerProvider.notifier);
    final state = ref.watch(appointmentControllerProvider);
    final store = ref.watch(appointmentStoreProvider);

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    String getMonthShort(int month) {
      const months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      return months[month - 1];
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Column(
        children: [
          CustomTopAppBar(
            title: "Nagesh Touch Lab",
            showBack: true,
            showRightIcon: false,
            onBack: () => Navigator.pop(context),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.primary.withValues(alpha: 0.2),
                          Colors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 👇 Small label (premium feel)
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.primary.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // 👇 Main title
                        const Text(
                          "Book Your Appointment",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // 👇 Subtitle
                        Text(
                          "Choose your service, pick a date, and reserve your slot for accurate jewellery testing.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  if (servicesState.isLoading)
                    Skeletonizer(
                      enabled: servicesState.isLoading,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 14,
                              width: 120,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 45,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (servicesState.error != null)
                    Text("Error: ${servicesState.error}")
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Title
                          Row(
                            children: const [
                              Icon(
                                Icons.design_services,
                                size: 18,
                                color: Colors.primary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Select Service",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // 🎯 Dropdown container
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedServiceId != null
                                    ? Colors.primary
                                    : Colors.grey.shade300,
                                width: selectedServiceId != null ? 1.5 : 1,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedServiceId,
                                hint: const Text("Choose a service"),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),

                                items: servicesState.data!.map((service) {
                                  return DropdownMenuItem(
                                    value: service.id,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          service.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),

                                onChanged: (val) {
                                  setState(() {
                                    selectedServiceId = val;

                                    // reset flow
                                    selectedDate = null;
                                    selectedSlotTime = null;

                                    ref
                                        .read(appointmentStoreProvider.notifier)
                                        .setSlots([]);
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // 💬 Helper / feedback
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: selectedServiceId == null
                                ? Row(
                                    key: const ValueKey("hint"),
                                    children: const [
                                      Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "Select a service to continue",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    key: const ValueKey("selected"),
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Service selected",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.green.shade600,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  if (selectedServiceId == null) ...[
                    const SizedBox(height: 30),

                    const Center(
                      child: Text(
                        "Select a service to continue 👆",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 12),
                    _dropdown("JEWELLERY TYPE"),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Title
                          Row(
                            children: const [
                              Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Colors.primary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Upload Jewellery Photos",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // 📸 Upload Box
                          GestureDetector(
                            onTap: showImageSourcePicker,
                            child: AnimatedContainer(
                              padding: const EdgeInsets.all(16),
                              duration: const Duration(milliseconds: 200),
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: selectedImages.isNotEmpty
                                      ? Colors.primary
                                      : Colors.grey.shade300,
                                  width: selectedImages.isNotEmpty ? 1.5 : 1,
                                ),
                                color: Colors.grey.shade50,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 32,
                                    color: Colors.grey.shade500,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    selectedImages.isEmpty
                                        ? "Tap to upload photos"
                                        : "Add more photos",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 🖼️ IMAGE PREVIEW LIST
                          if (selectedImages.isNotEmpty) ...[
                            const SizedBox(height: 14),

                            SizedBox(
                              height: 110,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedImages.length,
                                itemBuilder: (_, index) {
                                  final image = selectedImages[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        // 🖼️ Image card
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.08),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Image.file(
                                              image,
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        // ❌ Remove button
                                        Positioned(
                                          top: 6,
                                          right: 6,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedImages.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withValues(
                                                  alpha: 0.6,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],

                          const SizedBox(height: 10),

                          // 💬 helper text
                          Row(
                            children: const [
                              Icon(
                                Icons.info_outline,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "Upload clear images for accurate testing",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Title
                          Row(
                            children: const [
                              Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Colors.primary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Select Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dates.length,
                              itemBuilder: (_, index) {
                                final date = dates[index];
                                final isSelected = selectedDay == index;

                                String getWeekday(DateTime d) {
                                  const days = [
                                    "Sun",
                                    "Mon",
                                    "Tue",
                                    "Wed",
                                    "Thu",
                                    "Fri",
                                    "Sat",
                                  ];
                                  return days[d.weekday % 7];
                                }

                                return GestureDetector(
                                  onTap: () {
                                    if (selectedServiceId == null)
                                      return; // safety

                                    setState(() {
                                      selectedDay = index;
                                      selectedDate = date;
                                      selectedSlotTime = null;
                                    });

                                    controller.fetchSlots(
                                      selectedServiceId!,
                                      formatDate(date),
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.primary
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(14),

                                      // ✨ shadow
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: Colors.primary
                                                    .withValues(alpha: 0.25),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.04,
                                                ),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],

                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.primary
                                            : Colors.grey.shade200,
                                        width: isSelected ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // 👇 Weekday
                                        Text(
                                          getWeekday(date),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: isSelected
                                                ? Colors.white70
                                                : Colors.grey,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        // 👇 Day
                                        Text(
                                          "${date.day}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),

                                        const SizedBox(height: 2),

                                        // 👇 Month
                                        Text(
                                          getMonthShort(date.month),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: isSelected
                                                ? Colors.white70
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Title
                          Row(
                            children: const [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: Colors.primary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Pick a Time Slot",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // 🧠 EMPTY STATE
                          Skeletonizer(
                            enabled: state.isLoading, // 👈 slots loading
                            child: store.slots.isEmpty
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 6, // fake skeleton items
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 1.4,
                                        ),
                                    itemBuilder: (_, __) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: store.slots.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 1.4,
                                        ),
                                    itemBuilder: (_, index) {
                                      final slot = store.slots[index];

                                      final rawTime = slot['slotTime'];
                                      final displayTime = formatTime(rawTime);

                                      final booked = slot['bookedCount'];
                                      final capacity = slot['capacity'];
                                      final remaining = capacity - booked;

                                      final isFull = booked >= capacity;
                                      final isAvailable =
                                          slot['isAvailable'] && !isFull;
                                      final isSelected =
                                          selectedSlotTime == rawTime;

                                      // 🎨 color logic
                                      Color statusColor;
                                      if (isFull) {
                                        statusColor = Colors.primary;
                                      } else if (remaining <= 2) {
                                        statusColor = Colors.orange;
                                      } else {
                                        statusColor = Colors.green;
                                      }

                                      return GestureDetector(
                                        onTap: isAvailable
                                            ? () {
                                                setState(
                                                  () => selectedSlotTime =
                                                      rawTime,
                                                );
                                              }
                                            : null,
                                        child: AnimatedScale(
                                          scale: isSelected ? 1.05 : 1,
                                          duration: const Duration(
                                            milliseconds: 150,
                                          ),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: !isAvailable
                                                  ? Colors.grey.shade200
                                                  : isSelected
                                                  ? Colors.primary
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(14),

                                              boxShadow: isSelected
                                                  ? [
                                                      BoxShadow(
                                                        color: Colors.primary
                                                            .withValues(
                                                              alpha: 0.25,
                                                            ),
                                                        blurRadius: 12,
                                                        offset: const Offset(
                                                          0,
                                                          4,
                                                        ),
                                                      ),
                                                    ]
                                                  : [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withValues(
                                                              alpha: 0.04,
                                                            ),
                                                        blurRadius: 6,
                                                        offset: const Offset(
                                                          0,
                                                          2,
                                                        ),
                                                      ),
                                                    ],

                                              border: Border.all(
                                                color: isSelected
                                                    ? Colors.primary
                                                    : Colors.grey.shade200,
                                                width: isSelected ? 1.5 : 1,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // ⏰ Time
                                                Text(
                                                  displayTime,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13,
                                                    color: !isAvailable
                                                        ? Colors.grey
                                                        : isSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),

                                                const SizedBox(height: 6),

                                                // 📊 Capacity status
                                                Text(
                                                  isFull
                                                      ? "Full"
                                                      : remaining == 1
                                                      ? "1 left 🔥"
                                                      : "$remaining left",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: isFull
                                                        ? Colors.primary
                                                        : isSelected
                                                        ? Colors.white70
                                                        : statusColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔥 Title
                          Row(
                            children: const [
                              Icon(
                                Icons.note_alt_outlined,
                                size: 18,
                                color: Colors.primary,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Additional Note",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // ✍️ Text Field
                          TextField(
                            maxLines: 4,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Describe your requirements (optional)",
                              hintStyle: TextStyle(color: Colors.grey.shade500),

                              filled: true,
                              fillColor: Colors.grey.shade50,

                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // 💬 Helper text
                          Row(
                            children: const [
                              Icon(
                                Icons.info_outline,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "Add details like weight, type, or special instructions",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomElevatedButton(
              text: "Confirm Appointment",
              onPressed: () async {
                await controller.createAppointment({
                  "serviceId": selectedServiceId,
                  "jewelleryType": selectedJewelleryType,
                  "appointmentDate": formatDate(selectedDate!),
                  "slotTime": selectedSlotTime,
                  "files": selectedImages.map((e) => e.path).toList(),
                });

                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Appointment Booked ✅")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown(String hint) {
    final jewelleryTypes = [
      "Gold Ring",
      "Gold Necklace",
      "Gold Chain",
      "Gold Bracelet",
      "Gold Bangle",
      "Gold Earrings",
      "Silver Ring",
      "Silver Chain",
      "Silver Bracelet",
      "Coins / Bars",
      "Custom Jewellery",
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Title
          Row(
            children: const [
              Icon(Icons.diamond, size: 18, color: Colors.primary),
              SizedBox(width: 6),
              Text(
                "Jewellery Type",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🎯 Dropdown
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedJewelleryType != null
                    ? Colors.primary
                    : Colors.grey.shade300,
                width: selectedJewelleryType != null ? 1.5 : 1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedJewelleryType,
                hint: Text(hint, style: const TextStyle(fontSize: 15)),
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down),

                items: jewelleryTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          type,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedJewelleryType = value;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 💬 Feedback
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: selectedJewelleryType == null
                ? Row(
                    key: const ValueKey("hint"),
                    children: const [
                      Icon(Icons.info_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Select jewellery type",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  )
                : Row(
                    key: const ValueKey("selected"),
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Selected: ",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green.shade600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          selectedJewelleryType!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
