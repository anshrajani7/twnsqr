import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/activity_controller.dart';
import '../../utils/contrast/image_strings.dart';
import '../widgets/activity_card.dart';
import 'mobile_layout.dart';

class TabletLayout extends StatelessWidget {
  final ActivityController controller;

  const TabletLayout({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 80,
            color: Colors.black,
            child: _buildSideNav(),
          ),
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader()
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideY(begin: -0.2, duration: 600.ms),
                      const SizedBox(height: 16),
                      _buildSearchBar()
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 600.ms)
                          .slideY(begin: 0.2, duration: 600.ms),
                      const SizedBox(height: 10),
                      _buildCategories()
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 600.ms)
                          .slideX(begin: 0.2, duration: 600.ms),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: CircularProgressIndicator()
                                    .animate()
                                    .fadeIn(duration: 300.ms),
                              ),
                            );
                          }

                          if (controller.errorMessage.isNotEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline, size: 48, color: Colors.grey)
                                        .animate()
                                        .scale(),
                                    const SizedBox(height: 16),
                                    Text(
                                      controller.errorMessage.value,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ).animate().fadeIn(),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: controller.retryLoading,
                                      child: Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          // Activities list
                          return Stack(
                            children: [
                              Positioned(
                                left: 27,
                                top: 25, // Adjust to align with dot
                                bottom: 5,
                                child: CustomPaint(
                                  painter: DottedLinePainter(),
                                  size: const Size(2, double.infinity),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 19, top: 25),
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFF2AC),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .scale(delay: 800.ms, duration: 400.ms)
                                      .fadeIn(delay: 800.ms, duration: 400.ms),
                                  Expanded(
                                    child: _buildDateSection()
                                        .animate()
                                        .fadeIn(delay: 800.ms, duration: 600.ms)
                                        .slideX(begin: 0.2, duration: 600.ms),
                                  ),
                                ],
                              ),
                              // Activities list
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Obx(
                                      ()=> ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 16),
                                    itemCount:
                                    controller.filteredActivities.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Positioned(
                                            left: -25,
                                            top: 24,
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                shape: BoxShape.circle,
                                              ),
                                            )
                                                .animate()
                                                .scale(
                                              delay:
                                              (1000 + (index * 100)).ms,
                                              duration: 400.ms,
                                            )
                                                .fadeIn(
                                              delay:
                                              (1000 + (index * 100)).ms,
                                              duration: 400.ms,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(bottom: 12),
                                            child: ActivityCard(
                                              activity: controller
                                                  .filteredActivities[index],
                                            )
                                                .animate()
                                                .fadeIn(
                                              delay:
                                              (1000 + (index * 100)).ms,
                                              duration: 600.ms,
                                            )
                                                .slideX(
                                              begin: 0.2,
                                              delay:
                                              (1000 + (index * 100)).ms,
                                              duration: 600.ms,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                'Today',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '/ tuesday',
                style: TextStyle(
                  color: Color(0xff9e9e9e),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'What do you feel like doing?',
                hintStyle: TextStyle(
                  color: Color(0xffadb5bd),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                // Handle search
              },
            ),
          ),
          SvgPicture.asset(
            ImageStrings.search,
            color: const Color(0xffadb5bd),
          ),
        ],
      ),
    );
  }

  Widget _buildSideNav() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'T',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const Text(
                  'S',
                  style: TextStyle(
                    color: Color(0xff35baf8),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
              ],
            ),
            const SizedBox(height: 40),
            _buildNavItem(ImageStrings.calendar, true),
            _buildNavItem(ImageStrings.map, false),
            _buildNavItem(ImageStrings.star, false),
            _buildNavItem(ImageStrings.users, false),
            _buildNavItem(ImageStrings.bell, false),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[800],
            child:
                const Icon(Icons.person_outline, size: 20, color: Colors.white),
          ),
        ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),
      ],
    );
  }

  Widget _buildNavItem(String icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xff76c8ff) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SvgPicture.asset(
        icon,
        color: isSelected ? Colors.black : Colors.grey,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('E, MMM d').format(DateTime.now()),
            style: const TextStyle(
              color: Color(0xffADB5BD),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This week in Estepona',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      'All',
      'Sports',
      'Food',
      'Kids',
      'Creative',
      'Popular',
      'Calm'
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 18),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xffeee1f5),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                ImageStrings.sliders,
                width: 16,
                height: 16,
              ),
            ),
            SizedBox(
              height: 32,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: categories.map((category) {
                  return Obx(() {
                    final isSelected =
                        controller.selectedCategory.value == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () => controller.setCategory(category),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xffbaa1c8)
                                : const Color(0xffeee1f5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                            .animate(
                              target: isSelected ? 1 : 0,
                            )
                            .scale(
                              begin: const Offset(0.95, 1),
                              end: const Offset(1, 1),
                              duration: 200.ms,
                            )
                            .shimmer(
                              duration: 600.ms,
                              color: isSelected
                                  ? Colors.white24
                                  : Colors.transparent,
                            ),
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
