import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../controllers/note controller/note_controller.dart';
import '../../../utils/constants/responsive_sizes.dart';
import '../create note/create_note.dart';
import '../navigation drawer/navigation_drawer.dart';
import 'components/appbar.dart';
import 'components/overview.dart';
import 'components/recent_notes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This function will be called when the refresh animation is triggered
  Future<void> _refreshNotes() async {
    final noteController = Get.find<NoteController>();
    // You can trigger the fetching of new notes here
    await noteController.fetchAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: RefreshIndicator(
        onRefresh: _refreshNotes,
        color: AppColors.primaryColor,
        backgroundColor: AppColors.backgroundColor,
        strokeWidth: 3.0,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Column(
              children: [
                50.height,
                HomeAppBar(
                  onMenuPressed: () {
                    drawerController.toggle!();
                  },
                ),
                25.height,
                const HomeOverview(),
                20.height,
                const HomeRecentNotes(),
                25.height,
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => const CreateNoteSCreen());
        },
        child: Container(
          height: ResponsiveSize.h * 55,
          width: ResponsiveSize.w * 55,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Center(
            child: Icon(
              Icons.add_rounded,
              size: ResponsiveSize.h * 32,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
