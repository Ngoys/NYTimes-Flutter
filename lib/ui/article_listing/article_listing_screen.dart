import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nytimes/modal/article.dart';
import 'package:nytimes/state/article_listing/article_listing_cubit.dart';
import 'package:nytimes/state/article_listing/article_listing_state.dart';
import 'package:nytimes/state/network/network_cubit.dart';
import 'package:nytimes/state/network/network_state.dart';
import 'package:nytimes/utils/context_extension.dart';

class ArticleListingScreen extends StatefulWidget {
  const ArticleListingScreen({super.key});

  static const String route = '/article_listing';

  @override
  State<ArticleListingScreen> createState() => _ArticleListingScreenState();
}

class _ArticleListingScreenState extends State<ArticleListingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.localization.titleLandingScreen),
        ),
        body: const SizedBox.shrink());
  }
}
