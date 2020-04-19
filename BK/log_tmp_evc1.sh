#!/usr/bin/bash

set -e
trap 'echo ログファイル退避に失敗しました。' ERR

select data in fais2 docomo eastwest
#doからdoneまでループ処理
do
    declare CURRENT_DIR=/c/Users/harak/OneDrive/デスクトップ/test
    declare directory=logbk_`date "+%Y%m%d"`_${data}_`date "+%H%M"`
    
    # 全てのログファイルを配列格納
    declare logs=(${CURRENT_DIR}/*.log)
   
    # ログ退避(ログファイルが存在しない場合はなにもしない)
    if [ ${logs} = "/c/Users/harak/OneDrive/デスクトップ/test/*.log" ]; then
        echo "退避するログファイルはありませんでした。"
        break
    else
        # ログ退避用ディレクトリ作成
        mkdir ${CURRENT_DIR}/${directory}
        echo "${directory}を作成しました。"
        
        # ログ退避処理
        mv ${logs[@]} ${CURRENT_DIR}/${directory}
        echo "ログファイルを${directory}に退避しました。"
        break
    fi
done
