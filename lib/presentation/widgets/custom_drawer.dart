import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_apps_template/bloc/theme_bloc/theme_bloc.dart';
import 'package:our_apps_template/data/model/user.dart';
import 'package:our_apps_template/presentation/dialogs/language_dialog.dart';
import 'package:our_apps_template/presentation/dialogs/log_out_dialog.dart';
import 'package:our_apps_template/utils/constants/constants.dart';
import '../../utils/extensions/translation_extension.dart';

class CustomDrawer extends StatelessWidget {
  final User userData;

  CustomDrawer(this.userData);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userData.username),
            accountEmail: Text(userData.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(userData.id.toString()),
            ),
            arrowColor: Colors.red,
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return SwitchListTile(
                value: themeState.themeMode == ThemeMode.light ? false : true,
                onChanged: (value) =>
                    context.bloc<ThemeBloc>().add(ThemeChanged(value)),
                title: Text(LanguageKeys.enableDarkMode).translate(context),
              );
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();
              await showDialog(
                context: context,
                builder: (_) => LanguageDialog(),
                barrierDismissible: true,
              );
            },
            title: Text(LanguageKeys.changeLanguage).translate(context),
            trailing: Icon(Icons.language),
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () {},
            title: Text(LanguageKeys.about).translate(context),
            trailing: Icon(Icons.info_outline),
          ),
          Divider(height: 0),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();
              await showDialog(
                context: context,
                builder: (context) => LogOutDialog(),
                barrierDismissible: false,
              );
            },
            title: Text(LanguageKeys.logOut).translate(context),
            trailing: Icon(Icons.exit_to_app),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}
