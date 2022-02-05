# godot3-batch-commands
Godot 3 のバッチ処理まとめ

* merge-tileset

## merge-tileset

複数のTileSetを１つにくっつけます。

### 使い方
1. マージ対象は**test_1.tres**, **test_2.tres**のようにファイル名を「同名_半角数字」として、同じディレクトリに入れておきます。  
マージすると **test.tres** ができます。
2. コマンドラインから実行します。  
```godot -s batch/merge_tileset.gd "res://work/merge_tileset/tileset/test" --no-window```
第一引数＝マージ対象のファイルパス　res://からのGodotパスか、OS絶対パスで指定します。
