import 'package:flutter/material.dart';
import 'package:komik/components/texts/action_button_text.dart';
import 'package:komik/components/texts/base_text.dart';
import 'package:permission_handler/permission_handler.dart';

class AcceptStoragePermission extends StatelessWidget {
  const AcceptStoragePermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BaseText(
          'Aceite a permissão para acesso ao armazenamento',
          textAlign: TextAlign.center,
        ),
        TextButton(
            onPressed: () {
              debugPrint('Go to Phone Settings');
              openAppSettings();
            },
            child: ActionButtonText('Ir para configurações'))
      ],
    ));
  }
}