import 'package:flutter/material.dart';
import 'package:komik/assets/typography.dart';
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
        Text(
          'Aceite a permissão para acesso ao armazenamento',
          style: KomikTypography.base,
          textAlign: TextAlign.center,
        ),
        TextButton(
            onPressed: () {
              debugPrint('Go to Phone Settings');
              openAppSettings();
            },
            child: Text('Ir para configurações',
                style: KomikTypography.action_button))
      ],
    ));
  }
}