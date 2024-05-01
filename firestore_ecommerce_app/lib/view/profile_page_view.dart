import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../tools/constants.dart';
import '../view_model/profile_page_view_model.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageViewModel>(
      builder: (context, value, child) {
        if (value.users.isNotEmpty) {
          return Column(
            children: [
              Padding(
                padding: Constants.littlePadding(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 40,
                      child: Text(
                        Constants.getFirstLetter(value.users[2].userName),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.users[2].userName,
                          style: Constants.getNormalTextStyle(18),
                        ),
                        Text(
                          value.users[2].userEmail,
                          style: Constants.productMoneyTextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox(height: 300, child: _buildListView()))
            ],
          );
        } else {
          return const Center(
            child: Text("Profil page"),
          );
        }
      },
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: Constants.profileInfo.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: Constants.littlePadding(),
          child: Card(
            child: ListTile(
              leading: const Icon(
                Icons.arrow_right,
                size: 40,
              ),
              title: Text(Constants.profileInfo[index]),
            ),
          ),
        );
      },
    );
  }
}
