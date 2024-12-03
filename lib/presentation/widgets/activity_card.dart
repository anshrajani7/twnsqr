import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../models/activity.dart';
import '../../utils/contrast/image_strings.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final bool isCompact;

  const ActivityCard({super.key, required this.activity, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 7,
      color: isDark ? const Color(0xff0e0e0e) : Colors.white,
      shadowColor: isDark ? Colors.black38 : Colors.grey[200]!.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),side:isDark? const BorderSide(color: Color(0xff6c757d)):BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              DateFormat('HH:mm').format(activity.time),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${activity.duration} min)',
                              style: const TextStyle(color: Color(0xffadb5bd), fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          activity.title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    SvgPicture.asset(
                      ImageStrings.mapPin,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      activity.location,
                      style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3.5),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : const Color(0xffe9ecef),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageStrings.user,
                            width: 16,
                            color: const Color(0xffadb5bd),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${activity.spotsLeft} spots left',
                            style: const TextStyle(
                              color: Color(0xffadb5bd),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 7),
                    _buildTag(activity.intensity, isDark),
                    if (activity.hasChildcare) ...[
                      const SizedBox(width: 7),
                      _buildTag('childcare', isDark, isChildcare: true),
                    ],
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${activity.price.toStringAsFixed(0)}€',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                _buildActionButton(isDark),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, bool isDark, {bool isChildcare = false}) {
    Color bgColor;
    Color textColor;

    switch (text.toLowerCase()) {
      case 'light':
        bgColor = isDark ? const Color(0xFF65b5db) : const Color(0xFFd5f1ff);
        textColor =isDark ? Colors.white:const Color(0xFF65b5db);
      case 'medium':
        bgColor = isDark ? const Color(0xFFc9a4f2) : const Color(0xFFf3e8ff);
        textColor =isDark ? Colors.white: const Color(0xFFc9a4f2);
      case 'high':
        bgColor = isDark ? const Color(0xFFdc974f) : const Color(0xFFffead1);
        textColor =isDark ? Colors.white: const Color(0xFFdc974f);
      case 'childcare':
        bgColor = isDark ? const Color(0xFF8ab58a) : const Color(0xFFd8f7df);
        textColor =isDark ? Colors.white: const Color(0xFF8ab58a);
      default:
        bgColor = isDark ? Colors.grey[800]! : const Color(0xffe9ecef);
        textColor =isDark ? Colors.white: const Color(0xffadb5bd);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton(bool isDark) {
    final bool isSoldOut = activity.spotsLeft == 0;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: isSoldOut ? null : () {},
      child: Container(
        width: isSoldOut ? 77 : 74,
        height: 44,
        decoration: BoxDecoration(
          color: isSoldOut ? const Color(0xffadb5bd) : !isDark? Colors.black: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          isSoldOut ? 'Sold out' : 'Join',
          style: TextStyle(
            color: isDark? Colors.black: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
