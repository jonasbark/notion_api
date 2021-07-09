import 'package:notion_api/notion/blocks/bulleted_list_item.dart';
import 'package:notion_api/notion/blocks/paragraph.dart';
import 'package:notion_api/notion/general/rich_text.dart';
import 'package:notion_api/notion/general/types/notion_types.dart';
import 'package:notion_api/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('BulletedListItem tests =>', () {
    test('Create an empty instance', () {
      BulletedItem block = BulletedItem();

      expect(block, isNotNull);
      expect(block.strType, blockTypeToString(BlockTypes.BulletedListItem));
      expect(block.content, allOf([isList, isEmpty]));
      expect(block.children, allOf([isList, isEmpty]));
      expect(block.isBulletedItem, true);
      expect(block.type, BlockTypes.BulletedListItem);
    });

    test('Create an instance with information', () {
      BulletedItem block = BulletedItem(text: Text('A')).addText('B');

      expect(block.content.length, 2);
      expect(block.content.first.text, 'A');
      expect(block.content.last.text, 'B');
    });

    test('Create an instance with mixed information', () {
      BulletedItem block = BulletedItem(
        text: Text('first'),
        texts: [
          Text('foo'),
          Text('bar'),
        ],
      ).addText('last').addChild(Paragraph(texts: [
            Text('A'),
            Text('B'),
          ]));

      expect(block.content.length, 4);
      expect(block.content.first.text, 'first');
      expect(block.content.last.text, 'last');
      expect(block.children.length, 1);
    });

    test('Create json from instance', () {
      Map<String, dynamic> json = BulletedItem(text: Text('A'))
          .addChild(Paragraph(texts: [
            Text('A'),
            Text('B'),
          ]))
          .toJson();

      expect(
          json['type'],
          allOf([
            isNotNull,
            isNotEmpty,
            blockTypeToString(BlockTypes.BulletedListItem)
          ]));
      expect(json, contains(blockTypeToString(BlockTypes.BulletedListItem)));
      expect(json[blockTypeToString(BlockTypes.BulletedListItem)]['text'],
          allOf([isList, isNotEmpty]));
      expect(json[blockTypeToString(BlockTypes.BulletedListItem)]['children'],
          allOf([isList, isNotEmpty]));
    });

    test('Create json from empty instance', () {
      Map<String, dynamic> json = BulletedItem().toJson();

      expect(
          json['type'],
          allOf([
            isNotNull,
            isNotEmpty,
            blockTypeToString(BlockTypes.BulletedListItem)
          ]));
      expect(json, contains(blockTypeToString(BlockTypes.BulletedListItem)));
      expect(json[blockTypeToString(BlockTypes.BulletedListItem)]['text'],
          allOf([isList, isEmpty]));
      expect(json[blockTypeToString(BlockTypes.BulletedListItem)]['children'],
          allOf([isList, isEmpty]));
    });
  });
}