## 钱包助记词恢复

如果你的钱包有一个单词丢失，可以用这个脚本来恢复。

使用：

```
> bundle install
> bundle exec ruby lib/recover.rb [丢失单词的位置] [其他助记词]
```

加入说我的完整助记词是：

```
recipe hedgehog spirit trip argue bachelor outer trick drill frown people drive cook link simple next nation peasant kangaroo fitness grain fancy other farm
```

但是我丢失了第 _2_ 个助记词（忘记或者拼错），手上只有

```
recipe spirit trip argue bachelor outer trick drill frown people drive cook link simple next nation peasant kangaroo fitness grain fancy other farm
```

那通过以下命令恢复：

```
bundle exec ruby lib/recover.rb 2 recipe spirit trip argue bachelor outer trick drill frown people drive cook link simple next nation peasant kangaroo fitness grain fancy other farm
```
