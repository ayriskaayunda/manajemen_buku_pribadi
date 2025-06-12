import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.primary,
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Halo , saya Riska aplikasi ini di ciptakan untuk menyimpan daftar buku. Saya harap Aplikasi yang saya buat ini bisa bermanfaat untuk semua orang',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 14),
            Text(
              " Disini kalian bisa menyimpan berbagai macam buku dan jangan lupa memberi rating nya yaa teman teman.",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 14),
            Text.rich(
              TextSpan(
                text:
                    "© 2025 ListBook. All rights reserved.\nDikembangkan oleh ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "Riskaa",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " menggunakan Flutter",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Text('Versi 1.0.0', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
