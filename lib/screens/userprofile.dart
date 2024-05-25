import 'package:flutter/material.dart';
import 'package:smartibe/screens/registerscreen.dart';
import 'package:smartibe/widgets/profile_widget.dart';
import 'dart:math';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  get auth => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://scontent.xx.fbcdn.net/v/t1.15752-9/296013356_626410899071076_9156769125937142598_n.png?stp=dst-png_p180x540&_nc_cat=101&ccb=1-7&_nc_sid=aee45a&_nc_eui2=AeHRU53Lq-xrY9CiikI8U0-55SpcPHwDEg3lKlw8fAMSDaRsqDSCpfn9eNjdzHwneXBMp7M_fJHhNIg9Sbsv33u9&_nc_ohc=pGMBwKTgZ5sAX_z6aAE&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AVKThvGysrXnNqZjOxwIOgUFoIVInS_6fOQQg-j-is8fSg&oe=631A39BB'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://scontent.xx.fbcdn.net/v/t1.15752-9/298362126_820587202640900_1306351423641681893_n.png?stp=dst-png_p403x403&_nc_cat=103&ccb=1-7&_nc_sid=aee45a&_nc_eui2=AeEV6yq5jZDqzIJ3fT0UQPQHJPnayLcgi2Yk-drItyCLZhxgd-6GBggfgC1GmfvuOFSS2xi1Z_H-4ewz1IGKaglp&_nc_ohc=EjVCO-LyO9YAX_EiI8M&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AVLK1QzIF9iOGedrlgA_okIYaibeLtxLU3roVQ4EvF0_hg&oe=631B9006'),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: size.width * .3,
                child: Row(
                  children: [
                    Text(
                      'SmartiBE',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: size.height * .7,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Email :',
                    ),
                    Text(
                      'Phone number :',
                    ),
                    Text(
                      'Username :',
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text("Log out"),
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    }));
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
