import 'dart:isolate';

import 'package:ebg/constants/app_constants.dart';
import 'package:ebg/constants/app_images.dart';
import 'package:ebg/constants/styles/app_styles.dart';
import 'package:ebg/ui/view_fichier/view_fichier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../widgets/button_gradient.dart';

class ViewFileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewFileScreenState();
}

class _ViewFileScreenState extends State<ViewFileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewFileBloc = Modular.get<ViewFileBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              text: 'Fiche ',
              style: AppStyles.subTitle,
              children: <TextSpan>[
                TextSpan(text: 'client', style: AppStyles.bodoniItalic),
              ],
            ),
          ),
          const SizedBox(height: 70),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              viewFileBloc.fiche.nomPrenom! +
                  ", " +
                  viewFileBloc.fiche.poste! +
                  ", " +
                  viewFileBloc.fiche.entreprise!,
              style: AppStyles.listTileTitle,
              overflow: TextOverflow.clip,
              maxLines: 100),
          const SizedBox(height: 30),
          Text(viewFileBloc.fiche.description!,
              style: AppStyles.listTileTitle,
              overflow: TextOverflow.clip,
              maxLines: 100),
          const SizedBox(height: 30),
          _buildTypesBesoins(),
          const SizedBox(height: 30),
          _buildCompetence(),
          const SizedBox(height: 30),
          _buildButtons(),
          const SizedBox(height: 30),
          _buildBackButton(),
          const SizedBox(height: 40)
        ]);
  }

  Widget _buildTypesBesoins() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Type de besoin :",
            style: AppStyles.listTileTitle,
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(height: 20),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            verticalDirection: VerticalDirection.down,
            spacing: 20.0,
            runSpacing: 10.0,
            direction: Axis.horizontal,
            children: [
              for (var items in viewFileBloc.fiche.getListTypesBesoins())
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: buttonGradient(),
                  ),
                  child: Text(
                    items.trim(),
                    style: AppStyles.listTileTitle,
                  ),
                ),
            ],
          ),
        ]);
  }

  Widget _buildCompetence() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Compétences :",
            style: AppStyles.listTileTitle,
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(height: 20),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            verticalDirection: VerticalDirection.down,
            spacing: 20.0,
            runSpacing: 10.0,
            direction: Axis.horizontal,
            children: [
              for (var items in viewFileBloc.fiche.getListCompentences())
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    gradient: buttonGradient(),
                  ),
                  child: Text(
                    items.trim(),
                    style: AppStyles.listTileTitle,
                  ),
                ),
            ],
          ),
        ]);
  }

  _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          splashColor: AppColors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () async {
            viewFileBloc.downloadPdf();
          },
          child: Image.asset(
            AppImages.btnTelecharger,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        SizedBox(
          width: 300,
          child: InkWell(
            splashColor: AppColors.white.withOpacity(0.2),
            highlightColor: Colors.transparent,
            onTap: () {
              viewFileBloc.partagerPdf();
            },
            child: Image.asset(
              AppImages.btnEnvoyer,
            ),
          ),
        ),
      ],
    );
  }

  _buildBackButton() {
    return Center(
      child: InkWell(
        splashColor: AppColors.white.withOpacity(0.2),
        highlightColor: Colors.transparent,
        onTap: () {
          Modular.to.pop();
        },
        child: Image.asset(
          AppImages.btnArriere,
        ),
      ),
    );
  }
}
