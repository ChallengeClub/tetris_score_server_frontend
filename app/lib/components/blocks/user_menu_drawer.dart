import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../model/user_model.dart';
import '../../view_model/providers.dart';

class UserMenuDrawer extends ConsumerWidget{

  UserMenuDrawer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _state = ref.watch(userLoginStateNotifierProvider);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'User Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          if (_state==null)
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                // showModalBottomSheet(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return Authenticator.builder(
                //     );
                //   },
                // );
                ref.read(userLoginStateNotifierProvider.notifier).signIn();
              },
            )
          else 
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                ref.read(userLoginStateNotifierProvider.notifier).signOut();
              },
            ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Status check'),
            onTap: () {
              ref.read(userLoginStateNotifierProvider.notifier).updateLoginState();
            },
          )        
        ],
      ),
    );
  }
}
