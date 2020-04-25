#!/usr/bin/bash

set -e
trap 'echo ログファイル退避に失敗しました。' ERR

declare CURRENT_DIR=/data/bambi/log
declare logs=(${CURRENT_DIR}/*.log) # 全てのログファイルを配列格納

# ログ退避(ログファイルが存在しない場合はなにもしない)
if [ ${logs} = "/data/bambi/log/*.log" ]; then
    echo "退避するログファイルはありませんでした。"
    break
else
    # all_Performance_d_ew ：性能試験用関戸さんデータ（ドコモ/東西）
    select data in fais2 fais5 docomo eastwest all_Performance_d_ew # データ選択
    do #doからdoneまでループ処理
        declare directory=logbk_`date "+%Y%m%d"`_${data}_`date "+%H%M"`

        # ログ退避用ディレクトリ作成
        mkdir ${CURRENT_DIR}/${directory}
        echo "${directory}を作成しました。"
        
        # ログ退避処理
        mv ${logs[@]} ${CURRENT_DIR}/${directory}
        echo "ログファイルを${directory}に退避しました。"
        break
    done
fi
