import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisata_app/common/constants.dart';
import 'package:wisata_app/screens/main_layout/account_screen.dart';
import 'package:wisata_app/screens/main_layout/dashboard_screen.dart';

enum MenuState { home, profile }

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  color: MenuState.home == selectedMenu
                      ? primaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  if(ModalRoute.of(context)?.settings.name != '/dashboard'){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                            settings: const RouteSettings(name: '/dashboard')
                        )
                    );
                  }
                },
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/account.svg",
                    color: MenuState.profile == selectedMenu
                        ? primaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    if(ModalRoute.of(context)?.settings.name != '/account'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountScreen(),
                            settings: const RouteSettings(name: '/account')
                        ),
                      );
                    }
                  }),
            ],
          )),
    );
  }
}
