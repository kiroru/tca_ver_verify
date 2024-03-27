# tca_ver_verify

[The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture/blob/2722a3466b78860ebf493103fc82ac85b076e1bd/Sources/ComposableArchitecture/Documentation.docc/Articles/MigrationGuides/MigratingTo1.6.md)によるNavigationStack関連の挙動を確認するためのサンプルです。

## 概要

TCA ver 1.9においてNavigationStackを実装すると

```
Perceptible state was accessed but is not being tracked. Track changes to state by wrapping your view in a 'WithPerceptionTracking' view.
```

という警告が出て画面の操作が反映されない。なおこの問題はiOS17以降では発生しない。  
そこでこのリポジトリではver1.6とver1.9の両方のアプリを作成して挙動の違いを確認する。

## TCA ver 1.6

NavigationStackStoreによる挙動を確認できています。  
確認手順は以下の通りです。

1. 以下のコマンドを実行
```
$ git checkout -b v1.6.0 v1.6.0
$ oepn tca_ver_verify/tca_ver_verify.xcodeproj
```
1. アプリを開いて"push nav"をタップする
1. pushでカウンターをincreamentしながらナビゲーションに画面をpushする

### ver1.6で生じる警告について

iOS16でアプリを動作するとカウンターのデモ画面において以下の警告が発せられます。

```
Publishing changes from within view updates is not allowed, this will cause undefined behavior.
```

ただこれは本家のアプリでも同様のことが起こっています。

```
$ git clone git@github.com:pointfreeco/swift-composable-architecture.git
$ git checkout -b 1.6.0 1.6.0
$ open swift-composable-architecture/Examples/CaseStudies/CaseStudies.xcodeproj
```

このアプリでの動作を確認するに異常な挙動を示すものがないため警告として留める。

## TCA ver 1.9

工事中。
