import 'package:flutter/material.dart';

import 'package:jobber/src/core/models/position.dart';
import 'package:jobber/src/ui/components/loading_transition.dart';

import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PositionDetails extends StatelessWidget {
  PositionDetails({
    this.title,
    this.id,
  });

  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Position>(
      builder: (_) => Position(id),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Position'),
        ),
        body: LoadingTransition(
          duration: Duration(milliseconds: 500),
          child: Consumer<Position>(
            builder: (context, model, child) {
              if (model.description == null) {
                model.getPosition();
              }
              if (model.isLoading) {
                return _loading();
              } else {
                return _body(context, model);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, Position position) {
    return Center(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              position.title,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
            title: Text(position.company),
            subtitle: Text(position.location),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              position.type,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
          Divider(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: MarkdownBody(data: position.description),
          ),
          Divider(height: kToolbarHeight),
          Card(
            elevation: 0.0,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            color: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: MarkdownBody(data: position.howToApply),
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}