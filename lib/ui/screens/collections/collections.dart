import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:skill_branch_flutter/blocs/collection_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';

class CollectionsView extends StatefulWidget {
  CollectionsView(this.collection);

  final Collections collection;

  @override
  State<StatefulWidget> createState() {
    return CollectionsViewState();
  }
}

class CollectionsViewState extends State<CollectionsView> {
  CollectionBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = CollectionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1000,
        child: PagewiseGridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 1,
          pageSize: 12,
          showRetry: false,
          pageFuture: (int pageIndex) async {
            return await userBloc.getCollectionPhotosById(widget.collection.id.toString(), pageIndex + 1);
          },
          itemBuilder: (BuildContext context, FeedNetworkModel data, int index) {
            return buildImage(data);
          },
          errorBuilder: (BuildContext context, Object error) {
            return Container(); // TODO: Add some error widget
          },
          loadingBuilder: (BuildContext context) {
            return CircularProgressIndicator();
          },
          noItemsFoundBuilder: (BuildContext context) {
            return Center(
              child: Text('Нет элементов :('),
            );
          },
        ),
    
    );
  }

  Widget buildImage(FeedNetworkModel entry) {
    final image = Container(
      color: Color(0xFFD2D2D2),
      height: entry.height * MediaQuery.of(context).size.width / entry.width,
      child: CachedNetworkImage(
        imageUrl: entry.urls.regular,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );

    return image;
  }
}
