import 'package:ebg/constants/app_images.dart';
import 'package:ebg/constants/styles/app_styles.dart';
import 'package:ebg/ui/creation_fichier/newFile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../constants/app_colors.dart';

class FirstStepScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstStepScreenState();
}

class _FirstStepScreenState extends State<FirstStepScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final newFileBloc = Modular.get<NewFileBloc>();
  final TextEditingController _nomPrenomTextController =
      TextEditingController();
  final TextEditingController _posteTextController = TextEditingController();
  final TextEditingController _entrepriseTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomPrenomTextController.text = newFileBloc.newFiche.nomPrenom!;
    _posteTextController.text = newFileBloc.newFiche.poste!;
    _entrepriseTextController.text = newFileBloc.newFiche.entreprise!;
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
      child: Column(children: <Widget>[
        _buildNomPrenomTextField(),
        const SizedBox(height: 20),
        _buildPoste(),
        const SizedBox(height: 20),
        _buildEntreprise(),
        const SizedBox(height: 50),
        _buildButton()
      ]),
    );
  }

  Widget _buildNomPrenomTextField() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.list_background,
          border: Border.all(color: AppColors.border),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: FormBuilderTextField(
        controller: _nomPrenomTextController,
        name: 'nomPrénom',
        onChanged: (String? val) => setState(() {}),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          labelText: 'Nom et Prénom',
          labelStyle: AppStyles.labelTextField,
        ),
        style: AppStyles.listTileTitle,
        // onChanged: _onChanged,
        // valueTransformer: (text) => num.tryParse(text),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.min(context, 1),
        ]),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildPoste() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.list_background,
          border: Border.all(color: AppColors.border),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: FormBuilderTextField(
        controller: _posteTextController,
        name: 'poste',
        onChanged: (String? val) => setState(() {}),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          labelText: 'Poste dans l’entreprise',
          labelStyle: AppStyles.labelTextField,
        ),
        style: AppStyles.listTileTitle,
        // onChanged: _onChanged,
        // valueTransformer: (text) => num.tryParse(text),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.min(context, 1),
        ]),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildEntreprise() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.list_background,
          border: Border.all(color: AppColors.border),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: FormBuilderTextField(
        controller: _entrepriseTextController,
        name: 'entreprise',
        onChanged: (String? val) => setState(() {}),
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          labelText: 'Entreprise',
          labelStyle: AppStyles.labelTextField,
        ),
        style: AppStyles.listTileTitle,
        // onChanged: _onChanged,
        // valueTransformer: (text) => num.tryParse(text),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.min(context, 1),
        ]),
        keyboardType: TextInputType.text,
      ),
    );
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
            Modular.to.pop();
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
              newFileBloc.newFiche.nomPrenom = _nomPrenomTextController.text;
              newFileBloc.newFiche.poste = _posteTextController.text;
              newFileBloc.newFiche.entreprise = _entrepriseTextController.text;
              newFileBloc.changeStep(2);
            }
          }, //do something,
          child: Image.asset(
            _valid()
                ? AppImages.btnSuivantEnabled
                : AppImages.btnSuivantDisabled,
          ),
        ),
      ],
    );
  }

  bool _valid() {
    return ((_nomPrenomTextController.text.trim().isNotEmpty) &&
        (_posteTextController.text.trim().isNotEmpty) &&
        (_entrepriseTextController.text.trim().isNotEmpty));
  }
}
