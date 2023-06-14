
import 'package:flutter/material.dart';
import 'package:quran_app/core/model/model_data.dart';

Widget buildAyah({required int index ,required AayahModel? ayahfiled ,context,void Function()? onTap}){
 return InkWell(
          key: ValueKey(ayahfiled),

  onTap:onTap,
   child: Card(
          color: Theme.of(context).appBarTheme.backgroundColor,
          shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    // height: 50,
                    // width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                     
                    ),
                    child: Text(
                           ayahfiled!.title!,
                           textAlign: TextAlign.right,
                            style:const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
 );
}