import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/_base/base_contract.dart';

class ArticleDetailsVMState extends BaseViewModelState {
  late final Article article;
}

abstract class ArticleDetailsViewContract extends BaseViewContract {}

abstract class ArticleDetailsVMContract extends BaseViewModelContract<
    ArticleDetailsVMState, ArticleDetailsViewContract> {
  void tapOnRefreshPage();
}
