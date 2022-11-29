import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_management/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    log(userProvider.accessToken);
    return Container();
  }
}
