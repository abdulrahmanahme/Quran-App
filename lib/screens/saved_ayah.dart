
import 'package:flutter/material.dart';
import 'package:quran_app/components/build_ayah.dart';
import 'package:quran_app/core/constant_app/constant.dart';
import 'package:quran_app/core/local_Storage/local_storage.dart';
import 'package:quran_app/core/model/model_data.dart';
import 'package:quran_app/components/surah_builder.dart';
class AyahSaved extends StatefulWidget {
  List<AayahModel>? savedAayah;
  bool isLoading = false;
  AayahModel? articlefiled;
  @override
  State<AyahSaved> createState() => _AyahSavedState();
}

class _AyahSavedState extends State<AyahSaved> {
  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  Future refreshNote() async {
    setState(() => widget.isLoading = true);

    this.widget.savedAayah = await AayahDataBase.instance.readAllNotes();

    setState(() => widget.isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isLoading
          ? const  Center(
                  child:CircularProgressIndicator())
          : widget.savedAayah!.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 
                      Text(
                        'لا توجد محفوظات',
                       style: TextStyle(
                color:  Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.8),
          
                      ),
                    ],
                  ),
                )
              : 
              ReorderableListView.builder(itemBuilder:(context,index){
                final ayah=widget.savedAayah![index];
              return buildAyah(index: index, ayahfiled: ayah ,context:context,onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahBuilder(
                          arabic: quran[0],
                          sura: widget.savedAayah![index].bookmarkedSura! - 1,
                          suraName: arabicName[ widget.savedAayah![index].bookmarkedSura! - 1]['name'],
                          ayah:  widget.savedAayah![index].bookmarkedAyah!,
                        )));
              },) ;
              } , itemCount: widget.savedAayah!.length,  onReorder: (oldIndex, newIndex) => setState(() {
             final  ayah =widget.savedAayah!.removeAt(oldIndex);
                widget.savedAayah!.insert(newIndex, ayah );
    
    }),)
            
    );
  }

}


