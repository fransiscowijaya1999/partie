import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/part.dart';

class PartDetailScreen extends StatefulWidget {
  const PartDetailScreen({
    super.key,
    required this.title,
    required this.partId
  });

  final String title;
  final int partId;

  @override
  State<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends State<PartDetailScreen> {
  late Stream<Part> _partStream;

  @override
  void initState() {
    super.initState();

    _partStream = PartRepository.getPartDetailStream(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<Part>(
        stream: _partStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final part = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(part.name),
                      part.description.isNotEmpty ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 250,
                          child: Card(
                            color: Colors.white, 
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: MarkdownBlock(data: part.description),
                              ),
                            ),
                          ),
                        ),
                      ) : SizedBox(height: 10)
                    ]
                  ),
                );
              } else {
                return Center(child: Text('Part not set'),);
              }
          }
        },
      ),
    );
  }
}

