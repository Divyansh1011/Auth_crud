import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/models/post.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Post> _posts;
  List<Post> get posts => _posts;

  Future getPosts() async {
    setBusy(true);
    var postResults = await _firestoreService.getPostsOnceOff();
    if (postResults is List<Post>) {
      _posts = postResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Posts Update Failed',
        description: postResults,
      );
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostViewRoute);
    await getPosts();
  }
}
