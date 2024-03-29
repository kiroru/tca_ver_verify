# tca_ver_verify

[The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture/blob/2722a3466b78860ebf493103fc82ac85b076e1bd/Sources/ComposableArchitecture/Documentation.docc/Articles/MigrationGuides/MigratingTo1.6.md)によるNavigationStack関連の挙動を確認するためのサンプルです。

## 概要

TCA ver 1.9においてNavigationStackを実装すると

```
Perceptible state was accessed but is not being tracked. Track changes to state by wrapping your view in a 'WithPerceptionTracking' view.
```

という警告が出て画面の操作が反映されない。なおこの問題はiOS17以降では発生しない。  
そこでこのリポジトリではver1.6とver1.9の両方のアプリを作成して挙動の違いを確認する。

https://github.com/kiroru/tca_ver_verify/assets/83206405/4847f209-3ef4-4449-b082-fa72eb81019a

![スクリーンショット 2024-03-29 14 00 05（3）](https://github.com/kiroru/tca_ver_verify/assets/83206405/196c61e2-5e53-4e4f-91cf-0eac061a7b9b)

## TCA ver 1.6

NavigationStackStoreによる挙動を確認できています。  
確認手順は以下の通りです。

1. 以下のコマンドを実行
```
$ git checkout -b v1.6.0 v1.6.0
$ open tca_ver_verify/tca_ver_verify.xcodeproj
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

NavigationStackによる挙動で不具体を確認できています。
確認手順は以下の通りです。

1. 以下のコマンドを実行
```
$ git checkout -b v1.9.0 v1.9.0
$ open tca_ver_verify/tca_ver_verify.xcodeproj
```

### 不具合

- push navをタップした後のデモ画面でpushをタップしても正常にナビゲーションがプッシュされない
- ナビゲーションによるバックボタンで空白が表示される
- デモ画面のdismissで一つ前の画面に戻りたいが積んでいるスタック全てが全てが破棄される

### 警告

`Perceptible state was accessed but is not being tracke`の警告が出る。  
ただし上記の警告は[ViewStoreのパッチ 136~138行目](https://github.com/kiroru/tca_ver_verify/blob/v1.6.0/tca_ver_verify/tca_ver_verify/ViewStore.swift)を当てることでなくなる。

## iOS17での挙動

TCA ver1.6, ver1.9のいずれにおいてもiOS17以上であれば不具合は生じない。
