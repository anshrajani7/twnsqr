import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/activity_controller.dart';
import '../../utils/contrast/image_strings.dart';
import '../widgets/activity_card.dart';

class MobileLayout extends StatefulWidget {
  final ActivityController controller;

  const MobileLayout({Key? key, required this.controller}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildSideNav(),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader()
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: -0.2, duration: 600.ms),
                  _buildGoalCard()
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms),
                  _buildSearchBar()
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(begin: 0.2, duration: 600.ms),
                  _buildCategories()
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .slideX(begin: -0.2, duration: 600.ms),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Obx(() {
                      if (widget.controller.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: CircularProgressIndicator()
                                .animate()
                                .fadeIn(duration: 300.ms),
                          ),
                        );
                      }

                      if (widget.controller.errorMessage.isNotEmpty) {
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
                                  widget.controller.errorMessage.value,
                                  style: TextStyle(color: Colors.grey[600]),
                                ).animate().fadeIn(),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: widget.controller.retryLoading,
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
                                widget.controller.filteredActivities.length,
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
                                          activity: widget.controller
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
          )
        ]),
      ),
      bottomNavigationBar: _buildBottomNav()
          .animate()
          .fadeIn(delay: 1200.ms, duration: 600.ms)
          .slideY(begin: 1, duration: 600.ms),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('E, MMM d').format(DateTime.now()),
                style: const TextStyle(
                    color: Color(0xffADB5BD),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'This week in Estepona',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(ImageStrings.bell,color: Theme.of(context).iconTheme.color,),
              const SizedBox(width: 10),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()=> _scaffoldKey.currentState?.openDrawer(),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person_outline,
                        size: 20, color: Colors.grey[700]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffc1ebff),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "You're close to your goal!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Join more sport activities to collect more points',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 82,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'Join now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 82,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          'My profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 68,
            height: 68,
            child: Stack(
              children: [
                SizedBox(
                  width: 68,
                  height: 68,
                  child: CircularProgressIndicator(
                    value: 0.60,
                    strokeWidth: 6.5,
                    strokeAlign: 0,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.white,
                    color: Color(0xff6abef6),
                  ),
                ),
                Center(
                  child: Text(
                    '27',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    final searchController = TextEditingController();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff000000).withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(3, 3))
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'What do you feel like doing?',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
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
          )
        ],
      ),
    );
  }

  Widget _buildSideNav() {
    return Container(
      width: 300,
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TWN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const Text(
                  'SQR',
                  style: TextStyle(
                    color: Color(0xff35baf8),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ..._buildNavItems()
              .animate(interval: 100.ms)
              .fadeIn()
              .slideX(begin: -0.2),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xff35baf8),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 16),
                  SvgPicture.asset(
                    ImageStrings.plusIcon,
                    width: 30,
                  ),
                  const SizedBox(width: 25),
                  const Text('Create',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
          ),
          const SizedBox(height: 16),
          _buildProfileSection()
              .animate()
              .fadeIn(delay: 700.ms)
              .slideY(begin: 0.2),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems() {
    final items = [
      ('Activities', ImageStrings.calendar, true),
      ('Locations', ImageStrings.map, false),
      ('Services', ImageStrings.star, false),
      ('Communities', ImageStrings.users, false),
      ('Notifications', ImageStrings.bell, false),
    ];

    return items
        .map((item) => _buildNavItem(item.$1, item.$2, item.$3))
        .toList();
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey[800],
          child:
              const Icon(Icons.person_outline, size: 20, color: Colors.white),
        ),
        title: const Text(
          '  Profile',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.more_vert, color: Colors.grey),
      ),
    );
  }

  Widget _buildNavItem(String title, String icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        title: Text(
          "  $title",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        selected: isSelected,
        selectedTileColor: Colors.blue.withOpacity(0.2),
        onTap: () {},
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
                        widget.controller.selectedCategory.value == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () => widget.controller.setCategory(category),
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
                              fontSize: 14,
                              color: Colors.black,
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

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Brightness.dark == Theme.of(context).brightness ? Colors.black : Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(ImageStrings.calendar, 'Activities', true),
          _buildBottomNavItem(ImageStrings.map, 'Map', false),
          _buildBottomNavItem(ImageStrings.plus, 'Plus', false),
          _buildBottomNavItem(ImageStrings.users, 'Social', false),
          _buildBottomNavItem(ImageStrings.star, 'Services', false),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String icon, String label, bool isSelected) {
    return SvgPicture.asset(
      icon,
      color: label == 'Plus'? null:Theme.of(context).iconTheme.color,
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 8.0;
    const dashSpace = 7.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
