const String tableAayah = 'Ayah';

class AayahFields {
  static final List<String> values = [
    title,
    time,
    bookmarkedAyah,
    bookmarkedSura,
  ];
  static final String title = 'title';
  static final String time = 'time';
  static final String bookmarkedAyah = 'bookmarkedAyah';
  static final String bookmarkedSura= 'bookmarkedSura';



}

class AayahModel {
  final String? title;
  final String? createdTime;
  final int? bookmarkedAyah;
  final int? bookmarkedSura;

  
  


  const AayahModel({
    this.title,
    this.createdTime,
    this.bookmarkedAyah,
    this.bookmarkedSura,
  });

  AayahModel copy({
    int? id,
    String? title,
    String? createdTime,
   int? bookmarkedAyah,
    int? bookmarkedSura,


  }) =>
      AayahModel(
        title: title ?? this.title,
        createdTime: createdTime??this.createdTime,
        bookmarkedAyah:bookmarkedAyah??this.bookmarkedAyah ,
        bookmarkedSura:bookmarkedSura ??this.bookmarkedAyah ,
        
      );

  static AayahModel fromJson(Map<String, Object?> json) => AayahModel(
        title: json[AayahFields.title] as String,
        createdTime: json[AayahFields.time] as String,
        bookmarkedAyah: json[AayahFields.bookmarkedAyah] as int ,
        bookmarkedSura:json[AayahFields.bookmarkedSura] as int ,

      );

  Map<String, Object> toJson() => {
        AayahFields.title: title!,
        AayahFields.time: createdTime!,
        AayahFields.bookmarkedAyah: bookmarkedAyah!,
        AayahFields.bookmarkedSura: bookmarkedSura!,

      };
}
