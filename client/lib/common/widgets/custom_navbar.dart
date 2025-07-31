import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  OverlayEntry? _overlayEntry;
  int? _hoveredIndex;

  final List<IconData> items = [
    Icons.home_work_rounded,
    Icons.grid_view_rounded,
    Icons.chat_rounded,
    Icons.access_time_filled_rounded,
    Icons.person_rounded,
  ];

  final List<Map<String, dynamic>> subItems = [
    {'icon': Icons.bookmark_add_rounded, 'label': 'Books', 'route': '/book_organizer'},
    {'icon': Icons.edit_off_rounded, 'label': 'Projects', 'route': '/project_organizer'},
    {'icon': Icons.video_collection_rounded, 'label': 'Videos', 'route': '/video_organizer'},
  ];

void _showSubItemsOverlay(BuildContext context, Offset position) {
  _removeOverlay();

  _overlayEntry = OverlayEntry(
    builder: (context) {
      return Stack(
        children: [

          Positioned.fill(
            child: GestureDetector(
              onTap: _removeOverlay,
              behavior: HitTestBehavior.translucent,
              child: const SizedBox.expand(),
            ),
          ),

          Positioned(
            left: position.dx - 60,
            bottom: 100,
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(subItems.length, (i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(subItems[i]['route']);
                      _removeOverlay();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 120,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            subItems[i]['icon'],
                            size: 22,
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            subItems[i]['label'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.surfaceContainerHigh,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      );
    },
  );

  Overlay.of(context).insert(_overlayEntry!);
}



  void _removeOverlay() {
    _hoveredIndex = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        border: Border(
          top: BorderSide(color: Colors.grey.shade400, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final isSelected = index == widget.currentIndex;

          return GestureDetector(
            onTapDown: (details) {
              if (index == 1) {
                _showSubItemsOverlay(context, details.globalPosition);
              } 
              else {
                widget.onTap(index);
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  items[index],
                  size: 29,
                  color: isSelected
                      ? Theme.of(context).colorScheme.surfaceContainerHigh
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 6,
                  height: 6,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isSelected ? 1 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHigh,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
