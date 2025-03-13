import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_sample/constants/AppPermissions.dart';
import 'package:flutter_ui_sample/constants/AppText.dart';
import 'package:flutter_ui_sample/constants/app_fonts.dart';
import 'package:flutter_ui_sample/domain/models/FileUploadResponseModel.dart';
import 'package:flutter_ui_sample/domain/models/FirebaseRemoteConfigs.dart';
import 'package:flutter_ui_sample/domain/repository_impl/FileUploadRepositoryImpl.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_event.dart';
import 'package:flutter_ui_sample/presentation/blocs/api_state.dart';
import 'package:flutter_ui_sample/presentation/screens/profile/user_profile_bloc.dart';
import 'package:flutter_ui_sample/presentation/widgets/CachedImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constants/AppSpacing.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/my_text.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isSwitched = false;
  late UserProfileBloc userProfileBloc;

  @override
  Widget build(BuildContext context) {
    userProfileBloc = UserProfileBloc(FileUploadRepositoryImpl());
    return BlocProvider<UserProfileBloc>(
      create: (context) => userProfileBloc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserProfileWidget(null),
          SizedBox(height: 50),
          _buildLanguageChangeWidget(),
        ],
      ),
    );
  }

  Widget _buildLanguageChangeWidget() {
    final String local = context.locale.languageCode;
    if (local == 'ar') {
      isSwitched = true;
    } else {
      isSwitched = false;
    }
    return Padding(
      padding: EdgeInsets.all(AppValues.appValue_10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(AppValues.appValue_10),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor,
                  blurRadius: 13,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: AppValues.appValue_10,
                right: AppValues.appValue_10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    AppText.changeLanguage,
                    style: TextStyle(fontSize: FontSizes.bodyNormalFont),
                  ),
                  Row(
                    children: [
                      MyText(AppText.english),
                      SizedBox(width: AppValues.appValue_10),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) async {
                          if (value == true) {
                            await context.setLocale(Locale('ar'));
                          } else {
                            await context.setLocale(Locale('en'));
                          }
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: AppColors.grey,
                      ),
                      SizedBox(width: AppValues.appValue_10),
                      MyText(AppText.arabic),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileWidget(String? imageUrl) {
    return BlocBuilder<UserProfileBloc, GenericState>(
      builder: (context, state) {
        if (state is LoadingState<FileUploadResponseModel>) {
          return SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(color: Colors.black87),
            ),
          );
        } else if (state is SuccessState<FileUploadResponseModel>) {
          return _profileImageView(state.data.location);
        } else if (state is ErrorState<FileUploadResponseModel>) {
          return _profileImageView(null);
        }
        return _profileImageView(null);
      },
    );
  }

  Future<void> _handlePermissionAndOpenGallery() async {
    final listPermissions = AppPermissions.getPhotosPermissionList();
    final statuses = await AppPermissions.requestPermissions(listPermissions);
    if (statuses[Permission.storage]!.isGranted ||
        statuses[Permission.photos]!.isGranted) {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      userProfileBloc.add(
        FetchDataEvent<FileUploadResponseModel>(
          endpoint: FirebaseRemoteConfigs.instance.uploadFilePath!,
          params: {"file": File(image!.path)},
        ),
      );
    } else if (statuses[Permission.photos]!.isPermanentlyDenied ||
        statuses[Permission.storage]!.isPermanentlyDenied) {
      openAppSettings();
    } else {
      print("Permission denied");
    }
  }

  Widget _profileImageView(String? imageUrl) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: AppColors.whiteColor,
            ),
            child:
                imageUrl != null
                    ? CachedImage(
                      fit: BoxFit.fill,
                      imageUrl: imageUrl,
                      topLeftRadius: 100,
                      topRightRadius: 100,
                      bottomLeftRadius: 100,
                      bottomRightRadius: 100,
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        "lib/assets/images/designer.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: GestureDetector(
              onTap: () {
                _handlePermissionAndOpenGallery();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: AppColors.greyColor,
                ),
                child: Center(child: Icon(Icons.edit, size: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
