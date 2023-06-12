import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
 final String? lableText;
 final String? hintText;
final  Widget? prefixIcon;
 final Widget? suffixIcon;
 final void Function()? onTap;
 final void Function(String)? onChanged;
final  TextInputType? keyboardType;

 const TextFormWidget(
      {super.key, this.lableText,
      this.hintText,
      this.prefixIcon,
      this.onTap,
      this.suffixIcon,
      this.keyboardType,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          prefixIcon: prefixIcon,
          labelText: lableText,
          hintText: hintText,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:const EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 20,
          ),
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: onTap!,
        onChanged: onChanged!,
      ),
    );
  }
}
class ProfileButton extends StatelessWidget {
  ImageProvider<Object>? icon;
  String? name;
  String? type;
  String? name2;
  String? type2;

  ProfileButton({this.icon, this.name, this.type ,this.name2,this.type2});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 0.2,
              color: Colors.grey,
            ),
            primary: Colors.white,
            // onPrimary: Colors.grey,
    
            padding: EdgeInsets.only(
              top: 10,
              bottom: 9,
            ),
    
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Container(
                height: 70,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(image: icon!, fit: BoxFit.contain),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                   
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          type!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name2!,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                     
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            type2!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}