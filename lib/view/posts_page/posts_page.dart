import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/view/chat_page/chat_page.dart';
import 'package:instagram/view/chat_page/chat_screen.dart';
import 'package:instagram/view/chat_page/send_message.dart';
import 'package:sizer/sizer.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(
                  height: 5.h, child: Image.asset('assets/instagram.png')),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: 18.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 30,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPage()));
                        },
                        child: Icon(
                          Iconsax.send_2,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }
}