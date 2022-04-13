import 'package:ebg/constants/app_images.dart';
import 'package:ebg/constants/routes.dart';
import 'package:ebg/constants/styles/app_styles.dart';
import 'package:ebg/models/enum/competences_enum.dart';
import 'package:ebg/models/enum/types_besoins_enum.dart';
import 'package:ebg/ui/creation_fichier/newFile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/button_gradient.dart';

class ThirdStepScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThirdStepScreenState();
}

class _ThirdStepScreenState extends State<ThirdStepScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final newFileBloc = Modular.get<NewFileBloc>();

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
    return _buildContent();
  }

  Widget _buildContent() {
    return Center(
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildFirstLine(),
            const SizedBox(height: 40),
            _buildSecondLine(),
            const SizedBox(height: 40),
            _buildTypesBesoins(),
            const SizedBox(height: 40),
            _buildCompetence(),
            const SizedBox(height: 50),
            _buildButton()
          ]),
    );
  }

  Widget _buildFirstLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
              newFileBloc.newFiche.nomPrenom! +
                  ", " +
                  newFileBloc.newFiche.poste! +
                  ", " +
                  newFileBloc.newFiche.entreprise!,
              style: AppStyles.listTileTitle,
              overflow: TextOverflow.clip,
              maxLines: 1),
        ),
        const SizedBox(width: 5),
        InkWell(
          splashColor: AppColors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            newFileBloc.changeStep(1);
          },
          child: const Text("Modifier",
              style: AppStyles.modifierStyle,
              overflow: TextOverflow.clip,
              maxLines: 100),
        ),
      ],
    );
  }

  Widget _buildSecondLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(newFileBloc.newFiche.description!,
              style: AppStyles.listTileTitle,
              overflow: TextOverflow.clip,
              maxLines: 100),
        ),
        const SizedBox(width: 5),
        InkWell(
          splashColor: AppColors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            newFileBloc.changeStep(2);
          },
          child: const Text("Modifier",
              style: AppStyles.modifierStyle,
              overflow: TextOverflow.clip,
              maxLines: 1),
        ),
      ],
    );
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
              for (var items in listTypeBesoins)
                Container(
                  decoration: newFileBloc.listBesoins.contains(items)
                      ? ShapeDecoration(
                          shape: const StadiumBorder(),
                          gradient: buttonGradient(),
                        )
                      : const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppColors.white,
                        ),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    child: Text(
                      items,
                      style: newFileBloc.listBesoins.contains(items)
                          ? AppStyles.listTileTitle
                          : AppStyles.listTileTitleBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        newFileBloc.listBesoins.contains(items)
                            ? newFileBloc.listBesoins
                                .removeWhere((element) => element == items)
                            : newFileBloc.listBesoins.add(items);
                      });
                    },
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
              for (var items in listCompetences)
                Container(
                  decoration: newFileBloc.listCompetences.contains(items)
                      ? ShapeDecoration(
                          shape: const StadiumBorder(),
                          gradient: buttonGradient(),
                        )
                      : const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppColors.white,
                        ),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const StadiumBorder(),
                    child: Text(
                      items,
                      style: newFileBloc.listCompetences.contains(items)
                          ? AppStyles.listTileTitle
                          : AppStyles.listTileTitleBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        newFileBloc.listCompetences.contains(items)
                            ? newFileBloc.listCompetences
                                .removeWhere((element) => element == items)
                            : newFileBloc.listCompetences.add(items);
                      });
                    },
                  ),
                ),
            ],
          ),
        ]);
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: AppColors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            newFileBloc.changeStep(2);
          }, //do something,
          child: Image.asset(
            AppImages.btnRetour,
          ),
        ),
        InkWell(
          splashColor: AppColors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            if (_valid()) {
              newFileBloc.addFileToFireBaseDB();
              Modular.to.popAndPushNamed(Routes.home);
            }
          },
          child: Image.asset(
            _valid() ? AppImages.btnTerminer : AppImages.btnSuivantDisabled,
          ),
        ),
      ],
    );
  }

  bool _valid() {
    return ((newFileBloc.listCompetences.isNotEmpty) &&
        (newFileBloc.listBesoins.isNotEmpty));
  }
}
