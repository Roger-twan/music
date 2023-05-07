import 'package:flutter/material.dart';
import '../../model/songs_model.dart';
import '../../provider/dio_client.dart';
import '../../provider/event_bus.dart';
import 'result_song_card.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future<SongListModel>? _searchSongs;
  List<SongModel> _list = [];
  String _searchKeywords = '';
  int _page = 1;
  String _source = 'storage';
  bool _isSearchEnd = false;

  Future<SongListModel> searchSongs() async {
    final response = await dioClient().get('/song/search', queryParameters: {
      'keywords': _searchKeywords,
      'source': _source,
      'page': _page
    });

    return SongListModel.fromJson(response.data);
  }

  void triggerSearch() {
    setState(() {
      _searchSongs = searchSongs();
    });
  }

  void initSearch() {
    _list = [];
    _page = 1;
    _source = 'storage';
    _isSearchEnd = false;
  }

  Future<void> setPageSource(List data) async {
    if (data.isEmpty) {
      if (_source == 'storage') {
        _source = 'netease';
      } else if (_source == 'netease') {
        _isSearchEnd = true;
      }

      if (!_isSearchEnd) {
        await Future.delayed(const Duration(milliseconds: 10));
        triggerSearch();
      }
    } else {
      _page++;
    }
  }

  @override
  void initState() {
    super.initState();

    eventBus.on<SearchEvent>().listen((event) {
      final String text = event.keywords;
      if (text.isNotEmpty && text != _searchKeywords) {
        initSearch();
        _searchKeywords = text;
        triggerSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 10, 6, 10),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<SongListModel>(
                future: _searchSongs,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<SongModel?> data = snapshot.data!.result;
                    for (var element in data) {
                      _list.add(element!);
                    }

                    setPageSource(data);
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return ListView(children: [
                    if (_list.isNotEmpty)
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 64,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 30,
                            crossAxisCount:
                                (MediaQuery.of(context).size.width ~/ 300)
                                    .toInt(),
                          ),
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ResultSongCard(song: _list[index]);
                          }),
                    if (snapshot.connectionState == ConnectionState.done &&
                        !_isSearchEnd)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: OutlinedButton(
                                onPressed: () {
                                  triggerSearch();
                                },
                                child: const Text('Search More')),
                          ),
                        ],
                      ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: CircularProgressIndicator(
                                color: Colors.grey[800]),
                          )
                        ],
                      )
                  ]);
                }),
          ),
        ],
      ),
    );
  }
}
