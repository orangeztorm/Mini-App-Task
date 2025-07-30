import '../models/item_model.dart';
import '../../domain/entities/item.dart';

/// Mock data service for providing dummy data when API is unavailable
class MockDataService {
  static List<ItemModel> getMockItems() {
    return List.generate(50, (index) {
      final id = index + 1;
      return ItemModel(
        id: id,
        title: _getMockTitle(id),
        timestamp: DateTime.now().subtract(Duration(days: id % 30)),
        tag: _getTagForId(id),
        isFavorite: false,
      );
    });
  }

  static String _getMockTitle(int id) {
    final titles = [
      'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
      'qui est esse',
      'ea molestias quasi exercitationem repellat qui ipsa sit aut',
      'eum et est occaecati',
      'nesciunt quas odio',
      'dolorem eum magni eos aperiam quia',
      'magnam facilis autem',
      'dolorem dolore est ipsam',
      'nesciunt iure omnis dolorem tempora et accusantium',
      'optio molestias id quia eum',
      'et ea vero quia laudantium autem',
      'in quibusdam tempore odit est dolorem',
      'dolorum ut in voluptas mollitia et saepe quo animi',
      'voluptatem eligendi optio',
      'eveniet quod temporibus',
      'sint suscipit perspiciatis velit dolorum rerum ipsa laboriosam odio',
      'fugit voluptas sed molestias voluptatem provident',
      'voluptate et itaque volupta',
      'adipisci placeat illum aut reiciendis qui',
      'doloribus ad provident suscipit at',
      'asperiores ea ipsam voluptatibus modi minima quia sint',
      'dolor sint quo a velit explicabo quia nam',
      'maxime id vitae nihil numquam',
      'autem hic labore sunt dolores incidunt',
      'rem alias distinctio quo quis',
      'est et quae odit qui non',
      'quasi id et eos tenetur aut quo autem',
      'delectus ullam et corporis nulla voluptas sequi',
      'iusto eius quod necessitatibus culpa ea',
      'a quo magni similique perferendis',
      'ullam ut quidem id aut vel consequuntur',
      'doloremque illum aliquid sunt',
      'qui explicabo molestiae dolorem',
      'magnam ut rerum iure',
      'id nihil consequatur molestias animi provident',
      'fuga nam accusamus voluptas reiciendis itaque',
      'provident vel ut sit ratione est',
      'explicabo et eos deleniti accusantium autem',
      'eos dolorem iste accusantium est eaque quam',
      'enim quo cumque',
      'non est facere',
      'commodi ullam sint et excepturi error explicabo praesentium voluptas',
      'eligendi iste nostrum consequuntur adipisci praesentium sit beatae',
      'optio dolor molestias sit',
      'ut numquam possimus omnis eius et quae accusantium',
      'tenetur sint suscipit et fugiat eos voluptates',
      'fugit voluptas sed molestias voluptatem provident',
      'voluptate et itaque volupta tempore',
      'adipisci placeat illum aut reiciendis qui voluptates',
      'doloribus ad provident suscipit at voluptatibus',
    ];
    return titles[(id - 1) % titles.length];
  }

  static ItemTag _getTagForId(int id) {
    final tags = ItemTag.values;
    return tags[id % tags.length];
  }
}
