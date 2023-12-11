import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        if (value == 0) context.router.pushNamed('/');
        //if (value == 1) ;
        if (value == 2) context.router.pushNamed('/favorites');
      },
      type: BottomNavigationBarType.fixed,
      iconSize: 23,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/cvg_icons/estate.svg',
            semanticsLabel: 'home',
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/cvg_icons/apps.svg',
            semanticsLabel: 'category',
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/cvg_icons/bookmark.svg',
            semanticsLabel: 'bookmark',
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/cvg_icons/user.svg',
            semanticsLabel: 'account',
          ),
          label: '',
        ),
      ],
    );
  }
}
