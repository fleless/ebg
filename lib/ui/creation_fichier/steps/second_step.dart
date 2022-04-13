import 'package:ebg/constants/app_images.dart';
import 'package:ebg/constants/styles/app_styles.dart';
import 'package:ebg/ui/creation_fichier/newFile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../constants/app_colors.dart';

class SecondStepScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondStepScreenState();
}

class _SecondStepScreenState extends State<SecondStepScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final newFileBloc = Modular.get<NewFileBloc>();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionTextController.text = newFileBloc.newFiche.description!;
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
        _buildFirstLine(),
        const SizedBox(height: 20),
        _buildDescriptionTextField(),
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
              maxLines: 100),
        ),
        const SizedBox(width: 5),
        InkWell(
          splashColor: AppColors.white.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            newFileBloc.newFiche.description = _descriptionTextController.text;
            newFileBloc.changeStep(1);
          },
          child: const Text("Modifier",
              style: AppStyles.modifierStyle,
              overflow: TextOverflow.clip,
              maxLines: 1),
        ),
      ],
    );
  }

  Widget _buildDescriptionTextField() {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.list_background,
          border: Border.all(color: AppColors.border),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: FormBuilderTextField(
        controller: _descriptionTextController,
        name: 'Description du besoin',
        onChanged: (String? val) => setState(() {}),
        maxLines: null,
        minLines: 8,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          labelText: 'Description du besoin',
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
            newFileBloc.changeStep(1);
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
              newFileBloc.newFiche.description =
                  _descriptionTextController.text;
              newFileBloc.changeStep(3);
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
    return _descriptionTextController.text.trim().isNotEmpty;
  }
}
