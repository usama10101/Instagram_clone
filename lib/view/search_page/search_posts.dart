import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instagram/view/search_page/search_page.dart';
import 'package:sizer/sizer.dart';

class SearchPosts extends StatelessWidget {
  const SearchPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 6.h),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
          },
          child: Container(
            height: 5.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200
            ),
            child: Row(
              children: [
                SizedBox(width: 2.w,),
                Icon(Iconsax.search_normal_1),
                SizedBox(width: 4.w,),
                Text('Search', style: TextStyle(fontSize: 16.sp),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}