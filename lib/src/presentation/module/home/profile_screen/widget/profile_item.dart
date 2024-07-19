import 'package:flutter/material.dart';
class ProfileItem extends StatelessWidget {
  Widget? icon;
  String profileItemName;
  String profileData;
  ProfileItem({super.key,this.icon,required this.profileItemName,required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
        children: [
          Row(
            children: [
              icon ?? Container(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileItemName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                  Text(
                    '  ${profileData!}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF808080)

                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 5),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          )

        ],
      ),
    );
  }
}