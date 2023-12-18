import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/custom_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    openUrl();
    super.initState();
  }

  openUrl()async{
    Uri urlLink = Uri.parse("https://www.google.com");
    try {
      await launchUrl(urlLink,
          mode: LaunchMode.externalApplication);
      if (!await launchUrl(urlLink,
          mode: LaunchMode.externalApplication)) {
        CustomSnackBar.mySnackBar(
            context, "couldn't launch url");
      }
    } catch (error) {
      throw "could not launch $urlLink url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
