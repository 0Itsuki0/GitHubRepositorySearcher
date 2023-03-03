# GitHub Repository Searcher

  

## 概要

  

本プロジェクトは株式会社ゆめみの課題のベースプロジェクトを元にアプリを作り上げるプロジェクトです。

  

## アプリ仕様

  

本アプリは GitHub のリポジトリーを検索するアプリです。
![動作イメージ](README_Images/app.gif)


### 環境

- IDE：Xcode 14.0
- Swift：Swift 5.7
- 開発ターゲット：iOS 15.0
- サードパーティーライブラリーの利用：[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)、[SDWebImage](https://github.com/SDWebImage/SDWebImage)


### 基本機能

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名と言語）で表示
3.特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示
