import 'package:flutter/material.dart' hide Badge;
import 'package:badges/badges.dart';

class TopBarButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPress;
  final bool showRight;
  final bool showLeft;
  final bool showBadge;
  const TopBarButton(
      {super.key,
      required this.icon,
      required this.onPress,
      required this.name,
      this.showLeft = true,
      this.showBadge = false,
      this.showRight = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: createBorder()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showBadge
                  ? Badge(
                      badgeContent: const Text('!'),
                      child: IconButton(
                          icon: Icon(
                            icon,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: onPress),
                    )
                  : IconButton(
                      icon: Icon(
                        icon,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: onPress),
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }

  Border createBorder() {
    if (showLeft && showRight) {
      return const Border(
        left: BorderSide(width: 0.5, color: Colors.white),
        right: BorderSide(width: 0.5, color: Colors.white),
      );
    } else if (showLeft) {
      return const Border(
        left: BorderSide(width: 0.5, color: Colors.white),
      );
    } else if (showRight) {
      return const Border(
        right: BorderSide(width: 0.5, color: Colors.white),
      );
    }
    return const Border();
  }
}
