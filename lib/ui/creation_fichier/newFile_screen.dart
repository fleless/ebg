import 'package:ebg/constants/app_constants.dart';
import 'package:ebg/constants/app_images.dart';
import 'package:ebg/constants/styles/app_styles.dart';
import 'package:ebg/ui/creation_fichier/newFile_bloc.dart';
import 'package:ebg/ui/creation_fichier/steps/first_step.dart';
import 'package:ebg/ui/creation_fichier/steps/second_step.dart';
import 'package:ebg/ui/creation_fichier/steps/third_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';

class NewFileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewFileScreenState();
}

class _NewFileScreenState extends State<NewFileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final newFileBloc = Modular.get<NewFileBloc>();

  @override
  void initState() {
    newFileBloc.resetFile();
    newFileBloc.stepChangesNotifier.listen((value) {
      if (mounted) setState(() {});
    });
    newFileBloc.changeStep(1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    newFileBloc.step == 1
        ? Modular.to.pop()
        : newFileBloc.changeStep(newFileBloc.step - 1);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.appBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppConstants.paddingVertical,
                    horizontal: MediaQuery.of(context).size.width * 0.2),
                child: _buildContent(),
              ),
            ),
            //LoadingIndicator(loading: _bloc.loading),
            //NetworkErrorMessages(error: _bloc.error),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.logoNexton, height: 50),
          const SizedBox(height: 70),
          RichText(
            text: const TextSpan(
              text: 'Nouvelle ',
              style: AppStyles.subTitle,
              children: <TextSpan>[
                TextSpan(text: 'Fiche', style: AppStyles.bodoniItalic),
              ],
            ),
          ),
          const SizedBox(height: 70),
          newFileBloc.step == 1
              ? FirstStepScreen()
              : newFileBloc.step == 2
                  ? SecondStepScreen()
                  : ThirdStepScreen(),
        ],
      ),
    );
  }
}
