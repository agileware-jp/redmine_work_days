# Redmine Work Days Plugin

## イントロダクション

Redmineに個別の休業日の設定を追加するプラグインです。

休業日に設定された日は、Redmine標準の休業日同様に扱われ、ガントチャート上でグレー表示されます。

## 機能

* 管理画面でCSV読み込ませて休業日を設定することができる
* ガントチャート上での休業日を表示することができる  
  休業日を反映するためにはRedmineインスタンスの再起動が必要です。

## インストール方法

```
$ cd [Redmine Root]
$ git clone git@github.com:agileware-jp/redmine_work_days.git plugins/redmine_work_days
$ bundle install
$ bundle exec rake redmine:plugins:migrate NAME=redmine_work_days
```

## アンインストール方法

```
$ cd [Redmine Root]
$ bundle exec rake redmine:plugins:migrate NAME=redmine_work_days VERSION=0
$ rm -rf plugins/redmine_work_days
```

## About

Copyright (c) 2015 [Agileware Inc.](http://agileware.jp) released under the MIT license
