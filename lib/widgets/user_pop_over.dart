import 'package:cv_shift/repo/state_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';

import '../pages/set_account_page.dart';
import 'liquid_button.dart';
import 'liquid_container.dart';

class UserPopOver extends ConsumerWidget {
  const UserPopOver({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final account = ref.watch(accountProvider).value;
    return LiquidButton(
      width: 50,
      height: 50,
      buttonIcon: CupertinoIcons.person,
      onTap: () async {
        showPopover(
          context: context,
          width: 300,
          height: 300,
          barrierColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          bodyBuilder: (ctx) => LiquidContainer(
            borderRadius: 30,
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  maxLines: 1,

                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    LiquidContainer(
                      height: 70,
                      width: 70,
                      borderRadius: 100,
                      child: Icon(CupertinoIcons.person),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            account?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Text(
                          account?.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Spacer(),
                LiquidButton(
                  width: double.maxFinite,
                  height: 50,
                  buttonText: 'Edit',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => SetAccountPage(account: account),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                LiquidButton(
                  width: double.maxFinite,
                  height: 50,
                  buttonText: 'Log Out',
                  buttonIcon: Icons.logout,
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
