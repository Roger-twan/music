import './event_bus.dart';
import './dio_client.dart';
import '../model/songs_model.dart';

class LikesSong {
  List<SongModel?> _list = [];

  static final LikesSong _instance = LikesSong._internal();
  LikesSong._internal();
  factory LikesSong() => _instance;

  List<SongModel?> getList() => _list;

  Future<void> init() async {
    _list = await _fetchList();
  }

  Future<bool> add(SongModel song) async {
    final response =
        await dioClient().post('/likes/add', data: {'id': song.id});
    final isSuccess = response.data == 'true';

    if (isSuccess) {
      song.like = 1;
      _list.add(song);
      eventBus.fire(LikesSongUpdateEvent(true));
    }

    return isSuccess;
  }

  Future<bool> remove(int id) async {
    final response = await dioClient().post('/likes/remove', data: {'id': id});
    final isSuccess = response.data == 'true';

    if (isSuccess) {
      _list.removeWhere((song) => song?.id == id);
      eventBus.fire(LikesSongUpdateEvent(true));
    }

    return isSuccess;
  }

  Future<List<SongModel?>> _fetchList() async {
    final response = await dioClient().get('/likes/get');
    final data = SongListModel.fromJson(response.data);

    return data.result;
  }
}
