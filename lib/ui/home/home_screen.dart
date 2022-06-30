import 'package:ebg/constants/app_constants.dart';
import 'package:ebg/constants/app_images.dart';
import 'package:ebg/constants/routes.dart';
import 'package:ebg/constants/styles/app_styles.dart';
import 'package:ebg/models/fichesModel.dart';
import 'package:ebg/ui/view_fichier/view_fichier_bloc.dart';
import 'package:ebg/widgets/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import 'myhome_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeBloc = Modular.get<HomeBloc>();
  final viewFileBloc = Modular.get<ViewFileBloc>();

  @override
  void initState() {
    homeBloc.ref.child('files').onValue.listen((event) {
      var snapshot = event.snapshot;
      homeBloc.refreshData(snapshot);
    });
    homeBloc.listChangesNotifier.listen((value) {
      setState(() {});
    });
    homeBloc.getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppConstants.paddingVertical,
              horizontal: MediaQuery.of(context).size.width * 0.12),
          child: _buildContent(),
        ),
        //LoadingIndicator(loading: _bloc.loading),
        //NetworkErrorMessages(error: _bloc.error),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImages.logoNexton, height: 50),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: 'Les fiches ',
                style: AppStyles.subTitle,
                children: <TextSpan>[
                  TextSpan(text: 'existantes', style: AppStyles.bodoniItalic),
                ],
              ),
            ),
            InkWell(
              splashColor: AppColors.white.withOpacity(0.2),
              highlightColor: Colors.transparent,
              onTap: () => homeBloc.exportCSV(), //do something,
              child: const Text('Export to Excel',
                  style: AppStyles.subTitle,
                  overflow: TextOverflow.clip,
                  maxLines: 2),
            ),
            InkWell(
              splashColor: AppColors.white.withOpacity(0.2),
              highlightColor: Colors.transparent,
              onTap: () => Modular.to.pushNamed(Routes.newFile), //do something,
              child: Image.asset(
                AppImages.nouvelleFiche,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildList()
      ],
    );
  }

  Widget _buildList() {
    return Expanded(
      child: homeBloc.listFiches!.isEmpty
          ? _buildEmptyList()
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                FichesModel item = homeBloc.listFiches![index];
                return InkWell(
                  splashColor: AppColors.white.withOpacity(0.2),
                  hoverColor: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom:
                            index == homeBloc.listFiches!.length - 1 ? 0 : 15),
                    child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.list_background,
                            border: Border.all(color: AppColors.border),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                      item.nomPrenom! + ", " + item.poste!,
                                      style: AppStyles.listTileTitle,
                                      overflow: TextOverflow.clip,
                                      maxLines: 3),
                                ),
                                subtitle: Text(item.entreprise!.toUpperCase(),
                                    style: AppStyles.listTileSubTitle,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3),
                              ),
                            ),
                            _buildTypeBesoins(item.typesBesoins!)
                          ],
                        )),
                  ),
                  onTap: () {
                    Modular.to.pushNamed(Routes.viewFile);
                    viewFileBloc.fiche = item;
                  },
                );
              },
              itemCount: homeBloc.listFiches!.length,
            ),
    );
  }

  Widget _buildEmptyList() {
    return const Center(
        child: Text("Créer votre première fiche pour la visualiser ici ",
            style: AppStyles.labelTextField,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            maxLines: 5));
  }

  Widget _buildTypeBesoins(String typebesoins) {
    List<String> listTypesBesoins = typebesoins.split(',');
    return _buildTypeBesoinsItem(listTypesBesoins);
  }

  Widget _buildTypeBesoinsItem(List<String> type) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
              shape: const StadiumBorder(), gradient: buttonGradient()),
          child: Text(
            type[0],
            style: AppStyles.listTileTitle,
          ),
        ),
        const SizedBox(width: 10),
        if (type.length > 1)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
                shape: const StadiumBorder(), gradient: buttonGradient()),
            child: Text(
              type[1],
              style: AppStyles.listTileTitle,
            ),
          )
      ],
    );
  }
}
