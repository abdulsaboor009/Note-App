import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notebox/views/screens/starred%20notes/starred_notes.dart';
import 'package:notebox/views/screens/trash%20notes/trash_notes.dart';
import 'package:notebox/views/widgets/custom_btn.dart';
import 'package:notebox/views/widgets/action_diaglog.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../data/authentication repository/authentication_repository.dart';
import '../../../models/navigation_drawer_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_font_sizes.dart';
import '../../../utils/constants/app_font_weights.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/responsive_sizes.dart';
import '../../widgets/custom_text.dart';
import '../all notes/all_notes.dart';
import '../home/home.dart';

final ZoomDrawerController drawerController = ZoomDrawerController();

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  List<SideMenuModel> sideMenuItems = [
    SideMenuModel(image: AppAssets.notes, title: 'All Notes'),
    SideMenuModel(image: AppAssets.star, title: 'Starred'),
    SideMenuModel(image: AppAssets.trash, title: 'Trash'),
  ];
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: drawerController,
      angle: 0.0,
      borderRadius: 30,
      closeCurve: Curves.linear,
      showShadow: true,
      mainScreenScale: 0.2,
      openCurve: Curves.linear,
      slideWidth: MediaQuery.of(context).size.width * 0.64,
      duration: const Duration(milliseconds: 300),
      mainScreenTapClose: true,
      shadowLayer1Color: Colors.white.withOpacity(0.05),
      shadowLayer2Color: Colors.white.withOpacity(0.1),
      menuBackgroundColor: AppColors.backgroundColor,
      mainScreen: const HomeScreen(),
      menuScreen: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SizedBox(
            child: Column(
              children: [
                45.height,
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: LottieBuilder.asset(AppAssets.logo2,
                          repeat: true,
                          animate: true,
                          height: ResponsiveSize.h * 70),
                    ),
                    TextWidget(
                      color: AppColors.titleColor,
                      fontSize:
                          AppFontSize.screenTitle - ResponsiveSize.setSp(2),
                      text: 'NoteBox',
                      letterSpacing: 2,
                      fontWeight: AppFontweight.bold.font,
                    ),
                  ],
                ),
                20.height,
                Expanded(
                    child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: ResponsiveSize.w * 5),
                          child: Column(
                            children: [
                              ListView.builder(
                                itemCount: sideMenuItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                clipBehavior: Clip.none,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: index == 0
                                            ? 0
                                            : ResponsiveSize.h * 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(40),
                                      splashColor: AppColors.primaryColor
                                          .withOpacity(0.3),
                                      highlightColor: AppColors.primaryColor
                                          .withOpacity(0.3),
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(
                                                () => const AllNotesScreen());
                                            break;
                                          case 1:
                                            Get.to(() =>
                                                const StarredNotesScreen());
                                            break;
                                          case 2:
                                            Get.to(
                                                () => const TrashNotesScreen());
                                            break;
                                          default:
                                        }
                                      },
                                      child: SizedBox(
                                        height: ResponsiveSize.h * 50,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenPadding),
                                          child: Row(
                                            children: [
                                              Transform.scale(
                                                scale: 1.1,
                                                child: Image.asset(
                                                  sideMenuItems[index].image,
                                                  height: ResponsiveSize.h * 27,
                                                  width: ResponsiveSize.w * 24,
                                                ),
                                              ),
                                              10.width,
                                              TextWidget(
                                                color: AppColors.titleColor,
                                                fontSize: AppFontSize.title -
                                                    ResponsiveSize.setSp(1),
                                                text:
                                                    sideMenuItems[index].title,
                                                fontWeight:
                                                    AppFontweight.medium.font,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                CustomButton(
                  centerContent: 'Logout',
                  icon: Padding(
                    padding: EdgeInsets.only(right: ResponsiveSize.w * 5),
                    child: Image.asset(
                      AppAssets.logout,
                      height: ResponsiveSize.h * 25,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    actionDiaglog(context, onSubmit: () {
                      AuthenticationRepository.instance.logout();
                    },
                        title: "Logout",
                        subTitle: "Do you want to logout?",
                        diaglogImage: AppAssets.logoutIcon2);
                  },
                  buttonColor: const Color(0xffDA4A54),
                  height: ResponsiveSize.h * 43,
                  width: ResponsiveSize.w * 150,
                  fontSize: AppFontSize.discription,
                  textColor: AppColors.titleColor,
                ),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
